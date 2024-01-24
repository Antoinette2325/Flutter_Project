import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'color_home.dart';
import 'puzzle_home.dart';
import 'slot_home.dart';
import 'dice_home.dart';
import 'scramble_home.dart';
import 'tictac_home.dart';
import 'memogame_home.dart';
import 'menu.dart';
import 'rock_home.dart';
import 'sudoku_home.dart'; // Import the SudokuHome class file
import 'quiz_home.dart'; // Import the QuizHome class file

class GameChoice extends StatefulWidget {
  @override
  _GameChoiceState createState() => _GameChoiceState();
}

class _GameChoiceState extends State<GameChoice> {
  late AudioCache audioCache;
  late AudioPlayer player;
  bool isAudioEnabled = true;

  @override
  void initState() {
    super.initState();
    audioCache = AudioCache();
    player = AudioPlayer();
    initAudio();
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
      player.pause(); // Pause the audio
    } else {
      player =
          AudioPlayer(); // Create a new instance to play the audio from the beginning
      initAudio(); // Start playing the audio
    }
    setState(() {
      isAudioEnabled = !isAudioEnabled;
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return Future.value(false);
      },
      child: Scaffold(
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              automaticallyImplyLeading: false,
              expandedHeight: 200.0,
              floating: false,
              pinned: true,
              flexibleSpace: FlexibleSpaceBar(
                title: Text(''),
                background: Stack(
                  children: [
                    // Cover Photo
                    Container(
                      height: 200.0,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('images/welcome.png'),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Positioned(
                      top: 16.0,
                      right: 16.0,
                      child: FloatingActionButton(
                        onPressed: () {
                          showModalBottomSheet(
                            context: context,
                            builder: (BuildContext context) {
                              return MenuContent();
                            },
                          );
                        },
                        child: Icon(Icons.menu),
                        backgroundColor: Color(0xff4e208b),
                      ),
                    ),
                    Positioned(
                      top: 16.0,
                      left: 16.0,
                      child: FloatingActionButton(
                        onPressed: () {
                          if (isAudioEnabled) {
                            player
                                .stop(); // Stop the audio if it's currently playing
                          } else {
                            initAudio(); // Start playing the audio
                          }
                          setState(() {
                            isAudioEnabled = !isAudioEnabled;
                          });
                        },
                        child: Icon(
                          isAudioEnabled
                              ? Icons.volume_up_sharp
                              : Icons.volume_off_sharp,
                        ),
                        backgroundColor: Color(0xff4e208b),
                      ),
                    ),
                  ],
                ),
              ),
              backgroundColor: Color(0xff4e208b),
            ),
            SliverFillRemaining(
              child: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('images/bggame.jpg'),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(height: 25),
                      Container(
                        width: 400,
                        height: 60,
                        child: Text(
                          "LET'S PLAY",
                          style: TextStyle(
                            fontSize: 24.0,
                            color: Colors.white,
                            fontFamily: 'Press',
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),

                      Container(
                        width: 400,
                        height: 60,
                        color: Color(0xbf30034a),
                        padding: EdgeInsets.symmetric(vertical: 5.0),
                        alignment: Alignment.center,
                        child: Text(
                          'Mind Games',
                          style: TextStyle(
                            fontSize: 29.0,
                            color: Colors.white,
                            fontFamily: 'RubikDoodleShadow',
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      ),

                      // First Row

                      Container(
                        color: Color(0xa233023c),
                        child: CarouselSlider(
                          options: CarouselOptions(
                            height: 200.0,
                            viewportFraction: 0.4,

                            enlargeCenterPage: false,
                            aspectRatio:
                                1.0, // Set aspect ratio to make it a square
                            autoPlayInterval: Duration(seconds: 3),
                          ),
                          items: [
                            CustomButton(
                              buttonText: '',
                              imagePath: 'images/games/qt.png',
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => QuizHome(),
                                  ),
                                );
                              },
                            ),
                            CustomButton(
                              buttonText: '',
                              imagePath: 'images/games/tc.png',
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => TictacHome(),
                                  ),
                                );
                              },
                            ),
                            CustomButton(
                              buttonText: '',
                              imagePath: 'images/games/mg.png',
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => MemoHome(),
                                  ),
                                );
                              },
                            ),
                            CustomButton(
                              buttonText: '',
                              imagePath: 'images/games/sp.png',
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => PuzzleHome(),
                                  ),
                                );
                              },
                            ),
                            CustomButton(
                              buttonText: '',
                              imagePath: 'images/games/sw.png',
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ScrambleHome(),
                                  ),
                                );
                              },
                            ),
                            CustomButton(
                              buttonText: '',
                              imagePath: 'images/games/sd.png',
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => SudokuHome(),
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                      // Second Row

                      SizedBox(height: 35),
                      Container(
                        width: 400,
                        height: 60,
                        color: Color(0xbf30034a),
                        padding: EdgeInsets.symmetric(vertical: 5.0),
                        alignment: Alignment.center,
                        child: Text(
                          'Lucky Games',
                          style: TextStyle(
                            fontSize: 29.0,
                            color: Colors.white,
                            fontFamily: 'RubikDoodleShadow',
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      ),

                      Container(
                          color: Color(0xa233023c),
                          child: CarouselSlider(
                            options: CarouselOptions(
                              height: 200.0,
                              viewportFraction: 0.4,

                              enlargeCenterPage: false,
                              aspectRatio:
                                  1.0, // Set aspect ratio to make it a square
                              autoPlayInterval: Duration(seconds: 3),
                            ),
                            items: [
                              CustomButton(
                                buttonText: '',
                                imagePath: 'images/games/rd.png',
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => DiceHome(),
                                    ),
                                  );
                                },
                              ),
                              CustomButton(
                                buttonText: '',
                                imagePath: 'images/games/sm.png',
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => SlotHome(),
                                    ),
                                  );
                                },
                              ),
                              CustomButton(
                                buttonText: '',
                                imagePath: 'images/games/cg.png',
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => ColorHome(),
                                    ),
                                  );
                                },
                              ),
                              CustomButton(
                                buttonText: '',
                                imagePath: 'images/games/rps.png',
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => RockHome(),
                                    ),
                                  );
                                },
                              ),
                            ],
                          )),
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

class CustomButton extends StatelessWidget {
  final String buttonText;
  final String imagePath;
  final VoidCallback onPressed;

  const CustomButton({
    Key? key,
    required this.buttonText,
    required this.imagePath,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: onPressed,
        child: Container(
          width: 150.0, // Set width to make it a square
          height: 150.0, // Set height to make it a square
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15.0),
            boxShadow: [
              BoxShadow(
                color: Color.fromARGB(255, 62, 0, 67).withOpacity(0.5),
                spreadRadius: 2,
                blurRadius: 0,
                offset: Offset(1.0, 1.0),
              ),
            ],
          ),
          child: Stack(
            children: [
              // Background Image
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15.0),
                  image: DecorationImage(
                    image: AssetImage(imagePath),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              // Button Text Overlay
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15.0),
                  // Add a border
                  border: Border.all(
                    color: Colors.white, // Change the border color if needed
                    width: 2, // Adjust the border width as needed
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
