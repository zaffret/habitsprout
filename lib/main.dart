// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:get_it/get_it.dart';
// import 'package:habit_sprout1/firebase_options.dart';
// import 'package:habit_sprout1/models/action_model.dart';
// import 'package:habit_sprout1/pages/action_list.dart';
// import 'package:habit_sprout1/pages/image.dart';
// import 'package:habit_sprout1/pages/questionnaire.dart';
// import 'package:habit_sprout1/screens/reset_password_screen.dart';
// import 'package:habit_sprout1/screens/signup_screen.dart';
// import 'package:habit_sprout1/services/firebase_service.dart';
// import 'screens/welcome_screen.dart';
// import 'screens/login_screen.dart';
// import 'screens/register_screen.dart';
// import 'screens/main_screen.dart';

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp(
//     options: DefaultFirebaseOptions.currentPlatform,
//   );

//   await FirebaseAuth.instance.setPersistence(Persistence.LOCAL);

//   GetIt.instance.registerLazySingleton(() => FirebaseService());

//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   final FirebaseService fbService = GetIt.instance<FirebaseService>();

//   MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return StreamBuilder<User?>(
//       stream: fbService.getAuthUser(),
//       builder: (context, snapshot) {
//         if (kDebugMode) {
//           print('Connection State: ${snapshot.connectionState}');
//         }
//         if (kDebugMode) {
//           print('User: ${snapshot.data}');
//         }
//         if (snapshot.connectionState != ConnectionState.waiting &&
//             snapshot.hasData) {
//           final userId = snapshot.data!.uid;
//           return StreamBuilder<LocalUser>(
//             stream: fbService.getUser(userId),
//             builder: (context, userSnapshot) {
//               if (userSnapshot.connectionState != ConnectionState.waiting &&
//                   userSnapshot.hasData) {
//                 final user = userSnapshot.data!;
//                 final level = calculateLevel(user.points);
//                 final userId = user.id;
//                 final imageUrl = user.imageUrl;
//                 return MaterialApp(
//                     debugShowCheckedModeBanner: false,
//                     theme: ThemeData(
//                         primarySwatch: Colors.blue,
//                         visualDensity: VisualDensity.adaptivePlatformDensity,
//                         fontFamily: 'OpenSans',
//                         textTheme: const TextTheme(
//                             bodyMedium: TextStyle(
//                                 color: Color.fromRGBO(33, 47, 85, 1)))),
//                     home: HomeScreen(user: user, level: level),
//                     routes: {
//                       WelcomeScreen.routeName: (_) {
//                         return const WelcomeScreen();
//                       },
//                       RegisterScreen.routeName: (_) {
//                         return RegisterScreen();
//                       },
//                       LoginScreen.routeName: (_) {
//                         return const LoginScreen();
//                       },
//                       SignUpScreen.routeName: (_) {
//                         return const SignUpScreen();
//                       },
//                       HomeScreen.routeName: (_) {
//                         return HomeScreen(user: user, level: level);
//                       },
//                       ActionsList.routeName: (_) {
//                         return const ActionsList();
//                       },
//                       SurveyForm.routeName: (_) {
//                         return const SurveyForm();
//                       },
//                       ResetPasswordScreen.routeName: (_) {
//                         return const ResetPasswordScreen();
//                       },
//                       ImageUploadPage.routeName: (_) {
//                         return ImageUploadPage(
//                           userId: userId,
//                           imageUrl: imageUrl,
//                         );
//                       },
//                     });
//               } else {
//                 return const Center(child: CircularProgressIndicator());
//               }
//             },
//           );
//         } else {
//           return MaterialApp(
//               debugShowCheckedModeBanner: false,
//               theme: ThemeData(
//                   primarySwatch: Colors.blue,
//                   visualDensity: VisualDensity.adaptivePlatformDensity,
//                   fontFamily: 'OpenSans',
//                   textTheme: const TextTheme(
//                       bodyMedium:
//                           TextStyle(color: Color.fromRGBO(33, 47, 85, 1)))),
//               home: RegisterScreen(),
//               routes: {
//                 WelcomeScreen.routeName: (_) {
//                   return const WelcomeScreen();
//                 },
//                 RegisterScreen.routeName: (_) {
//                   return RegisterScreen();
//                 },
//                 LoginScreen.routeName: (_) {
//                   return const LoginScreen();
//                 },
//                 SignUpScreen.routeName: (_) {
//                   return const SignUpScreen();
//                 },
//                 ResetPasswordScreen.routeName: (_) {
//                   return ResetPasswordScreen();
//                 },
//               });
//         }
//       },
//     );
//   }

//   num calculateLevel(num points) {
//     if (points < 500) {
//       return 1;
//     } else if (points < 1000) {
//       return 2;
//     } else if (points < 1500) {
//       return 3;
//     } else if (points < 2000) {
//       return 4;
//     } else if (points < 2500) {
//       return 5;
//     } else if (points < 3000) {
//       return 6;
//     } else if (points < 3500) {
//       return 7;
//     } else if (points < 4000) {
//       return 8;
//     } else if (points < 4500) {
//       return 9;
//     } else if (points < 5000) {
//       return 10;
//     } else {
//       return 11;
//     }
//   }
// }

// // import 'package:firebase_auth/firebase_auth.dart';
// // import 'package:firebase_core/firebase_core.dart';
// // import 'package:flutter/foundation.dart';
// // import 'package:flutter/material.dart';
// // import 'package:get_it/get_it.dart';
// // import 'package:habit_sprout1/firebase_options.dart';
// // import 'package:habit_sprout1/models/action_model.dart';
// // import 'package:habit_sprout1/pages/action_list.dart';
// // import 'package:habit_sprout1/pages/questionnaire.dart';
// // import 'package:habit_sprout1/screens/reset_password_screen.dart';
// // import 'package:habit_sprout1/screens/signup_screen.dart';
// // import 'package:habit_sprout1/services/firebase_service.dart';
// // import 'screens/welcome_screen.dart';
// // import 'screens/login_screen.dart';
// // import 'screens/register_screen.dart';
// // import 'screens/main_screen.dart';

// // void main() async {
// //   WidgetsFlutterBinding.ensureInitialized();
// //   await Firebase.initializeApp(
// //     options: DefaultFirebaseOptions.currentPlatform,
// //   );

// //   await FirebaseAuth.instance.setPersistence(Persistence.LOCAL);

// //   GetIt.instance.registerLazySingleton(() => FirebaseService());

// //   runApp(MyApp());
// // }

// // class MyApp extends StatelessWidget {
// //   final FirebaseService fbService = GetIt.instance<FirebaseService>();

// //   MyApp({super.key});

// //   @override
// //   Widget build(BuildContext context) {
// //     return FutureBuilder<bool>(
// //       future: fbService.checkLoginState(),
// //       builder: (context, loginSnapshot) {
// //         if (loginSnapshot.connectionState == ConnectionState.waiting) {
// //           return MaterialApp(
// //               debugShowCheckedModeBanner: false,
// //               theme: ThemeData(
// //                 primarySwatch: Colors.blue,
// //                 visualDensity: VisualDensity.adaptivePlatformDensity,
// //                 fontFamily: 'OpenSans',
// //                 textTheme: const TextTheme(
// //                   bodyMedium: TextStyle(
// //                     color: Color.fromRGBO(33, 47, 85, 1),
// //                   ),
// //                 ),
// //               ),
// //               home: const WelcomeScreen());
// //         }
// //         final bool isLoggedIn = loginSnapshot.data ?? true;
// //         print(isLoggedIn);
// //         return StreamBuilder<User?>(
// //           stream: fbService.getAuthUser(),
// //           builder: (context, snapshot) {
// //             if (kDebugMode) {
// //               print('Connection State: ${snapshot.connectionState}');
// //             }
// //             if (kDebugMode) {
// //               print('User: ${snapshot.data}');
// //             }
// //             if (snapshot.connectionState != ConnectionState.waiting &&
// //                 snapshot.hasData) {
// //               final userId = snapshot.data!.uid;
// //               return StreamBuilder<LocalUser>(
// //                 stream: fbService.getUser(userId),
// //                 builder: (context, userSnapshot) {
// //                   if (userSnapshot.connectionState != ConnectionState.waiting &&
// //                       userSnapshot.hasData) {
// //                     final user = userSnapshot.data!;
// //                     final level = calculateLevel(user.points);
// //                     return MaterialApp(
// //                       debugShowCheckedModeBanner: false,
// //                       theme: ThemeData(
// //                         primarySwatch: Colors.blue,
// //                         visualDensity: VisualDensity.adaptivePlatformDensity,
// //                         fontFamily: 'OpenSans',
// //                         textTheme: const TextTheme(
// //                           bodyMedium: TextStyle(
// //                             color: Color.fromRGBO(33, 47, 85, 1),
// //                           ),
// //                         ),
// //                       ),
// //                       home: isLoggedIn
// //                           ? HomeScreen(user: user, level: level)
// //                           : RegisterScreen(),
// //                       routes: {
// //                         WelcomeScreen.routeName: (_) {
// //                           return const WelcomeScreen();
// //                         },
// //                         RegisterScreen.routeName: (_) {
// //                           return RegisterScreen();
// //                         },
// //                         LoginScreen.routeName: (_) {
// //                           return const LoginScreen();
// //                         },
// //                         SignUpScreen.routeName: (_) {
// //                           return const SignUpScreen();
// //                         },
// //                         HomeScreen.routeName: (_) {
// //                           return HomeScreen(user: user, level: level);
// //                         },
// //                         ActionsList.routeName: (_) {
// //                           return const ActionsList();
// //                         },
// //                         SurveyForm.routeName: (_) {
// //                           return const SurveyForm();
// //                         },
// //                         ResetPasswordScreen.routeName: (_) {
// //                           return ResetPasswordScreen();
// //                         },
// //                       },
// //                     );
// //                   } else {
// //                     return const Center(child: CircularProgressIndicator());
// //                   }
// //                 },
// //               );
// //             } else {
// //               return MaterialApp(
// //                 debugShowCheckedModeBanner: false,
// //                 theme: ThemeData(
// //                   primarySwatch: Colors.blue,
// //                   visualDensity: VisualDensity.adaptivePlatformDensity,
// //                   fontFamily: 'OpenSans',
// //                   textTheme: const TextTheme(
// //                     bodyMedium: TextStyle(
// //                       color: Color.fromRGBO(33, 47, 85, 1),
// //                     ),
// //                   ),
// //                 ),
// //                 home: const WelcomeScreen(),
// //                 routes: {
// //                   WelcomeScreen.routeName: (_) {
// //                     return const WelcomeScreen();
// //                   },
// //                   RegisterScreen.routeName: (_) {
// //                     return RegisterScreen();
// //                   },
// //                   LoginScreen.routeName: (_) {
// //                     return const LoginScreen();
// //                   },
// //                   SignUpScreen.routeName: (_) {
// //                     return const SignUpScreen();
// //                   },
// //                   ResetPasswordScreen.routeName: (_) {
// //                     return ResetPasswordScreen();
// //                   },
// //                 },
// //               );
// //             }
// //           },
// //         );
// //       },
// //     );
// //   }

// //   num calculateLevel(num points) {
// //     if (points < 500) {
// //       return 1;
// //     } else if (points < 1000) {
// //       return 2;
// //     } else if (points < 1500) {
// //       return 3;
// //     } else if (points < 2000) {
// //       return 4;
// //     } else if (points < 2500) {
// //       return 5;
// //     } else if (points < 3000) {
// //       return 6;
// //     } else if (points < 3500) {
// //       return 7;
// //     } else if (points < 4000) {
// //       return 8;
// //     } else if (points < 4500) {
// //       return 9;
// //     } else if (points < 5000) {
// //       return 10;
// //     } else {
// //       return 11;
// //     }
// //   }
// // }

// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:get_it/get_it.dart';
// import 'package:habit_sprout1/firebase_options.dart';
// import 'package:habit_sprout1/models/action_model.dart';
// import 'package:habit_sprout1/pages/action_list.dart';
// import 'package:habit_sprout1/pages/questionnaire.dart';
// import 'package:habit_sprout1/screens/reset_password_screen.dart';
// import 'package:habit_sprout1/screens/signup_screen.dart';
// import 'package:habit_sprout1/services/firebase_service.dart';
// import 'screens/welcome_screen.dart';
// import 'screens/login_screen.dart';
// import 'screens/register_screen.dart';
// import 'screens/main_screen.dart';

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp(
//     options: DefaultFirebaseOptions.currentPlatform,
//   );

//   await FirebaseAuth.instance.setPersistence(Persistence.LOCAL);

//   GetIt.instance.registerLazySingleton(() => FirebaseService());

//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   final FirebaseService fbService = GetIt.instance<FirebaseService>();

//   MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//         visualDensity: VisualDensity.adaptivePlatformDensity,
//         fontFamily: 'OpenSans',
//         textTheme: const TextTheme(
//           bodyMedium: TextStyle(
//             color: Color.fromRGBO(33, 47, 85, 1),
//           ),
//         ),
//       ),
//       home: FutureBuilder<bool>(
//         future: fbService.checkLoginState(),
//         builder: (context, loginSnapshot) {
//           if (loginSnapshot.connectionState == ConnectionState.waiting) {
//             return const WelcomeScreen();
//           }

//           final bool isLoggedIn = loginSnapshot.data ?? false;
//           print(isLoggedIn);

//           if (isLoggedIn) {
//             return StreamBuilder<User?>(
//               stream: fbService.getAuthUser(),
//               builder: (context, snapshot) {
//                 if (kDebugMode) {
//                   print('Connection State: ${snapshot.connectionState}');
//                 }
//                 if (kDebugMode) {
//                   print('User: ${snapshot.data}');
//                 }
//                 if (snapshot.connectionState == ConnectionState.waiting) {
//                   return const Center(child: CircularProgressIndicator());
//                 }
//                 if (snapshot.hasData) {
//                   final userId = snapshot.data!.uid;
//                   return StreamBuilder<LocalUser>(
//                     stream: fbService.getUser(userId),
//                     builder: (context, userSnapshot) {
//                       if (userSnapshot.connectionState ==
//                           ConnectionState.waiting) {
//                         return const Center(child: CircularProgressIndicator());
//                       }
//                       if (userSnapshot.hasData) {
//                         final user = userSnapshot.data!;
//                         final level = calculateLevel(user.points);
//                         return HomeScreen(user: user, level: level);
//                       } else {
//                         return const Center(child: CircularProgressIndicator());
//                       }
//                     },
//                   );
//                 } else {
//                   return RegisterScreen();
//                 }
//               },
//             );
//           } else {
//             return RegisterScreen();
//           }
//         },
//       ),
//       routes: {
//         WelcomeScreen.routeName: (_) => const WelcomeScreen(),
//         RegisterScreen.routeName: (_) => RegisterScreen(),
//         LoginScreen.routeName: (_) => const LoginScreen(),
//         SignUpScreen.routeName: (_) => const SignUpScreen(),
//         HomeScreen.routeName: (context) {
//           final args =
//               ModalRoute.of(context)!.settings.arguments as HomeScreenArguments;
//           return HomeScreen(user: args.user, level: args.level);
//         },
//         ActionsList.routeName: (_) => const ActionsList(),
//         SurveyForm.routeName: (_) => const SurveyForm(),
//         ResetPasswordScreen.routeName: (_) => ResetPasswordScreen(),
//       },
//     );
//   }

//   num calculateLevel(num points) {
//     if (points < 500) {
//       return 1;
//     } else if (points < 1000) {
//       return 2;
//     } else if (points < 1500) {
//       return 3;
//     } else if (points < 2000) {
//       return 4;
//     } else if (points < 2500) {
//       return 5;
//     } else if (points < 3000) {
//       return 6;
//     } else if (points < 3500) {
//       return 7;
//     } else if (points < 4000) {
//       return 8;
//     } else if (points < 4500) {
//       return 9;
//     } else if (points < 5000) {
//       return 10;
//     } else {
//       return 11;
//     }
//   }
// }

// class HomeScreenArguments {
//   final LocalUser user;
//   final int level;

//   HomeScreenArguments({required this.user, required this.level});
// }

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:habit_sprout1/firebase_options.dart';
import 'package:habit_sprout1/models/action_model.dart';
import 'package:habit_sprout1/pages/action_list.dart';
import 'package:habit_sprout1/pages/calender.dart';
import 'package:habit_sprout1/pages/image.dart';
import 'package:habit_sprout1/pages/questionnaire.dart';
import 'package:habit_sprout1/pages/setttings.dart';
import 'package:habit_sprout1/screens/reset_password_screen.dart';
import 'package:habit_sprout1/screens/signup_screen.dart';
import 'package:habit_sprout1/services/firebase_service.dart';
import 'package:habit_sprout1/services/theme_notifier.dart';

import 'package:provider/provider.dart';
import 'screens/welcome_screen.dart';
import 'screens/login_screen.dart';
import 'screens/register_screen.dart';
import 'screens/main_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await FirebaseAuth.instance.setPersistence(Persistence.LOCAL);

  GetIt.instance.registerLazySingleton(() => FirebaseService());

  runApp(
    ChangeNotifierProvider(
      create: (context) => ThemeNotifier(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  final FirebaseService fbService = GetIt.instance<FirebaseService>();

  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeNotifier = Provider.of<ThemeNotifier>(context);

    return StreamBuilder<User?>(
      stream: fbService.getAuthUser(),
      builder: (context, snapshot) {
        if (kDebugMode) {
          print('Connection State: ${snapshot.connectionState}');
        }
        if (kDebugMode) {
          print('User: ${snapshot.data}');
        }
        if (snapshot.connectionState != ConnectionState.waiting &&
            snapshot.hasData) {
          final userId = snapshot.data!.uid;
          return StreamBuilder<LocalUser>(
            stream: fbService.getUser(userId),
            builder: (context, userSnapshot) {
              if (userSnapshot.connectionState != ConnectionState.waiting &&
                  userSnapshot.hasData) {
                final user = userSnapshot.data!;
                final level = calculateLevel(user.points);
                final userId = user.id;
                final imageUrl = user.imageUrl;
                return MaterialApp(
                    debugShowCheckedModeBanner: false,
                    theme: themeNotifier.currentTheme,
                    home: HomeScreen(user: user, level: level),
                    routes: {
                      WelcomeScreen.routeName: (_) {
                        return const WelcomeScreen();
                      },
                      RegisterScreen.routeName: (_) {
                        return RegisterScreen();
                      },
                      LoginScreen.routeName: (_) {
                        return const LoginScreen();
                      },
                      SignUpScreen.routeName: (_) {
                        return const SignUpScreen();
                      },
                      HomeScreen.routeName: (_) {
                        return HomeScreen(user: user, level: level);
                      },
                      ActionsList.routeName: (_) {
                        return const ActionsList();
                      },
                      SurveyForm.routeName: (_) {
                        return const SurveyForm();
                      },
                      ResetPasswordScreen.routeName: (_) {
                        return const ResetPasswordScreen();
                      },
                      ImageUploadPage.routeName: (_) {
                        return ImageUploadPage(
                          userId: userId,
                          imageUrl: imageUrl,
                        );
                      },
                      SettingsPage.routeName: (_) {
                        return SettingsPage();
                      },
                      TableCalendarPage.routeName: (_) {
                        return TableCalendarPage();
                      }
                    });
              } else {
                return const Center(child: CircularProgressIndicator());
              }
            },
          );
        } else {
          return MaterialApp(
              debugShowCheckedModeBanner: false,
              theme: themeNotifier.currentTheme,
              home: RegisterScreen(),
              routes: {
                WelcomeScreen.routeName: (_) {
                  return const WelcomeScreen();
                },
                RegisterScreen.routeName: (_) {
                  return RegisterScreen();
                },
                LoginScreen.routeName: (_) {
                  return const LoginScreen();
                },
                SignUpScreen.routeName: (_) {
                  return const SignUpScreen();
                },
                ResetPasswordScreen.routeName: (_) {
                  return const ResetPasswordScreen();
                },
                SettingsPage.routeName: (_) {
                  return SettingsPage();
                },
                TableCalendarPage.routeName: (_) {
                  return TableCalendarPage();
                }
              });
        }
      },
    );
  }

  num calculateLevel(num points) {
    if (points < 500) {
      return 1;
    } else if (points < 1000) {
      return 2;
    } else if (points < 1500) {
      return 3;
    } else if (points < 2000) {
      return 4;
    } else if (points < 2500) {
      return 5;
    } else if (points < 3000) {
      return 6;
    } else if (points < 3500) {
      return 7;
    } else if (points < 4000) {
      return 8;
    } else if (points < 4500) {
      return 9;
    } else if (points < 5000) {
      return 10;
    } else {
      return 11;
    }
  }
}
