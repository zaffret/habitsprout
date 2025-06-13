import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:habit_sprout1/services/firebase_service.dart';
import 'package:habit_sprout1/widgets/elevated_button.dart';

class SignUpScreen extends StatefulWidget {
  static const routeName = '/signup';

  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  FirebaseService fbService = GetIt.instance<FirebaseService>();
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscureText = true;

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
            SizedBox(
              height: kToolbarHeight, // Same height as AppBar
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                child: Row(children: <Widget>[
                  IconButton(
                    icon: const Icon(Icons.arrow_back),
                    onPressed: () {
                      Navigator.of(context).pushNamed('/register');
                    },
                  ),
                  const Spacer(),
                  const Text(
                    'SIGN UP',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const Spacer(),
                  const SizedBox(width: 48, height: 48),
                ]),
              ),
            ),
            Expanded(
              child: Center(
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(height: 30),
                      const Text(
                        "WELCOME TO HABITSPROUT!",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w800,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 20),
                      const Text(
                        'Sign up today and kickstart your\njourney towards a sustainble\nlifestyle. Learn valuable eco-\nhabits, track your progress, and\ncelebrate your achievements!',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w600),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 100),
                      Container(
                        height: 57,
                        width: 357,
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          border: Border.all(
                              color: const Color.fromRGBO(33, 47, 85, 1)),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 17.0),
                          child: TextFormField(
                            controller: _nameController,
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Name',
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Name cannot be empty';
                              }
                              if (value.length < 3) {
                                return 'Name must be at least 3 characters';
                              }

                              return null;
                            },
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Container(
                        height: 57,
                        width: 357,
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          border: Border.all(
                              color: const Color.fromRGBO(33, 47, 85, 1)),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 17.0),
                          child: TextFormField(
                            controller: _emailController,
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Email',
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Email cannot be empty';
                              }
                              String pattern = r'^[^@]+@[^@]+\.[^@]+';
                              RegExp regex = RegExp(pattern);
                              if (!regex.hasMatch(value)) {
                                return 'Enter a valid email address';
                              }
                              return null;
                            },
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Container(
                        height: 57,
                        width: 357,
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          border: Border.all(
                              color: const Color.fromRGBO(33, 47, 85, 1)),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 17.0),
                          child: Row(
                            children: [
                              Expanded(
                                child: TextFormField(
                                  controller: _passwordController,
                                  obscureText: _obscureText,
                                  decoration: const InputDecoration(
                                    border: InputBorder.none,
                                    hintText: 'Password',
                                  ),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Password cannot be empty';
                                    }
                                    if (value.length < 8) {
                                      return 'Password must be at least 8 characters';
                                    }
                                    String pattern =
                                        r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)[a-zA-Z\d]{8,}$';
                                    RegExp regex = RegExp(pattern);
                                    if (!regex.hasMatch(value)) {
                                      return 'Password must contain a mix of upper, lower, and numbers';
                                    }
                                    return null;
                                  },
                                ),
                              ),
                              IconButton(
                                icon: Icon(_obscureText
                                    ? Icons.visibility
                                    : Icons.visibility_off),
                                onPressed: () {
                                  setState(() {
                                    _obscureText = !_obscureText;
                                  });
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      CustomElevatedButton(
                        text: "Sign Up",
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            String email = _emailController.text;
                            String password = _passwordController.text;
                            String name = _nameController.text;
                            UserCredential userCredential;
                            String result;

                            try {
                              userCredential =
                                  await fbService.register(email, password);

                              fbService.saveLoginState(true);
                              fbService.addUser(userCredential, name);
                              result = 'Registration successful';
                            } catch (e) {
                              result = 'Registration failed: $e';
                            }

                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(result),
                              ),
                            );
                          }
                        },
                      ),
                      const SizedBox(height: 30),
                      RichText(
                          textAlign: TextAlign.center,
                          text: const TextSpan(
                            style: TextStyle(
                              fontFamily: 'OpenSans',
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: Color.fromRGBO(33, 47, 85, 1),
                              decoration: TextDecoration.underline,
                              decorationThickness: 4,
                            ),
                            children: <TextSpan>[
                              TextSpan(
                                  text:
                                      'By continuing, you agree to our\nPrivacy Policy & Terms of Service.'),
                            ],
                          ))
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
