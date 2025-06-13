import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:habit_sprout1/services/firebase_service.dart';
import 'package:habit_sprout1/widgets/elevated_button.dart';

class ResetPasswordScreen extends StatefulWidget {
  static String routeName = '/reset-password';

  const ResetPasswordScreen({super.key});

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  FirebaseService fbService = GetIt.instance<FirebaseService>();

  String? email;

  var form = GlobalKey<FormState>();

  reset(context) {
    bool isValid = form.currentState!.validate();
    if (isValid) {
      form.currentState!.save();
      return fbService.forgotPassword(email!).then((value) {
        FocusScope.of(context).unfocus();
        ScaffoldMessenger.of(context).hideCurrentSnackBar();
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Please check your email for to reset your password!'),
        ));
        Navigator.of(context).pop();
      }).catchError((error) {
        FocusScope.of(context).unfocus();
        String message = error.toString();
        ScaffoldMessenger.of(context).hideCurrentSnackBar();
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(message),
        ));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    bool isValidEmail(String email) {
      final emailRegex = RegExp(
          r'^[a-zA-Z0-9.a-zA-Z0-9.!#$%&’*+/=?^_`{|}~-]+@[a-zA-Z0-9]+\.[a-zA-Z]+');
      return emailRegex.hasMatch(email);
    }

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
                      Navigator.of(context).pushNamed('/login');
                    },
                  ),
                  const Spacer(),
                  const Text(
                    'RESET PASSWORD',
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
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(
                      height: 150,
                      width: 357,
                      child: Form(
                        key: form,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            TextFormField(
                              decoration:
                                  const InputDecoration(label: Text('Email')),
                              keyboardType: TextInputType.emailAddress,
                              validator: (value) {
                                if (value == null) {
                                  return "Please provide an email address.";
                                } else if (!isValidEmail(value)) {
                                  return "Please provide a valid email address.";
                                } else {
                                  return null;
                                }
                              },
                              onSaved: (value) {
                                email = value;
                              },
                            ),
                            const SizedBox(height: 20),
                            CustomElevatedButton(
                                onPressed: () {
                                  reset(context);
                                },
                                text: 'Reset Password'),
                          ],
                        ),
                      ),
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
