// ignore_for_file: unused_import

import 'package:finalproject/GamesScreen/games.dart';
import 'package:finalproject/login.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:percent_indicator/percent_indicator.dart';

void main() {
  runApp(LoadingPage());
}

class LoadingPage extends StatefulWidget {
  @override
  _LoadingPageState createState() => _LoadingPageState();
}

class _LoadingPageState extends State<LoadingPage> {
  double loadingProgress = 0.0; // Initial loading progress

  @override
  void initState() {
    super.initState();

    // Simulate loading progress
    Future.delayed(Duration(seconds: 1), () {
      setState(() {
        loadingProgress = 1.0; // Set the loading progress to 100%
      });

      // Navigate to the main page after loading
      Future.delayed(Duration(seconds: 1), () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => LoginPage()),
        );
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background Image
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('images/loadingPage/load.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          // Loading Bar
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: 30.0,
              margin: EdgeInsets.only(bottom: 60.0),
              child: LinearPercentIndicator(
                animation: true,
                animationDuration: 10000,
                lineHeight: 30.0,
                percent: loadingProgress,
                progressColor: Colors.deepPurple,
                backgroundColor: Colors.deepPurple.shade200,
                linearStrokeCap: LinearStrokeCap.butt,
              ),
            ),
          ),
          // Lottie Animation
          Align(
            alignment: Alignment.topCenter,
            child: Container(
              margin: EdgeInsets.only(top: 40.0),
              child: Lottie.asset('images/loadingPage/Animation.json'),
            ),
          ),
        ],
      ),
    );
  }
}
