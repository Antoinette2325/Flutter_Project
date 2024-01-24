// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'dart:async';
import 'package:flutter/material.dart';
import 'Menu.dart';
import 'MyTitle.dart';
import 'Grid.dart';
import 'package:finalproject/GamesScreen/games.dart';
import 'package:audioplayers/audioplayers.dart';

class Board extends StatefulWidget {
  @override
  _BoardState createState() => _BoardState();
}

class _BoardState extends State<Board> {
  late AudioCache audioCache;
  late AudioPlayer player;
  bool isAudioEnabled = true;

  @override
  void initState() {
    super.initState();
    audioCache = AudioCache();
    player = AudioPlayer();
    initAudio();
    super.initState();
    numbers.shuffle();
  }

  void initAudio() async {
    try {
      await player.play(AssetSource('bg.mp3'));
    } catch (e) {
      print('Error setting asset: $e');
    }
  }

  void toggleAudio() {
    if (isAudioEnabled) {
      player.stop(); // Stop the audio
    } else {
      player =
          AudioPlayer(); // Create a new instance to avoid resuming from the previous position
      initAudio(); // Start playing the audio
    }
    setState(() {
      isAudioEnabled = !isAudioEnabled;
    });
  }

  var numbers = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15];
  int move = 0;

  static const duration = const Duration(seconds: 1);
  int secondsPassed = 0;
  bool isActive = false;
  Timer? timer;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    if (timer == null) {
      timer = Timer.periodic(duration, (Timer t) {
        startTime();
      });
    }

    // Replace 'background_image.jpg' with your actual image path
    final backgroundImage = Image.asset(
      'images/backgroundimage/Sliding.gif',
      fit: BoxFit.cover,
    );

    return Scaffold(
      body: SafeArea(
        child: Container(
          height: size.height,
          child: Stack(
            children: [
              backgroundImage,
              Column(
                children: <Widget>[
                  MyTitle(size),
                  SizedBox(height: 50), // Added SizedBox with a height of 30

                  Grid(numbers, size, clickGrid),
                  Menu(reset, move, secondsPassed, size),
                ],
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: buildBottomBar(),
    );
  }

  Widget buildBottomBar() {
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color(0xff760a6d),
            Color(0xff4e054b)
          ], // Replace with your gradient colors
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            icon: Icon(Icons.home),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => GameChoice()),
              );
            },
            color: Color(0xffffffff),
            iconSize: 25,
          ),
          IconButton(
            icon: Icon(Icons.help),
            onPressed: () {
              _showTutorialDialog(context);
            },
            color: Color(0xfffbfbfb),
            iconSize: 25,
          ),
          IconButton(
            icon: Icon(
              isAudioEnabled ? Icons.volume_up_sharp : Icons.volume_off_sharp,
            ),
            onPressed: () {
              if (isAudioEnabled) {
                player.stop(); // Stop the audio if it's currently playing
              } else {
                initAudio(); // Start playing the audio
              }
              setState(() {
                isAudioEnabled = !isAudioEnabled;
              });
            },
            color: Color(0xffffffff),
            iconSize: 25,
          ),
        ],
      ),
    );
  }

  void _showTutorialDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.transparent,
          content: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                    'images/pop.png'), // Replace with your image asset
                fit: BoxFit.cover,
              ),
              border: Border.all(
                color: Color.fromARGB(255, 212, 193, 211),
                width: 5.0,
              ),
              borderRadius: BorderRadius.circular(15.0),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    'Welcome to Board Puzzle!',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    'Arrange the numbers in ascending order by sliding the empty space.',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    'How to Play:',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    '1. Tap on a number next to the empty space to move it into the empty space.',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    '2. Continue moving numbers until they are in ascending order.',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    'Good luck and enjoy!',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
                // Add your tutorial content here
              ],
            ),
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              style: ElevatedButton.styleFrom(
                primary: Color.fromARGB(255, 116, 16, 138),
              ),
              child: Text('Close'),
            ),
          ],
        );
      },
    );
  }

  void clickGrid(index) {
    if (secondsPassed == 0) {
      isActive = true;
    }
    if (index - 1 >= 0 && numbers[index - 1] == 0 && index % 4 != 0 ||
        index + 1 < 16 && numbers[index + 1] == 0 && (index + 1) % 4 != 0 ||
        (index - 4 >= 0 && numbers[index - 4] == 0) ||
        (index + 4 < 16 && numbers[index + 4] == 0)) {
      setState(() {
        move++;
        numbers[numbers.indexOf(0)] = numbers[index];
        numbers[index] = 0;
      });
    }
    checkWin();
  }

  void startTime() {
    if (isActive) {
      setState(() {
        secondsPassed = secondsPassed + 1;
      });
    }
  }

  void reset() {
    setState(() {
      numbers.shuffle();
      move = 0;
      secondsPassed = 0;
      isActive = false;
    });
  }

  bool isSorted(List list) {
    int prev = list.first;
    for (var i = 1; i < list.length - 1; i++) {
      int next = list[i];
      if (prev > next) return false;
      prev = next;
    }
    return true;
  }

  void checkWin() {
    if (isSorted(numbers)) {
      isActive = false;
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
            ),
            child: Container(
              height: 200,
              child: Padding(
                padding: const EdgeInsets.all(30.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'You Win!!',
                      style: TextStyle(fontSize: 20),
                    ),
                    SizedBox(
                      width: 220.0,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        style: ElevatedButton.styleFrom(
                          primary: Colors.blue,
                        ),
                        child: Text(
                          'Close',
                          style: TextStyle(
                              color: Color.fromARGB(255, 166, 140, 201)),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      );
    }
  }
}
