import 'package:flutter/material.dart';
import 'package:pict_mis/home_widget.dart';
import 'package:firebase_core/firebase_core.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: "PICT MIS",
        theme: ThemeData(
          primarySwatch: Colors.deepPurple,
          // backgroundColor: Color.fromARGB(255, 108, 93, 220),
        ),
        home: HomePage());
  }
}
