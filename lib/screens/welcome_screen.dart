import 'package:flutter/material.dart';
// import 'register_screen.dart';

class WelcomeScreen extends StatefulWidget {
  static const routeName = '/welcome';
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  // void initState() {
  //   super.initState();
  //   Future.delayed(const Duration(seconds: 2), () {
  //     Navigator.of(context).pushReplacement(
  //       PageRouteBuilder(
  //         pageBuilder: (_, __, ___) => RegisterScreen(),
  //         transitionsBuilder: (_, animation, __, child) {
  //           return FadeTransition(opacity: animation, child: child);
  //         },
  //       ),
  //     );
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Colors.white, Color.fromRGBO(0, 245, 157, 1)],
        ),
      ),
      child: Center(
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            Positioned(
              top: MediaQuery.of(context).size.height *
                  0.27, // Adjust the top position as needed
              child: Image.asset(
                'assets/images/icon with shadow.png', // Replace with your image path
                height: 321, // Adjust height as needed
              ),
            ),
            Positioned(
              top: MediaQuery.of(context).size.height *
                  0.53, // Adjust the top position as needed
              child: const Text(
                'HabitSprout.',
                style: TextStyle(fontSize: 34, fontWeight: FontWeight.w800),
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
