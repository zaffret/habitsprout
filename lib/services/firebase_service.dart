import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:habit_sprout1/models/action_model.dart';
import 'package:intl/intl.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:path/path.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FirebaseService {
  final GoogleSignIn _googleSignIn = GoogleSignIn(
    clientId:
        '914641984001-4ud8jf2nctlf14l5dnohv1spud9ql7l0.apps.googleusercontent.com',
  );

  Future<String?> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) {
        return null;
      }

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final UserCredential userCredential =
          await FirebaseAuth.instance.signInWithCredential(credential);

      bool userExists = await checkUserExists(userCredential.user?.uid);
      if (!userExists) {
        await addUser(userCredential, googleUser.displayName ?? 'Anonymous');
      }

      saveLoginState(true);

      return "Google sign-in successful";
    } catch (e) {
      print("Error during Google sign-in: $e");
      return "Error during Google sign-in: $e";
    }
  }

  Future<bool> checkUserExists(String? userId) async {
    if (userId == null) return false;
    DocumentSnapshot userDoc =
        await FirebaseFirestore.instance.collection('users').doc(userId).get();
    return userDoc.exists;
  }

  Future<void> saveLoginState(bool isLoggedIn) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLoggedIn', isLoggedIn);
  }

  Future<bool> checkLoginState() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool('isLoggedIn') ?? false;
  }

  Future<UserCredential> register(String email, String password) async {
    return await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password);
  }

  Future<void> addUser(UserCredential userCredential, String name) async {
    User? user = userCredential.user;

    if (user != null) {
      String userId = user.uid;

      await FirebaseFirestore.instance.collection('users').doc(userId).set({
        'name': name,
        'imageUrl':
            "https://firebasestorage.googleapis.com/v0/b/habitsprout.appspot.com/o/images%2Fdummy-profile-pic-300x300-1.png?alt=media&token=d845a443-6c00-4d65-b265-571d89824efd",
        'co2': 0.0,
        'co2Fp': 0.0,
        'energy': 0.0,
        'energyFp': 0.0,
        'points': 0,
        'tally': 0,
        'waste': 0.0,
        'water': 0.0,
        'waterFp': 0.0,
      });
    }
  }

  Future<UserCredential> login(email, password) {
    return FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password);
  }

  Future<void> forgotPassword(email) {
    return FirebaseAuth.instance.sendPasswordResetEmail(email: email);
  }

  Stream<User?> getAuthUser() {
    return FirebaseAuth.instance.authStateChanges();
  }

  Future<void> logOut() {
    saveLoginState(false);
    return FirebaseAuth.instance.signOut();
  }

  User? getCurrentUser() {
    return FirebaseAuth.instance.currentUser;
  }

  Stream<List<GreenAction>> getActions() {
    return FirebaseFirestore.instance
        .collection('actions')
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => GreenAction(
                  id: doc.id,
                  name: doc['name'],
                  description: doc['description'],
                  imageUrl: doc['imageUrl'],
                  category: doc['category'],
                  categoryColor: _parseColor(doc['category color']),
                  co2: doc['co2'],
                  water: doc['water'],
                  energy: doc['energy'],
                  points: doc['points'],
                  cap: doc['cap'],
                ))
            .toList());
  }

  Color _parseColor(String colorString) {
    switch (colorString) {
      case 'yellow':
        return Colors.yellow;
      case 'cyanAccent':
        return Colors.cyanAccent;
      case 'lime':
        return Colors.lime;
      case 'blue':
        return Colors.blue;
      case 'orange':
        return Colors.orange;
      case 'purple.shade100':
        return Colors.purple.shade100;
      case 'purple.shade300':
        return Colors.purple.shade300;
      default:
        return Colors.black;
    }
  }

  Stream<LocalUser> getUser(String userId) {
    return FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .snapshots()
        .map((doc) => LocalUser(
              id: doc.id,
              name: doc['name'],
              points: doc['points'],
              imageUrl: doc['imageUrl'],
              co2: doc['co2'],
              water: doc['water'],
              energy: doc['energy'],
              co2Footprint: doc['co2Fp'],
              waterFootprint: doc['waterFp'],
              energyFootprint: doc['energyFp'],
              foodWaste: doc['waste'],
              tally: doc['tally'],
            ));
  }

  Future<void> updatePhoto(String imageUrl, String userId) {
    return FirebaseFirestore.instance
        .collection("users")
        .doc(userId)
        .update({"imageUrl": imageUrl});
  }

  Future<String?> addReceiptPhoto(File receiptPhoto) {
    return FirebaseStorage.instance
        .ref()
        .child('${DateTime.now()}_${basename(receiptPhoto.path)}')
        .putFile(receiptPhoto)
        .then((task) {
      return task.ref.getDownloadURL().then((imageUrl) {
        return imageUrl;
      });
    });
  }

  Future<void> logAction(String actionId, String userId) {
    return FirebaseFirestore.instance.collection('userActions').add({
      'actionId':
          FirebaseFirestore.instance.collection('actions').doc(actionId),
      'userId': FirebaseFirestore.instance.collection('users').doc(userId),
      'timestamp': FieldValue.serverTimestamp(),
    });
  }

  Future<void> addToFavorite(String actionId, String userId) {
    return FirebaseFirestore.instance.collection('favorites').add({
      'actionId':
          FirebaseFirestore.instance.collection('actions').doc(actionId),
      'userId': FirebaseFirestore.instance.collection('users').doc(userId),
    });
  }

  Future<void> removeFromFavorite(String actionId, String userId) async {
    QuerySnapshot<Map<String, dynamic>> querySnapshot = await FirebaseFirestore
        .instance
        .collection('favorites')
        .where('actionId',
            isEqualTo:
                FirebaseFirestore.instance.collection('actions').doc(actionId))
        .where('userId',
            isEqualTo:
                FirebaseFirestore.instance.collection('users').doc(userId))
        .get();

    for (var doc in querySnapshot.docs) {
      doc.reference.delete();
    }
  }

  Stream<List<Favorite>> getFavoritesByUserId(String userId) {
    return FirebaseFirestore.instance
        .collection('favorites')
        .where('userId',
            isEqualTo:
                FirebaseFirestore.instance.collection('users').doc(userId))
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => Favorite(
                  id: doc.id,
                  userId: doc['userId'],
                  actionId: doc['actionId'],
                ))
            .toList());
  }

  Future<bool> isFavorite(String actionId, String userId) async {
    QuerySnapshot<Map<String, dynamic>> querySnapshot = await FirebaseFirestore
        .instance
        .collection('favorites')
        .where('actionId',
            isEqualTo:
                FirebaseFirestore.instance.collection('actions').doc(actionId))
        .where('userId',
            isEqualTo:
                FirebaseFirestore.instance.collection('users').doc(userId))
        .get();

    return querySnapshot.size > 0;
  }

  Future<SameActionTally> getSameActionTallyForCurrentDate(
      String actionId, String userId) async {
    DateTime currentDate = DateTime.now();

    DateTime startDate =
        DateTime(currentDate.year, currentDate.month, currentDate.day, 0, 0, 0);
    DateTime endDate = DateTime(
        currentDate.year, currentDate.month, currentDate.day, 23, 59, 59);

    Timestamp startTimestamp = Timestamp.fromDate(startDate);
    Timestamp endTimestamp = Timestamp.fromDate(endDate);

    DocumentReference actionRef =
        FirebaseFirestore.instance.collection('actions').doc(actionId);

    DocumentReference userRef =
        FirebaseFirestore.instance.collection('users').doc(userId);

    QuerySnapshot<Map<String, dynamic>> querySnapshot = await FirebaseFirestore
        .instance
        .collection('userActions')
        .where('actionId', isEqualTo: actionRef)
        .where('userId', isEqualTo: userRef)
        .where('timestamp', isGreaterThanOrEqualTo: startTimestamp)
        .where('timestamp', isLessThanOrEqualTo: endTimestamp)
        .get();

    int tally = querySnapshot.size;

    return SameActionTally(tally: tally);
  }

  Stream<List<GreenAction>> getFavoriteActionsByUserId(String userId) {
    return getFavoritesByUserId(userId).asyncMap((favoriteActions) async {
      if (kDebugMode) print('Favorite actions: $favoriteActions');
      List<GreenAction> favoriteGreenActions = [];

      for (var favoriteAction in favoriteActions) {
        if (kDebugMode) {
          print('Favorite action: ${favoriteAction.actionId.path}');
        }

        DocumentSnapshot<Map<String, dynamic>> actionSnapshot =
            await FirebaseFirestore.instance
                .doc(favoriteAction.actionId.path)
                .get();

        if (actionSnapshot.exists) {
          favoriteGreenActions.add(GreenAction(
            id: actionSnapshot.id,
            name: actionSnapshot['name'],
            description: actionSnapshot['description'],
            imageUrl: actionSnapshot['imageUrl'],
            category: actionSnapshot['category'],
            categoryColor: _parseColor(actionSnapshot['category color']),
            co2: actionSnapshot['co2'],
            water: actionSnapshot['water'],
            energy: actionSnapshot['energy'],
            points: actionSnapshot['points'],
            cap: actionSnapshot['cap'],
          ));
        }
      }

      return favoriteGreenActions;
    });
  }

  Stream<List<DailyActionRecord>> getDailyActionRecords(String userId) {
    DateTime date = DateTime.now();
    DateTime startDate = DateTime(date.year, date.month, date.day, 0, 0, 0);
    DateTime endDate = DateTime(date.year, date.month, date.day, 23, 59, 59);

    return FirebaseFirestore.instance
        .collection('userActions')
        .where('userId', isEqualTo: userId)
        .where('timestamp', isGreaterThanOrEqualTo: startDate)
        .where('timestamp', isLessThan: endDate)
        .snapshots()
        .asyncMap((snapshot) async {
      List<DailyActionRecord> dailyRecords = [];

      if (kDebugMode) {
        print('Daily action records for user $userId: ${snapshot.docs}');
      }

      for (QueryDocumentSnapshot userActionDoc in snapshot.docs) {
        DocumentSnapshot actionDoc = await userActionDoc.get('actionId');

        if (kDebugMode) print('Action doc: ${actionDoc.data()}');

        if (actionDoc.exists) {
          Timestamp timestamp = userActionDoc['timestamp'];

          String formattedTimestamp =
              DateFormat('HH:mm, dd MMM yyyy').format(timestamp.toDate());

          dailyRecords.add(DailyActionRecord(
            timestamp: formattedTimestamp,
            name: actionDoc['name'],
            imageUrl: actionDoc['imageUrl'],
            category: actionDoc['category'],
            categoryColor: _parseColor(actionDoc['category color']),
          ));
        } else {
          print(
              "Error: Action document not found for id: ${userActionDoc['actionId']}");
        }
      }

      return dailyRecords;
    });
  }

  Future<int> dailyActionCount(String userId) async {
    DateTime currentDate = DateTime.now();

    DateTime startDate =
        DateTime(currentDate.year, currentDate.month, currentDate.day, 0, 0, 0);
    DateTime endDate = DateTime(
        currentDate.year, currentDate.month, currentDate.day, 23, 59, 59);

    Timestamp startTimestamp = Timestamp.fromDate(startDate);
    Timestamp endTimestamp = Timestamp.fromDate(endDate);

    DocumentReference userRef =
        FirebaseFirestore.instance.collection('users').doc(userId);

    QuerySnapshot<Map<String, dynamic>> querySnapshot = await FirebaseFirestore
        .instance
        .collection('userActions')
        .where('userId', isEqualTo: userRef)
        .where('timestamp', isGreaterThanOrEqualTo: startTimestamp)
        .where('timestamp', isLessThanOrEqualTo: endTimestamp)
        .get();

    int tally = querySnapshot.size;

    return tally;
  }
}
