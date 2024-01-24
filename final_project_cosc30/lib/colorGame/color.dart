// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:math';
import 'package:finalproject/GamesScreen/games.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Bet {
  final Color color;
  final int betAmount;
  final bool isWin;

  Bet({
    required this.color,
    required this.betAmount,
    required this.isWin,
  });
}

class ColorGame extends StatefulWidget {
  @override
  _ColorGameState createState() => _ColorGameState();
}

TextEditingController _numberController = TextEditingController();

class _ColorGameState extends State<ColorGame> {
  int playerMoney = 100;
  Map<Color, int> bets = {};
  int borrowedMoney = 0;
  List<Color> colors = [
    Colors.red,
    Colors.green,
    Colors.blue,
    Colors.yellow,
    Colors.white,
    Colors.pink,
  ];
  List<Bet> betTable = [];
  TextEditingController _betAmountController = TextEditingController();
  List<Color> winningColorsResult = [];
  bool hasPlayerWon = false;

  @override
  void initState() {
    super.initState();
  }

  void _calculateResult(List<Color> winningColors) {
    betTable.clear(); // Clear existing entries in the betTable

    colors.forEach((color) {
      int betAmount = bets[color] ?? 0;
      int matchedColors =
          winningColors.where((winningColor) => winningColor == color).length;
      int winnings = betAmount * matchedColors;
      bool isWin = matchedColors > 0;

      if (isWin) {
        playerMoney += winnings;
      } else {
        playerMoney -= betAmount;
      }

      // Add the bet to the bet table
      betTable.add(Bet(color: color, betAmount: betAmount, isWin: isWin));
    });

    setState(() {
      winningColorsResult = winningColors;
    });

    if (playerMoney <= 0) {
      _showGameOverDialog();
    } else {
      hasPlayerWon = winningColorsResult.isNotEmpty;
    }
  }

  void _withdrawMoney() {
    bool obscureNumber = true;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Withdraw Money'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                  color: Colors.grey[200], // Set your desired background color
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _numberController, // Add this controller
                        keyboardType: TextInputType.number,
                        obscureText: obscureNumber,
                        decoration: InputDecoration(
                          hintText: 'Enter your number',
                          border: InputBorder.none, // Remove the border
                        ),
                      ),
                    ),
                    IconButton(
                      icon: Icon(obscureNumber
                          ? Icons.visibility
                          : Icons.visibility_off),
                      onPressed: () {
                        setState(() {
                          obscureNumber = !obscureNumber;
                        });
                      },
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10),
              Text('Enter the amount to withdraw:'),
              TextField(
                controller: _betAmountController,
                keyboardType: TextInputType.number,
              ),
              SizedBox(height: 5),
              ElevatedButton.icon(
                onPressed: () {
                  _handleWithdraw();
                  Navigator.pop(context);
                },
                icon: Icon(Icons.account_balance_wallet), // Added icon here
                label: Text('Withdraw'),
                style: ElevatedButton.styleFrom(
                  primary: Color.fromARGB(
                      255, 193, 2, 168), // Set your desired button color
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void _handleWithdraw() {
    setState(() {
      int withdrawAmount = int.tryParse(_betAmountController.text) ?? 0;
      int userNumber = int.tryParse(_numberController.text) ?? 0;

      // Add your secret number here
      int yourSecretNumber = 1234;

      if (userNumber == yourSecretNumber) {
        // Validate the withdrawal amount
        if (withdrawAmount > 0 &&
            withdrawAmount <= (playerMoney + borrowedMoney)) {
          playerMoney -= withdrawAmount;
        } else {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text('Invalid amount or not enough funds.'),
          ));
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Invalid number.'),
        ));
      }
    });
  }

  void _quitGame(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Log Out'),
          content: Text('Are you sure you want to log Out?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                SystemNavigator.pop();
              },
              child: Text('Out'),
            ),
          ],
        );
      },
    );
  }

  List<Color> _generateWinningColors() {
    Random random = Random();
    List<Color> winningColors = [];
    for (int i = 0; i < 3; i++) {
      winningColors.add(colors[random.nextInt(colors.length)]);
    }
    return winningColors;
  }

  void _resetGame() {
    setState(() {
      bets.clear();
      borrowedMoney = 0;
      hasPlayerWon = false;
      winningColorsResult.clear();
      betTable.clear(); // Clear the betTable after resetting the game
    });
  }

  void _borrowMoney() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Row(
            children: [
              Icon(
                Icons.account_balance, // Added icon here
                color: Colors.pink, // Set your desired icon color
              ),
              SizedBox(width: 10),
              Text('Bank'),
            ],
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Enter the amount to borrow (up to 1000):'),
              TextField(
                controller: _betAmountController,
                keyboardType: TextInputType.number,
              ),
              SizedBox(height: 5),
              ElevatedButton(
                onPressed: () {
                  _handleBorrow();
                  Navigator.pop(context);
                },
                child: Text('Borrow'),
                style: ElevatedButton.styleFrom(
                  primary: Colors.pink, // Set your desired button color
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void _handleBorrow() {
    setState(() {
      int borrowedAmount = int.tryParse(_betAmountController.text) ?? 0;
      int borrowingLimit = 1000;

      if (borrowedAmount > 0 &&
          borrowedAmount <= borrowingLimit &&
          (playerMoney + borrowedMoney + borrowedAmount) <= borrowingLimit) {
        borrowedMoney += borrowedAmount;
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Invalid amount or borrowing limit exceeded.'),
        ));
      }
    });
  }

  void _viewBetTable() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Bet Table',
            style: TextStyle(
              fontFamily: 'DelaGothicOne', // Add your custom font family
            ),
          ),
          content: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color.fromARGB(255, 95, 39, 156),
                  Color.fromARGB(255, 239, 201, 173),
                ],
              ),
            ),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Column(
                children: [
                  Container(
                    constraints: BoxConstraints(
                      maxWidth: MediaQuery.of(context).size.width,
                    ),
                    child: DataTable(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.transparent),
                      ),
                      columns: [
                        DataColumn(
                          label: Text(
                            'Color',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 13,
                            ),
                          ),
                        ),
                        DataColumn(
                          label: Text(
                            'Bet Amount',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 13,
                            ),
                          ),
                        ),
                        DataColumn(
                          label: Text(
                            'Result',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 13,
                            ),
                          ),
                        ),
                      ],
                      rows: betTable
                          .map(
                            (bet) => DataRow(
                              cells: [
                                DataCell(
                                  Text(
                                    _getColorName(bet.color),
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14,
                                    ),
                                  ),
                                ),
                                DataCell(
                                  Text(
                                    '${bet.betAmount}\$',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontStyle: FontStyle.italic,
                                      fontSize: 14,
                                    ),
                                  ),
                                ),
                                DataCell(
                                  Text(
                                    bet.isWin ? 'Win' : 'Lose',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontStyle: FontStyle.italic,
                                      fontSize: 14,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          )
                          .toList(),
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

  Widget _buildSettingItem(String title, IconData icon, Function()? onTap) {
    return ListTile(
      title: Text(title),
      leading: Icon(icon),
      onTap: onTap,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: buildBottomBar(context),
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('images/backgroundimage/Colorg.gif'),
              fit: BoxFit.cover,
            ),
          ),
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  FaIcon(
                    FontAwesomeIcons.coins,
                    color: Color.fromARGB(255, 251, 214, 5),
                    size: 30,
                  ),
                  SizedBox(width: 6),
                  Text(
                    '${playerMoney + borrowedMoney}',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 50),
              Wrap(
                alignment: WrapAlignment.center,
                children: colors
                    .map(
                      (color) => GestureDetector(
                        onTap: () => _selectBetAmount(color),
                        child: Container(
                          width: 100,
                          height: 100,
                          decoration: BoxDecoration(
                            color: color,
                            border: Border.all(
                              color: Color.fromARGB(255, 9, 0, 8),
                              width: 3,
                            ),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          child: Center(
                            child: Text(
                              bets.containsKey(color) ? '${bets[color]}\$' : '',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                    )
                    .toList(),
              ),
              SizedBox(height: 15),
              ElevatedButton(
                onPressed: _rollDice,
                style: ButtonStyle(
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      side:
                          BorderSide(color: Color.fromARGB(255, 251, 251, 251)),
                    ),
                  ),
                  backgroundColor: MaterialStateProperty.all<Color>(
                      Color.fromARGB(255, 193, 2, 168)),
                  textStyle: MaterialStateProperty.all<TextStyle>(
                    TextStyle(
                      fontSize: 29,
                      fontFamily: 'BlackHanSans',
                    ),
                  ),
                ),
                child: Text('ROLL'),
              ),
              SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    padding: EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Color.fromARGB(255, 199, 199, 199),
                        width: 6,
                      ),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Wrap(
                      spacing: 10,
                      runSpacing: 10,
                      children: winningColorsResult.isNotEmpty
                          ? winningColorsResult
                              .map((color) => Container(
                                    width: 80,
                                    height: 80,
                                    decoration: BoxDecoration(
                                      color: color,
                                      borderRadius: BorderRadius.circular(10),
                                      border: Border.all(
                                        color:
                                            Color.fromARGB(255, 242, 240, 240),
                                        width: 5,
                                      ),
                                    ),
                                  ))
                              .toList()
                          : [],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton.icon(
                    onPressed: _resetGame,
                    icon: FaIcon(
                      FontAwesomeIcons.rotateRight,
                      color: Color.fromARGB(255, 250, 151, 252),
                      size: 20,
                    ),
                    label: Text(''),
                    style: ButtonStyle(
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                      ),
                      backgroundColor: MaterialStateProperty.all<Color>(
                          Color.fromARGB(255, 50, 48, 48)),
                    ),
                  ),
                  SizedBox(width: 5),
                  ElevatedButton.icon(
                    onPressed: _borrowMoney,
                    icon: FaIcon(
                      FontAwesomeIcons.bank,
                      color: Color.fromARGB(255, 250, 151, 252),
                      size: 20,
                    ),
                    label: Text(''),
                    style: ButtonStyle(
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                      ),
                      backgroundColor: MaterialStateProperty.all<Color>(
                          Color.fromARGB(255, 50, 48, 48)),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _selectBetAmount(Color color) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Row(
            children: [
              Icon(
                Icons.monetization_on,
                color: Colors.pink,
              ),
              SizedBox(width: 10),
              Text('Select Bet Amount'),
            ],
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Select the bet amount for ${_getColorName(color)}:'),
              TextField(
                controller: _betAmountController,
                keyboardType: TextInputType.number,
              ),
              ElevatedButton(
                onPressed: () {
                  _handleBet(color);
                  Navigator.pop(context);
                },
                child: Text('Place Bet'),
                style: ElevatedButton.styleFrom(
                  primary: Colors.pink,
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  int _calculateWinnings() {
    int totalWinnings = 0;
    bets.forEach((color, betAmount) {
      int matchedColors = winningColorsResult
          .where((winningColor) => winningColor == color)
          .length;
      int winnings = betAmount * matchedColors;
      totalWinnings += winnings;
    });
    return totalWinnings;
  }

  int _calculateLoss() {
    int totalLoss = 0;
    bets.forEach((color, betAmount) {
      int matchedColors = winningColorsResult
          .where((winningColor) => winningColor == color)
          .length;
      if (matchedColors == 0) {
        totalLoss += betAmount;
      }
    });
    return totalLoss;
  }

  void _rollDice() {
    winningColorsResult = _generateWinningColors();

    // Add all colors to the betTable with their respective bet amounts
    colors.forEach((color) {
      int betAmount = bets[color] ?? 0;
      betTable.add(Bet(color: color, betAmount: betAmount, isWin: false));
    });

    _calculateResult(winningColorsResult);

    // No need to clear the betTable here, as it's done in _calculateResult
  }

  void _handleBet(Color color) {
    int betAmount = int.tryParse(_betAmountController.text) ?? 0;
    if (betAmount > 0 && (playerMoney + borrowedMoney) >= betAmount) {
      setState(() {
        bets[color] = betAmount;
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Invalid amount or not enough funds.'),
      ));
    }
  }

  String _getColorName(Color color) {
    if (color == Colors.red) return 'Red';
    if (color == Colors.green) return 'Green';
    if (color == Colors.blue) return 'Blue';
    if (color == Colors.yellow) return 'Yellow';
    if (color == Colors.white) return 'White';
    if (color == Colors.pink) return 'Pink';

    return 'Unknown';
  }

  void _showGameOverDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Game Over'),
          content: Text('You are out of money! You Can Borrow '),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Ok'),
            ),
          ],
        );
      },
    );
  }

  Widget buildBottomBar(BuildContext context) {
    return Container(
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
                color: Color.fromARGB(255, 106, 85, 105),
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
                    'Welcome to Color Game!',
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
                    '1. Place a Bet: Players can select a color and enter the amount they want to bet on that color by tapping on it.',
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
                    '2. Roll : Players can roll  and see if they win or lose based on the randomly generated winning colors.',
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
                    '3.Bank Money: Players can withdraw money from the bank ',
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
                    '4.Reset Game: Players can reset the game, clearing all bets and results. ',
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
                primary: Color.fromARGB(255, 68, 3, 75),
              ),
              child: Text('Close'),
            ),
          ],
        );
      },
    );
  }
}
