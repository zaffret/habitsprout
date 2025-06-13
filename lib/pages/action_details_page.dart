import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:habit_sprout1/services/firebase_service.dart';
import '../models/action_model.dart';

class ActionDetails extends StatefulWidget {
  final GreenAction action;

  final LocalUser? user;

  const ActionDetails({required this.action, required this.user, super.key});

  @override
  _ActionDetailsState createState() => _ActionDetailsState();
}

class _ActionDetailsState extends State<ActionDetails> {
  int tally2 = 0;
  final FirebaseService _firebaseService = FirebaseService();

  @override
  void initState() {
    super.initState();
    _checkFavoriteStatus();
    getSameActionTally(widget.action.id).then((value) {
      setState(() {
        tally2 = value;
      });
    });
  }

  bool isFavorite = false;

  Future<void> _checkFavoriteStatus() async {
    try {
      String userId = widget.user!.id;
      bool isFav = await _firebaseService.isFavorite(widget.action.id, userId);
      setState(() {
        isFavorite = isFav;
      });
    } catch (e) {
      print("Error checking favorite status: $e");
    }
  }

  getSameActionTally(String actionId) async {
    String userId = widget.user!.id;
    SameActionTally tally = await _firebaseService
        .getSameActionTallyForCurrentDate(actionId, userId);

    return tally.tally;
  }

  Future<void> _toggleFavorite() async {
    String userId = widget.user!.id;
    try {
      if (isFavorite) {
        await _firebaseService.removeFromFavorite(widget.action.id, userId);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Action removed from favorites!'),
            duration: Duration(seconds: 1),
          ),
        );
      } else {
        await _firebaseService.addToFavorite(widget.action.id, userId);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Action added to favorites!'),
            duration: Duration(seconds: 1),
          ),
        );
      }
      setState(() {
        isFavorite = !isFavorite;
      });
    } catch (e) {
      print("Error toggling favorite: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Failed to toggle favorite. Please try again.'),
          duration: Duration(seconds: 1),
        ),
      );
    }
  }

  Future<void> logAction(String actionId, String userId, num co2, num water,
      num energy, num points) async {
    try {
      await FirebaseFirestore.instance.collection('userActions').add({
        'actionId':
            FirebaseFirestore.instance.collection('actions').doc(actionId),
        'userId': FirebaseFirestore.instance.collection('users').doc(userId),
        'timestamp': FieldValue.serverTimestamp(),
      });

      final userRef =
          FirebaseFirestore.instance.collection('users').doc(userId);

      DocumentSnapshot userDoc = await userRef.get();
      if (userDoc.exists) {
        num currentCO2 = userDoc['co2'] ?? 0;
        num currentWater = userDoc['water'] ?? 0;
        num currentEnergy = userDoc['energy'] ?? 0;
        num currentTally = userDoc['tally'] ?? 0;
        num currentPoints = userDoc['points'] ?? 0;

        await userRef.update({
          'co2': currentCO2 + co2,
          'water': currentWater + water,
          'energy': currentEnergy + energy,
          'tally': currentTally + 1,
          'points': currentPoints + points,
        });
      }

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Action logged successfully!'),
          duration: Duration(seconds: 1),
        ),
      );

      await Future.delayed(const Duration(seconds: 1));
      Navigator.of(context).pop();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Failed to log action. Please try again.'),
          duration: Duration(seconds: 1),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  height: 500,
                  alignment: Alignment.center,
                  child: Column(
                    children: [
                      const SizedBox(height: 20),
                      Container(
                        width: 121,
                        height: 118,
                        decoration: BoxDecoration(
                          color: widget.action.categoryColor,
                          borderRadius: BorderRadius.circular(14),
                        ),
                        child: Image.asset(
                          widget.action.imageUrl,
                          fit: BoxFit.cover,
                        ),
                      ),
                      const SizedBox(height: 10),
                      const Text(
                        "ACTION",
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        widget.action.name,
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Container(
                        width: 69,
                        height: 30,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(14),
                          color: widget.action.categoryColor,
                        ),
                        child: Text(
                          widget.action.category,
                          style: const TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w700,
                              color: Color.fromRGBO(33, 47, 85, 1)),
                        ),
                      ),
                      const SizedBox(height: 10),
                      SizedBox(
                        width: 48,
                        height: 40,
                        child: Stack(
                          children: [
                            Image.asset('assets/images/Group 102.png'),
                            Positioned(
                              top: 0,
                              left: 0,
                              child: Container(
                                padding: const EdgeInsets.all(4),
                                child: Text(
                                  '${widget.action.points}',
                                  style: const TextStyle(
                                    color: Color.fromRGBO(33, 47, 85, 1),
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),
                      Text(
                        widget.action.description,
                        style: const TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 30),
                Container(
                  alignment: Alignment.centerLeft,
                  child: const Row(
                    children: [
                      SizedBox(width: 5),
                      Text(
                        "IMPACT OF YOUR ACTION",
                        style: TextStyle(
                          fontWeight: FontWeight.w800,
                          fontSize: 17,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    if (widget.action.co2 != 0) ...[
                      const SizedBox(width: 5),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(14),
                        ),
                        alignment: Alignment.center,
                        height: 74,
                        width: 160,
                        child: Row(
                          children: [
                            const SizedBox(width: 5),
                            Image.asset(
                              'assets/images/Carbon_foot_print_green.png',
                              width: 56,
                              height: 64,
                              fit: BoxFit.fill,
                            ),
                            const SizedBox(width: 15),
                            Text(
                              '${widget.action.co2}kg\nof CO₂e\nsaved',
                              style: const TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                                color: Colors.green,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                    ],
                    if (widget.action.water != 0) ...[
                      const SizedBox(width: 5),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(14),
                        ),
                        alignment: Alignment.center,
                        height: 74,
                        width: 160,
                        child: Row(
                          children: [
                            const SizedBox(width: 5),
                            Image.asset(
                              'assets/images/water-drop-icon.png',
                              width: 56,
                              height: 64,
                              fit: BoxFit.fill,
                            ),
                            const SizedBox(width: 15),
                            Text(
                              '${widget.action.water}L\nof water\nsaved',
                              style: const TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                                color: Colors.blue,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                    ],
                    if (widget.action.energy != 0) ...[
                      const SizedBox(width: 5),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(14),
                        ),
                        alignment: Alignment.center,
                        height: 74,
                        width: 160,
                        child: Row(
                          children: [
                            const SizedBox(width: 5),
                            Image.asset(
                              'assets/images/4023885_battery_electric_energy_storage_icon.png',
                              width: 56,
                              height: 64,
                              fit: BoxFit.fill,
                            ),
                            const SizedBox(width: 15),
                            Text(
                              '${widget.action.energy}kWhr\nof energy\nsaved',
                              style: const TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                                color: Colors.orange,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ],
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(height: 10),
                  Text(
                    'You have logged this action \t\t\t\t$tally2/${widget.action.cap} times.',
                    style: const TextStyle(
                        fontSize: 15, fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 10),
                  if (tally2 < widget.action.cap)
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: const Color.fromRGBO(33, 47, 85, 1),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        fixedSize: const Size(357, 57),
                        elevation: 5,
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      ),
                      onPressed: () {
                        logAction(
                            widget.action.id,
                            widget.user!.id,
                            widget.action.co2,
                            widget.action.water,
                            widget.action.energy,
                            widget.action.points);
                      },
                      child: const Center(
                        child: Text(
                          'LOG',
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 19,
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.topRight,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: IconButton(
                icon: Icon(
                  isFavorite ? Icons.favorite : Icons.favorite_border,
                  color: isFavorite ? Colors.red : Colors.grey,
                ),
                onPressed: _toggleFavorite,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
