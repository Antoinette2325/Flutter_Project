// ignore_for_file: unused_import

import 'package:finalproject/firebase_options.dart';
import 'package:finalproject/signup.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'initialize.dart'; // Import the initialization file
import 'loadingpage.dart';
import 'login.dart';
import 'package:finalproject/GamesScreen/games.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        '/': (context) => LoginPage(),
        '/login': (context) => LoginPage(),
        '/signUp': (context) => SignUpPage(),
        '/home': (context) => GameChoice(),
      },
    );
  }
}
