import 'package:flutter/material.dart';
import 'dart:math';
import 'package:audioplayers/audioplayers.dart';
import 'package:finalproject/GamesScreen/games.dart';

void main() {
  runApp(TicTacToeApp());
}

class TicTacToeApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: TicTacToeScreen(),
    );
  }
}

class TicTacToeScreen extends StatefulWidget {
  @override
  _TicTacToeScreenState createState() => _TicTacToeScreenState();
}

class _TicTacToeScreenState extends State<TicTacToeScreen> {
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
      await player.play(AssetSource('tictac.mp3'));
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

  List<List<String>> board = List.generate(3, (_) => List.filled(3, ''));

  bool isPlayer1Turn = true; // true for Player 1, false for Player 2
  bool isComputerMode = false;
  bool isSoundEnabled = true; // Added variable for sound

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/5.jpg'), // Replace with your image path
            fit: BoxFit.cover,
          ),
        ),
        child: Stack(
          children: [
            Column(
              children: [
                SizedBox(height: 30),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 18),
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color:
                        Color.fromARGB(242, 84, 8, 129), // Set to transparent
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    isPlayer1Turn
                        ? 'Player 1'
                        : (isComputerMode ? 'Computer' : 'Player 2'),
                    style: TextStyle(
                      fontSize: 25,
                      color: Color.fromARGB(255, 246, 236, 241),
                      fontFamily: "BlackHanSans",
                    ),
                  ),
                ),
                Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GridView.builder(
                        shrinkWrap: true,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                        ),
                        itemBuilder: (context, index) {
                          int row = index ~/ 3;
                          int col = index % 3;
                          return GestureDetector(
                            onTap: () {
                              if (board[row][col].isEmpty) {
                                setState(() {
                                  makeMove(row, col);
                                  if (isComputerMode &&
                                      !checkForWinner() &&
                                      !isBoardFull()) {
                                    makeComputerMove();
                                  }
                                });
                              }
                            },
                            child: AnimatedContainer(
                              duration: Duration(milliseconds: 300),
                              curve: Curves.bounceInOut,
                              width: 100,
                              height: 100,
                              decoration: BoxDecoration(
                                border: Border.all(
                                    color: Color.fromARGB(255, 0, 0, 0),
                                    width: 2),
                                borderRadius: BorderRadius.circular(13),
                                color: board[row][col].isEmpty
                                    ? Color.fromARGB(255, 62, 1, 63)
                                    : Color.fromARGB(212, 113, 60, 122),
                              ),
                              child: Center(
                                child: AnimatedAlign(
                                  duration: Duration(
                                      milliseconds:
                                          700), // Adjust duration as needed
                                  alignment: Alignment(0.0, -0.5),
                                  child: Opacity(
                                    opacity: 1.0,
                                    child: Text(
                                      board[row][col],
                                      style: TextStyle(
                                        fontSize: 40,
                                        fontWeight: FontWeight.bold,
                                        color:
                                            Color.fromARGB(255, 231, 226, 232),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                        itemCount: 9,
                      ),
                      SizedBox(height: 30),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              _showDialog();
                            },
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              primary: Color.fromARGB(235, 105, 10, 160),
                              padding: EdgeInsets.all(10),
                            ),
                            child: Text(
                              'Change Mode',
                              style: TextStyle(
                                fontSize: 20,
                                fontFamily: "BlackHanSans",
                                color: Color.fromARGB(255, 209, 208, 240),
                              ),
                            ),
                          ),
                          SizedBox(width: 30),
                          ElevatedButton(
                            onPressed: () {
                              resetGame();
                            },
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              primary: Color.fromARGB(235, 105, 10, 160),
                              padding: EdgeInsets.all(10),
                            ),
                            child: Text(
                              'Play Again',
                              style: TextStyle(
                                fontSize: 20,
                                fontFamily: "BlackHanSans",
                                color: Color.fromARGB(255, 209, 208, 240),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),

            // Bottom buttons
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Color(0xff760a6d),
                      Color.fromARGB(255, 83, 5, 101)
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
                      color: Color(0xffffffff),
                      iconSize: 25,
                    ),
                    IconButton(
                      icon: Icon(
                        isAudioEnabled
                            ? Icons.volume_up_sharp
                            : Icons.volume_off_sharp,
                      ),
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
                      color: Color(0xffffffff),
                      iconSize: 25,
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget buildBottomBarButton(IconData icon, VoidCallback onPressed) {
    return IconButton(
      icon: Icon(
        icon,
        size: 25, // Adjust the icon size
      ),
      onPressed: onPressed,
      color: Color(0xfffffafa), // Adjust the icon color
    );
  }

  void makeMove(int row, int col) {
    if (isPlayer1Turn) {
      board[row][col] = 'X';
    } else {
      board[row][col] = 'O';
    }
    isPlayer1Turn = !isPlayer1Turn;

    // Add the following AnimatedContainer to create a popping animation
    int animatedRow = -1;
    int animatedCol = -1;
    double animatedOpacity = .0;

    Future.delayed(Duration(milliseconds: 100), () {
      setState(() {
        animatedOpacity = 1.0;
      });
    });

    if (checkForWinner()) {
      _showWinnerDialog();
    } else if (isBoardFull()) {
      _showDrawDialog();
    }
  }

  void makeComputerMove() {
    List<int> emptyCells = [];
    for (int i = 0; i < 3; i++) {
      for (int j = 0; j < 3; j++) {
        if (board[i][j].isEmpty) {
          emptyCells.add(i * 3 + j);
        }
      }
    }

    if (emptyCells.isNotEmpty) {
      int randomIndex = Random().nextInt(emptyCells.length);
      int selectedCell = emptyCells[randomIndex];
      int row = selectedCell ~/ 3;
      int col = selectedCell % 3;

      Future.delayed(Duration(seconds: 1), () {
        setState(() {
          makeMove(row, col);
        });

        if (checkForWinner()) {
          _showWinnerDialog();
        } else if (isBoardFull()) {
          _showDrawDialog();
        }
      });
    }
  }

  bool checkForWinner() {
    for (int i = 0; i < 3; i++) {
      if (board[i][0].isNotEmpty &&
          board[i][0] == board[i][1] &&
          board[i][1] == board[i][2]) {
        return true;
      }
      if (board[0][i].isNotEmpty &&
          board[0][i] == board[1][i] &&
          board[1][i] == board[2][i]) {
        return true;
      }
    }

    if (board[0][0].isNotEmpty &&
        board[0][0] == board[1][1] &&
        board[1][1] == board[2][2]) {
      return true;
    }

    if (board[0][2].isNotEmpty &&
        board[0][2] == board[1][1] &&
        board[1][1] == board[2][0]) {
      return true;
    }

    return false;
  }

  bool isBoardFull() {
    for (int i = 0; i < 3; i++) {
      for (int j = 0; j < 3; j++) {
        if (board[i][j].isEmpty) {
          return false;
        }
      }
    }
    return true;
  }

  void resetGame() {
    setState(() {
      board = List.generate(3, (_) => List.filled(3, ''));
      isPlayer1Turn = true;
    });
  }

  Future<void> _showDialog() async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Select Game Mode',
            style: TextStyle(
              color: Color(0xFF4E208B),
              fontFamily: 'BlackHanSans', // Choose the title color
            ),
          ),
          content: Container(
            padding: EdgeInsets.all(30.0),
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                    'images/pop.png'), // Replace with your image asset
                fit: BoxFit.cover,
              ),
              border: Border.all(
                color: Color.fromARGB(
                    255, 191, 138, 188), // Choose the border color
                width: 5.0, // Choose the border width
              ),
              borderRadius:
                  BorderRadius.circular(15.0), // Choose the border radius
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ElevatedButton.icon(
                  onPressed: () {
                    setState(() {
                      isComputerMode = false;
                    });
                    resetGame();
                    Navigator.of(context).pop();
                  },
                  icon: Icon(Icons.people),
                  label: Text(
                    'Multiplayer Mode',
                    style: TextStyle(
                      color: Colors.white, // Choose the button text color
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    primary: Color(0xFF4E208B), // Choose the button color
                  ),
                ),
                SizedBox(height: 10),
                ElevatedButton.icon(
                  onPressed: () {
                    setState(() {
                      isComputerMode = true;
                    });
                    resetGame();
                    Navigator.of(context).pop();
                    if (isComputerMode) {
                      makeComputerMove();
                    }
                  },
                  icon: Icon(Icons.computer),
                  label: Text(
                    'Computer Mode',
                    style: TextStyle(
                      color: Colors.white, // Choose the button text color
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    primary: Color(0xFF4E208B), // Choose the button color
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Future<void> _showWinnerDialog() async {
    String winner =
        isPlayer1Turn ? (isComputerMode ? 'Computer' : 'Player 1') : 'Player 1';

    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            '$winner Wins!',
            style: TextStyle(
              color: Color.fromARGB(255, 198, 4, 124),
              fontFamily: 'BlackHanSans', // Choose the title color
            ),
          ),
          actions: [
            ElevatedButton.icon(
              onPressed: () {
                resetGame();
                Navigator.of(context).pop();
              },
              icon: Icon(Icons.refresh),
              label: Text(
                'Play Again',
                style: TextStyle(
                  color: Colors.white, // Choose the button text color
                ),
              ),
              style: ElevatedButton.styleFrom(
                primary:
                    Color.fromARGB(255, 76, 4, 169), // Choose the button color
              ),
            ),
          ],
        );
      },
    );
  }

  Future<void> _showDrawDialog() async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'It\'s a Draw!',
            style: TextStyle(
              color: Color.fromARGB(255, 19, 3, 201),
              fontFamily: 'BlackHanSans', // Choose the title color
            ),
          ),
          actions: [
            ElevatedButton.icon(
              onPressed: () {
                resetGame();
                Navigator.of(context).pop();
              },
              icon: Icon(Icons.refresh),
              label: Text(
                'Play Again',
                style: TextStyle(
                  color: Colors.white, // Choose the button text color
                ),
              ),
              style: ElevatedButton.styleFrom(
                primary: Color(0xFF4E208B), // Choose the button color
              ),
            ),
          ],
        );
      },
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
                color: Color.fromARGB(
                    255, 212, 193, 211), // Choose the border color
                width: 5.0, // Choose the border width
              ),
              borderRadius:
                  BorderRadius.circular(15.0), // Choose the border radius
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    'Welcome to Tic Tac Toe!',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white, // Set text color to white
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    '1. Open the Tic Tac Toe app and choose a game mode',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white, // Set text color to white
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    '2. Tap on an empty square to place your symbol ("X" or "O")',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white, // Set text color to white
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    '3.Aim to get three of your symbols in a row to win.',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white, // Set text color to white
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    '4. If the board is full or someone wins, Play Again, if you want',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white, // Set text color to white
                    ),
                  ),
                ),
              ],
            ),
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              style: ElevatedButton.styleFrom(
                primary: Color.fromARGB(255, 116, 16,
                    138), // Set the background color of the button
              ),
              child: Text('open'),
            ),
          ],
        );
      },
    );
  }
}
