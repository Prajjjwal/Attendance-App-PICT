import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pict_mis/Screens/Welcome/welcome_screen.dart';
import 'package:pict_mis/home_widget.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'constants.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: "PICT MIS",
        theme: ThemeData(
          // primarySwatch: Colors.deepPurple,
          primaryColor: kPrimaryColor,
          scaffoldBackgroundColor: Colors.white,
          // backgroundColor: Color.fromARGB(255, 108, 93, 220),
        ),
        home: AuthWrapper());
  }
}

class AuthWrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = context.watch<User?>();

    if (user != null) {
      return HomePage();
    }
    return WelcomeScreen();
  }
}

// class AuthCheck extends StatefulWidget {
//   const AuthCheck({Key? key}) : super(key: key);

//   @override
//   State<AuthCheck> createState() => _AuthCheckState();
// }

// class _AuthCheckState extends State<AuthCheck> {
//   bool userAvailable = false;

//   late SharedPreferences sharedPreferences;

//   @override
//   void initState() {
//     super.initState();

//     _getCurrentUser();
//   }

//   void _getCurrentUser() async {
//     sharedPreferences = await SharedPreferences.getInstance();

//     try {
//       if (sharedPreferences.getString('userId') != "") {
//         setState(() {
//           userAvailable = true;
//         });
//       }
//     } catch (e) {
//       setState(() {
//         userAvailable = false;
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return userAvailable ? HomePage() : WelcomeScreen();
//   }
// }
