import 'dart:async';
import 'package:finalproject/GamesScreen/games.dart';
import 'package:flutter/material.dart';
import 'dart:math';
import 'package:audioplayers/audioplayers.dart';

void main() {
  runApp(DiceGame());
}

class DiceGame extends StatefulWidget {
  @override
  _DiceGameState createState() => _DiceGameState();
}

class _DiceGameState extends State<DiceGame> {
  int animatedRow = -1;
  int animatedCol = -1;
  double animatedOpacity = 1.0;
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

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Stack(
          children: [
            Image.asset(
              'images/backgroundimage/Rolling.gif',
              fit: BoxFit.cover,
              width: double.infinity,
              height: double.infinity,
            ),
            RollingDice(),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: buildBottomBar(context),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildBottomBar(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xff760a6d), Color(0xff4e054b)],
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
                image: AssetImage('images/pop.png'),
                fit: BoxFit.cover,
              ),
              border: Border.all(
                color: Color.fromARGB(255, 135, 120, 135),
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
                    'Welcome to the Dice Game Tutorial!',
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
                    '1. Choose your bet and select two dice.',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    '2. Roll the dice and see the result.',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    '3. Win by getting a match or even a jackpot!',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              style: ElevatedButton.styleFrom(
                primary: Color.fromARGB(255, 75, 5, 71),
              ),
              child: Text('Close'),
            ),
          ],
        );
      },
    );
  }
}

class RollingDice extends StatefulWidget {
  @override
  _RollingDiceState createState() => _RollingDiceState();
}

class _RollingDiceState extends State<RollingDice> {
  List<String> diceFaces = [
    'images/dice/dice1.png',
    'images/dice/dice2.png',
    'images/dice/dice3.png',
    'images/dice/dice4.png',
    'images/dice/dice5.png',
    'images/dice/dice6.png',
  ];
  late Timer _timer;
  int _animationSpeed = 200;
  int _rollDuration = 3;
  int _betAmount = 10;
  int _currentMoney = 100;
  bool _isRolling = false;
  int _currentDiceIndex1 = 0;
  int _currentDiceIndex2 = 1;
  List<int> _selectedDiceIndices = [0, 1];
  TextEditingController _betController = TextEditingController();

  IconData? get coinIcon => null;

  void rollDice() {
    setState(() {
      if (_isRolling || _selectedDiceIndices.length != 2) {
        return;
      }

      if (_currentMoney <= 0) {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Cannot Roll'),
            content: Text('You have insufficient balance to roll.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('OK'),
              ),
            ],
          ),
        );
      } else {
        _isRolling = true;
        _currentMoney -= _betAmount;
        _animateRoll();
      }
    });
  }

  void _animateRoll() {
    var random = Random();
    int rolls = 5;
    int currentRoll = 0;

    _timer = Timer.periodic(Duration(milliseconds: _animationSpeed), (timer) {
      setState(() {
        _currentDiceIndex1 = random.nextInt(diceFaces.length);
        _currentDiceIndex2 = random.nextInt(diceFaces.length);

        currentRoll++;

        if (currentRoll >= rolls) {
          _timer.cancel();
          _isRolling = false;
          startTimer();
        }
      });
    });
  }

  void startTimer() {
    _timer = Timer(Duration(seconds: _rollDuration), () {
      print(
          'Result: ${diceFaces[_currentDiceIndex1]}, ${diceFaces[_currentDiceIndex2]}');
      _timer.cancel();
      checkResult();
    });
  }

  void checkResult() {
    bool isWinning = _selectedDiceIndices.any((index) =>
        diceFaces[index] ==
        'assets/images/dice4.png'); // Napoli is dice with index 3 (0-based)
    bool isJackpot = _selectedDiceIndices.length == 2 &&
        _selectedDiceIndices[0] == _selectedDiceIndices[1];

    if (isWinning) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Congratulations!'),
          content: isJackpot
              ? Text('Jackpot! You won double the bet.')
              : Text('You won!'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        ),
      );
      if (isJackpot) {
        _currentMoney += _betAmount * 2;
      } else {
        _currentMoney += _betAmount;
      }
    } else {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Better Luck Next Time'),
          content: Text('None of the selected dice match Napoli.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        ),
      );
    }
    setState(() {}); // Update the UI to reflect the current money
  }

  void resetGame() {
    setState(() {
      _currentMoney = 100;
      _betAmount = 10;
      _isRolling = false;
      _currentDiceIndex1 = 0;
      _currentDiceIndex2 = 1;
      _selectedDiceIndices = [0, 1];
      _betController.clear();
      _timer.cancel();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 100.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons
                    .attach_money_rounded, // Replace with your desired coin icon
                color: Color.fromARGB(255, 255, 183, 0),
                size: 30,
              ),
              SizedBox(width: 0), // Add some space between the icon and text
              Text(
                ':$_currentMoney',
                style: TextStyle(
                  fontSize: 30,
                  color: Color.fromARGB(255, 255, 255, 255),
                  fontFamily: 'BlackHanSans',
                ),
              ),
            ],
          ),
          SizedBox(height: 30),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                diceFaces[_currentDiceIndex1],
                width: 90,
                height: 90,
              ),
              SizedBox(width: 20),
              Image.asset(
                diceFaces[_currentDiceIndex2],
                width: 90,
                height: 90,
              ),
            ],
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              for (int i = 0; i < diceFaces.length / 2; i++)
                GestureDetector(
                  onTap: () {
                    setState(() {
                      int index = i % 3;
                      if (_selectedDiceIndices.contains(index)) {
                        _selectedDiceIndices.remove(index);
                      } else {
                        if (_selectedDiceIndices.length < 2) {
                          _selectedDiceIndices.add(index);
                        }
                      }
                    });
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Image.asset(
                      diceFaces[i],
                      width: 50,
                      height: 50,
                      color: _selectedDiceIndices.contains(i)
                          ? Color.fromARGB(255, 211, 173, 240)
                          : null,
                    ),
                  ),
                ),
            ],
          ),
          SizedBox(height: 2),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              for (int i = 3; i < diceFaces.length; i++)
                GestureDetector(
                  onTap: () {
                    setState(() {
                      int index = i;
                      if (_selectedDiceIndices.contains(index)) {
                        _selectedDiceIndices.remove(index);
                      } else {
                        if (_selectedDiceIndices.length < 2) {
                          _selectedDiceIndices.add(index);
                        }
                      }
                    });
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Image.asset(
                      diceFaces[i],
                      width: 50,
                      height: 50,
                      color: _selectedDiceIndices.contains(i)
                          ? Color.fromARGB(255, 237, 203, 241)
                          : null,
                    ),
                  ),
                ),
            ],
          ),
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Container(
                  height: 60,
                  // Set the height as per your requirement
                  child: TextField(
                    controller: _betController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: 'Enter amount of bet',
                      labelStyle: TextStyle(
                        color: Color.fromARGB(255, 253, 252, 252),
                        fontFamily:
                            'BlackHanSans', // Set the text color to white
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 50),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {
                  int enteredBet = int.tryParse(_betController.text) ?? 0;
                  if (enteredBet > 0 && _selectedDiceIndices.length == 2) {
                    setState(() {
                      _betAmount = enteredBet;
                    });
                    rollDice();
                  } else {
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: Text('Invalid Bet'),
                        content: Text(
                            'Please enter a valid bet amount and select exactly two dice.'),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: Text('OK'),
                          ),
                        ],
                      ),
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.all(2.0),
                  minimumSize: Size(150, 60),
                ),
                child: _isRolling
                    ? CircularProgressIndicator(
                        color: Color(0xff041c7a),
                      )
                    : Text(
                        'ROLL DICE',
                        style: TextStyle(
                          fontSize: 20,
                          color: Color(0xff250a3d),
                          fontFamily: 'BlackHanSans',
                        ),
                      ),
              ),
            ],
          ),
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: resetGame,
                style: ElevatedButton.styleFrom(
                  primary: Color.fromARGB(
                      255, 203, 202, 199), // Change the button color if needed
                  padding: EdgeInsets.all(16.0),
                  minimumSize: Size(150, 60),
                ),
                child: Text(
                  'RESET',
                  style: TextStyle(
                    fontSize: 20,
                    color: Color.fromARGB(255, 7, 47, 148),
                    fontFamily: 'BlackHanSans',
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 20),
        ],
      ),
    );
  }
}
