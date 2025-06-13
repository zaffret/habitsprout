import "package:flutter/material.dart";
import "package:get_it/get_it.dart";
import "package:habit_sprout1/models/action_model.dart";
import "package:habit_sprout1/pages/actions.dart";
import "package:habit_sprout1/pages/challenges.dart";
import "package:habit_sprout1/pages/home.dart";
import "package:habit_sprout1/pages/profile.dart";
import "package:habit_sprout1/pages/tips.dart";
import "package:habit_sprout1/services/firebase_service.dart";

class HomeScreen extends StatefulWidget {
  static const routeName = '/home';
  LocalUser? user;
  num? level;

  HomeScreen({super.key, required this.user, required this.level});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  FirebaseService fbService = GetIt.instance<FirebaseService>();
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final user = widget.user;
    final level = widget.level;

    String title;
    String badge;

    if (level == 1) {
      title = "The Seed";
      badge = 'assets/images/_d0338b2f-6321-4de2-8fff-47d538a65b66.jpeg';
    } else if (level == 2) {
      title = "The Sprout";
      badge = 'assets/images/_f7ffac5f-a0bf-4413-95f1-f07e8e5da170.jpeg';
    } else if (level == 3) {
      title = "The Seedling";
      badge = 'assets/images/Designer.png';
    } else if (level == 4) {
      title = "The Sapling";
      badge = 'assets/images/_61da10a9-782c-4bb2-80d0-b158ae937eef.jpeg';
    } else if (level == 5) {
      title = "The Younger";
      badge = 'assets/images/_67f06387-5494-4111-91d2-fb687b688f83.jpeg';
    } else if (level == 6) {
      title = "The Tree";
      badge = 'assets/images/_349e8493-b5e9-4df6-a546-0421096509d4.jpeg';
    } else if (level == 7) {
      title = "The Big Tree";
      badge = 'assets/images/_2e7ca63e-ce81-459b-9872-1687cf67aedc.jpeg';
    } else if (level == 8) {
      title = "The Grove";
      badge = 'assets/images/_6a33ed6b-3a97-49ae-8cf1-53f2a043fd50.jpeg';
    } else if (level == 9) {
      title = "The Woodland";
      badge = 'assets/images/_ee1cd0af-aa3e-40a8-af5b-4d8fc5517429.jpeg';
    } else if (level == 10) {
      title = "The Canopy";
      badge = 'assets/images/ay3pu95yy.jpg';
    } else {
      title = "The Forest Guardian";
      badge =
          'assets/images/pngtree-blossoming-hope-the-arboreal-adventures-of-a-forest-guardian-png-image_12256187.png';
    }

    List<Widget> widgetOptions = <Widget>[
      HomePage(user: user, level: level),
      const TipsPage(),
      ActionsPage(user: user),
      const ChallengesPage(),
      ProfilePage(user: user, level: level, title: title, badge: badge),
    ];

    return Scaffold(
        body: widgetOptions.elementAt(_selectedIndex),
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          selectedItemColor: const Color.fromRGBO(20, 162, 50, 1),
          onTap: (index) {
            setState(() {
              _selectedIndex = index;
            });
          },
          currentIndex: _selectedIndex,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.lightbulb),
              label: 'Tips',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.alarm_add_sharp),
              label: 'Actions',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.event_note),
              label: 'Challenges',
            ),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
          ],
        ));
  }
}
