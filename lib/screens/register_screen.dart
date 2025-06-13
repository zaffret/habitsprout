import 'package:flutter/material.dart';
import 'package:habit_sprout1/services/firebase_service.dart';
import 'package:habit_sprout1/widgets/elevated_button.dart';

class RegisterScreen extends StatelessWidget {
  static const routeName = '/register';
  final FirebaseService firebaseService = FirebaseService();

  RegisterScreen({super.key});

  void _signInWithGoogle(BuildContext context) async {
    String? result = await firebaseService.signInWithGoogle();
    if (result == "Google sign-in successful") {
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(result ?? 'Unknown error')),
      );
    }
  }

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
        child: Column(
          children: <Widget>[
            const SizedBox(
              height: kToolbarHeight, // Same height as AppBar
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                child: Align(
                  alignment: Alignment.center,
                  child: Text(
                    'JOIN HABITSPROUT.',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    const SizedBox(height: 20),
                    RichText(
                      textAlign: TextAlign.center,
                      text: const TextSpan(
                        style: TextStyle(
                          fontSize: 26,
                          fontWeight: FontWeight.w800,
                          fontFamily: 'OpenSans',
                          color: Color.fromRGBO(33, 47, 85, 1),
                        ),
                        children: <TextSpan>[
                          TextSpan(
                            text: 'GROW',
                          ),
                          TextSpan(
                            text: ' GREENER ',
                            style: TextStyle(
                              color: Color.fromRGBO(31, 220, 70, 1),
                            ),
                          ),
                          TextSpan(
                            text: ' HABITS,',
                          ),
                          TextSpan(text: '\nONE STEP AT A TIME.')
                        ],
                      ),
                    ),
                    const SizedBox(height: 45),
                    Image.asset('assets/images/Illustration.png',
                        height: 252.26),
                    const SizedBox(height: 55),
                    CustomElevatedButton(
                      text: 'CREATE FREE ACCOUNT',
                      onPressed: () {
                        Navigator.of(context).pushNamed('/signup');
                      },
                    ),
                    const SizedBox(height: 20),
                    CustomElevatedButton(
                      text: 'ALREADY A USER? LOGIN',
                      onPressed: () {
                        Navigator.of(context).pushNamed('/login');
                      },
                    ),
                    const SizedBox(height: 20),
                    CustomElevatedButton(
                      text: 'CONTINUE WITH GOOGLE',
                      onPressed: () {
                        _signInWithGoogle(context);
                      },
                      isGoogleButton: true,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
