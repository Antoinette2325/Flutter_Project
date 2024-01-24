import 'dart:async';
import 'package:finalproject/GamesScreen/games.dart';
import 'package:flutter/material.dart';
import 'dart:math';

class SlotMachine extends StatefulWidget {
  @override
  _SlotMachineState createState() => _SlotMachineState();
}

class _SlotMachineState extends State<SlotMachine> {
  List<String> symbols = [
    'images/slot/banana.png',
    'images/slot/bell.png',
    'images/slot/cherry.png',
    'images/slot/lemon.png',
    'images/slot/orange.png',
    'images/slot/plum.png',
  ];
  List<String> currentSymbols = [
    'images/slot/orange.png',
    'images/slot/cherry.png',
    'images/v/bell.png',
  ];
  late Timer _timer;
  int _animationSpeed = 600; // Slower speed for animation (milliseconds)
  int _spinDuration = 6; // Spin time in seconds
  int _betAmount = 10; // Initial bet amount
  int _currentMoney = 100; // Initial amount of money
  TextEditingController _customBetController = TextEditingController();
  bool _isSpinning = false;
  int _currentSymbolIndex1 = 0;
  int _currentSymbolIndex2 = 1;
  int _currentSymbolIndex3 = 2;

  void spin() {
    setState(() {
      if (_isSpinning) {
        // Check if already spinning
        return;
      }

      if (_currentMoney <= 0) {
        // Check if the credit is insufficient
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Cannot Spin'),
            content: Text('You have insufficient balance to spin.'),
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
      } else if (_customBetController.text.isEmpty) {
        // Check if a bet amount is set
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('No Bet Amount'),
            content: Text('Please set a bet amount before spinning.'),
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
        _isSpinning = true;
        int customBet = int.tryParse(_customBetController.text) ?? _betAmount;
        _currentMoney -=
            customBet; // Subtract the bet amount from current money
        _animateSpin();
      }
    });
  }

  void stopSpin() {
    setState(() {
      _timer.cancel();
      _isSpinning = false;
    });
  }

  void _animateSpin() {
    var random = Random();
    int spins = 5; // Number of spins before showing the final result
    int currentSpin = 0;

    _timer = Timer.periodic(Duration(milliseconds: _animationSpeed), (timer) {
      setState(() {
        _currentSymbolIndex1 = random.nextInt(symbols.length);
        _currentSymbolIndex2 = random.nextInt(symbols.length);
        _currentSymbolIndex3 = random.nextInt(symbols.length);

        currentSpin++;

        if (currentSpin >= spins) {
          _timer.cancel();
          _isSpinning = false;
          startTimer(); // Start the timer for the final result
        }
      });
    });
  }

  void startTimer() {
    _timer = Timer.periodic(Duration(seconds: _spinDuration), (timer) {
      // Check for winning conditions
      checkWinning();
      _timer.cancel(); // Cancel the timer after one iteration
    });
  }

  void checkWinning() {
    if (currentSymbols[0] == currentSymbols[1] &&
        currentSymbols[1] == currentSymbols[2]) {
      // Jackpot! All three symbols match
      int jackpotMultiplier = 10; // You can customize the jackpot multiplier
      int jackpotWin = _betAmount * jackpotMultiplier;
      _currentMoney += jackpotWin; // Add jackpot winnings to current money

      // Display a jackpot dialog
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Jackpot!'),
            content: Text('You won the jackpot of $jackpotWin coins!'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(); // Close the dialog
                  stopSpin(); // Stop the spinning animation
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    } else if (currentSymbols[0] == currentSymbols[1] ||
        currentSymbols[1] == currentSymbols[2] ||
        currentSymbols[0] == currentSymbols[2]) {
      // Two symbols match
      int winMultiplier = 5; // You can customize the win multiplier
      int winAmount = _betAmount * winMultiplier;
      _currentMoney += winAmount; // Add winnings to current money

      // Display a win dialog
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Congratulations!'),
            content: Text('You won $winAmount coins!'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(); // Close the dialog
                  stopSpin(); // Stop the spinning animation
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    } else {
      // No match, inform the user
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('No Win'),
            content: Text('Better luck next time!'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(); // Close the dialog
                  stopSpin(); // Stop the spinning animation
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    }
    // Update the current balance display
    setState(() {});
  }

  @override
  void dispose() {
    _customBetController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('images/backgroundimage/Slot.gif'),
          fit: BoxFit.cover,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: null,
        body: Stack(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                SizedBox(height: 60),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      margin: EdgeInsets.only(
                          bottom: 10), // Adjust the margin as needed
                      child: ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          primary: Color.fromARGB(255, 33, 2, 58),
                        ),
                        child: Text(
                          'Current Money: \$$_currentMoney',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                            fontFamily: 'WorkSans',
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 0), // Add some space here
                  ],
                ),
                Expanded(
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              width: 100,
                              height: 170,
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Color.fromARGB(255, 167, 131, 3),
                                  width: 4.0,
                                ),
                              ),
                              child: Image.asset(
                                symbols[_currentSymbolIndex1],
                                width: 80,
                                height: 80,
                              ),
                            ),
                            Container(
                              width: 100,
                              height: 170,
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Color.fromARGB(255, 167, 131, 3),
                                  width: 4.0,
                                ),
                              ),
                              child: Image.asset(
                                symbols[_currentSymbolIndex2],
                                width: 80,
                                height: 80,
                              ),
                            ),
                            Container(
                              width: 100,
                              height: 170,
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Color.fromARGB(255, 167, 131, 3),
                                  width: 4.0,
                                ),
                              ),
                              child: Image.asset(
                                symbols[_currentSymbolIndex3],
                                width: 100,
                                height: 80,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 40),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            ElevatedButton(
                              onPressed: () {
                                spin();
                              },
                              style: ElevatedButton.styleFrom(
                                padding: EdgeInsets.all(16.0),
                                minimumSize: Size(150, 60),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                      30.0), // Adjust the value as needed
                                ),
                                backgroundColor: Color.fromARGB(255, 209, 150,
                                    0), // Change the color as needed
                              ),
                              child: Text(
                                'SPIN',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontFamily: "WorkSans-SemiBold",
                                ),
                              ),
                            ),
                            ElevatedButton(
                              onPressed: () {
                                stopSpin();
                              },
                              style: ElevatedButton.styleFrom(
                                padding: EdgeInsets.all(16.0),
                                minimumSize: Size(150, 60),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                      30.0), // Adjust the value as needed
                                ),
                                backgroundColor: Color.fromARGB(255, 169, 5,
                                    219), // Change the color as needed
                              ),
                              child: Text(
                                'STOP SPIN',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontFamily: 'WorkSans-SemiBold',
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 25),
                        Container(
                          width: 200,
                          decoration: BoxDecoration(
                            color: Color.fromARGB(255, 233, 233, 233),
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                          child: TextField(
                            controller: _customBetController,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              labelText: 'Custom Bet',
                              hintText: 'Enter custom bet amount',
                              contentPadding: EdgeInsets.all(1.0),
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
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
                      Color(0xff4e054b),
                    ],
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
                      icon: Icon(Icons.volume_up),
                      onPressed: () {
                        // Toggle sound or perform sound-related action
                      },
                      color: Color(0xffffffff),
                      iconSize: 25,
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

  // Tutorial dialog method
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
                color: Color.fromARGB(255, 147, 143, 147),
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
                    'Welcome to the Slot Machine!',
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
                    'How to Play?',
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
                    '1. Place Your Bet: Enter your desired bet amount using the provided input field or choose from preset options.!',
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
                    '2. Spin the Reels: Press the "SPIN" button to set the reels in motion and anticipate matching symbols for a win',
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
                    '3. Claim Your Winnings: If the symbols align, youll either win coins or hit the jackpot. Claim your winnings and enjoy the game!',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
                // ... (rest of the tutorial dialog content)
              ],
            ),
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              style: ElevatedButton.styleFrom(
                primary: Color.fromARGB(255, 99, 19, 85),
              ),
              child: Text('Close'),
            ),
          ],
        );
      },
    );
  }
}
