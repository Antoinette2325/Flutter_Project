import 'package:finalproject/GamesScreen/games.dart';
import 'package:flutter/material.dart';
import 'dart:math';

void main() => runApp(SudokuApp());

class SudokuApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sudoku',
      home: SudokuScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class SudokuScreen extends StatefulWidget {
  @override
  _SudokuScreenState createState() => _SudokuScreenState();
}

class _SudokuScreenState extends State<SudokuScreen> {
  List<List<int>> _puzzle = [];
  List<List<int>> _solution = [];
  int _selectedRow = -1;
  int _selectedCol = -1;
  bool _isComplete = false;

  @override
  void initState() {
    super.initState();
    _generatePuzzle();
  }

  void _generatePuzzle() {
    var rng = Random();
    _solution =
        List.generate(9, (_) => List.generate(9, (_) => rng.nextInt(9) + 1));
    _puzzle = List.generate(9, (_) => List.generate(9, (_) => 0));
    for (int i = 0; i < 9; i++) {
      for (int j = 0; j < 9; j++) {
        if (rng.nextDouble() < 0.5) {
          _puzzle[i][j] = _solution[i][j];
        }
      }
    }
  }

  void _checkComplete() {
    _isComplete = true;
    for (int i = 0; i < 9; i++) {
      for (int j = 0; j < 9; j++) {
        if (_puzzle[i][j] == 0) {
          _isComplete = false;
          return;
        }
        if (_puzzle[i][j] != _solution[i][j]) {
          _isComplete = false;
        }
      }
    }
  }

  void _selectCell(int row, int col) {
    setState(() {
      _selectedRow = row;
      _selectedCol = col;
    });
  }

  void _enterNumber(int number) {
    if (_selectedRow != -1 && _selectedCol != -1) {
      if (_isNumberValid(_selectedRow, _selectedCol, number)) {
        setState(() {
          _puzzle[_selectedRow][_selectedCol] = number;
          _checkComplete();
        });
      }
    }
  }

  bool _isNumberValid(int row, int col, int number) {
    for (int i = 0; i < 9; i++) {
      if (_puzzle[row][i] == number) {
        return false; // Check if the number is already in the same row
      }
      if (_puzzle[i][col] == number) {
        return false; // Check if the number is already in the same column
      }
    }

    int startRow = (row ~/ 3) * 3;
    int startCol = (col ~/ 3) * 3;
    for (int i = startRow; i < startRow + 3; i++) {
      for (int j = startCol; j < startCol + 3; j++) {
        if (_puzzle[i][j] == number) {
          return false; // Check if the number is already in the same 3x3 grid
        }
      }
    }

    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xff701579),
              Color(0xffa433ae),
            ], // Define your gradient colors
          ),
        ),
        child: Center(
          child: Column(
            children: <Widget>[
              Expanded(
                child: Padding(
                  padding: EdgeInsets.all(30.0),
                  child: Container(
                    child: GridView.count(
                      crossAxisCount: 9,
                      children: List.generate(81, (index) {
                        int row = index ~/ 9;
                        int col = index % 9;
                        return GestureDetector(
                          onTap: () {
                            _selectCell(row, col);
                          },
                          child: Container(
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.grey,
                              ),
                              color: _selectedRow == row && _selectedCol == col
                                  ? Colors.yellow
                                  : Colors.white,
                            ),
                            child: Text(
                              _puzzle[row][col] == 0
                                  ? ''
                                  : _puzzle[row][col].toString(),
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: _puzzle[row][col] == _solution[row][col]
                                    ? Colors.green
                                    : Colors.black,
                              ),
                            ),
                          ),
                        );
                      }),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
              TextButton(
                style: TextButton.styleFrom(
                  backgroundColor:
                      Color(0xff53054d), // Add your desired background color
                ),
                child: Text(
                  'Reset',
                  style: TextStyle(
                    fontSize: 16, // Adjust the font size as needed
                    color: Colors.white, // Adjust the font color as needed
                  ),
                ),
                onPressed: () {
                  setState(() {
                    _generatePuzzle();
                    _selectedRow = -1;
                    _selectedCol = -1;
                    _isComplete = false;
                  });
                },
              ),
              SizedBox(height: 8),
              _isComplete
                  ? Text(
                      'Congratulations! You solved the puzzle!',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.green,
                      ),
                    )
                  : SizedBox(height: 20),
              Container(
                color: Color(0xffcd8adb),
                padding: EdgeInsets.all(10.0),
                child: Container(
                  height: 90, // Adjust the height as needed
                  width: 300, // Adjust the width as needed
                  child: Column(
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          _buildNumberButtons([1, 2, 3, 4, 5],
                              fontSize: 18, textColor: Color(0xffdc0d7f)),
                        ],
                      ),
                      SizedBox(height: 15),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          _buildNumberButtons([6, 7, 8, 9],
                              fontSize: 18, textColor: Color(0xffdc0d7f)),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 30),
              buildBottomBar(context), // Added bottom bar
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNumberButtons(List<int> numbers,
      {double fontSize = 16, Color textColor = Colors.black}) {
    return Row(
      children: [
        for (int number in numbers)
          _buildNumberButton(number, fontSize: fontSize, textColor: textColor),
      ],
    );
  }

  Widget _buildNumberButton(int number,
      {double fontSize = 16, Color textColor = Colors.black}) {
    return TextButton(
      onPressed: () {
        _enterNumber(number);
      },
      child: Text(
        number.toString(),
        style: TextStyle(fontSize: fontSize, color: textColor),
      ),
    );
  }

  // Bottom bar method
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
                color: Color(0xffff8ffa),
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
                    'Welcome to the Quiz App Tutorial!',
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
                primary: Color(0xffe215b9),
              ),
              child: Text('Close'),
            ),
          ],
        );
      },
    );
  }
}
