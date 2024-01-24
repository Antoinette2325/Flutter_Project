import 'package:flutter/material.dart';

class HistoryScreen extends StatefulWidget {
  @override
  _HistoryScreenState createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  int questionIndex = 0;
  int score = 0;
  int lives = 5;

  List<Map<String, Object>> questions = [
    {
      'question': 'In which year did Christopher Columbus reach the Americas?',
      'answers': ['1492', '1510', '1601'],
      'correctAnswer': '1492',
    },
    {
      'question': 'Who was the first President of the United States?',
      'answers': ['Thomas Jefferson', 'George Washington', 'John Adams'],
      'correctAnswer': 'George Washington',
    },
    {
      'question': 'What ancient civilization built the pyramids?',
      'answers': ['Greek', 'Roman', 'Egyptian'],
      'correctAnswer': 'Egyptian',
    },
    {
      'question': 'In which century did the Renaissance occur?',
      'answers': ['14th', '16th', '18th'],
      'correctAnswer': '14th',
    },
    {
      'question':
          'Who was the Queen of Egypt known for her relationship with Mark Antony and Julius Caesar?',
      'answers': ['Cleopatra', 'Nefertiti', 'Hatshepsut'],
      'correctAnswer': 'Cleopatra',
    },
    {
      'question': 'Which war is known as the "War to End All Wars"?',
      'answers': ['World War I', 'World War II', 'Vietnam War'],
      'correctAnswer': 'World War I',
    },
    {
      'question': 'Who was the first woman to win a Nobel Prize?',
      'answers': ['Marie Curie', 'Rosalind Franklin', 'Jane Goodall'],
      'correctAnswer': 'Marie Curie',
    },
    {
      'question': 'In which year did the Titanic sink?',
      'answers': ['1912', '1920', '1931'],
      'correctAnswer': '1912',
    },
    {
      'question': 'Who wrote "The Communist Manifesto"?',
      'answers': ['Karl Marx', 'Vladimir Lenin', 'Joseph Stalin'],
      'correctAnswer': 'Karl Marx',
    },
    {
      'question':
          'What event marked the beginning of the Great Depression in the 1930s?',
      'answers': ['Stock Market Crash', 'World War I', 'Prohibition'],
      'correctAnswer': 'Stock Market Crash',
    },
    {
      'question': 'Which civilization built the city of Machu Picchu?',
      'answers': ['Maya', 'Inca', 'Aztec'],
      'correctAnswer': 'Inca',
    },
    {
      'question': 'Who was the leader of the Soviet Union during World War II?',
      'answers': ['Joseph Stalin', 'Vladimir Putin', 'Mikhail Gorbachev'],
      'correctAnswer': 'Joseph Stalin',
    },
    {
      'question':
          'What was the name of the ship that carried the Pilgrims to America in 1620?',
      'answers': ['Mayflower', 'Santa Maria', 'Nina'],
      'correctAnswer': 'Mayflower',
    },
    {
      'question': 'Who was the first woman to fly solo across the Atlantic?',
      'answers': ['Amelia Earhart', 'Bessie Coleman', 'Harriet Quimby'],
      'correctAnswer': 'Amelia Earhart',
    },
    {
      'question':
          'In which year did the Berlin Wall fall, marking the end of the Cold War?',
      'answers': ['1989', '1991', '1993'],
      'correctAnswer': '1989',
    },
  ];
  String? selectedAnswer;

  void answerQuestion(String selectedAnswer) {
    setState(() {
      this.selectedAnswer = selectedAnswer;
    });
  }

  bool isAnswerSelected(String answer) {
    return selectedAnswer == answer;
  }

  void toggleAnswer(String answer) {
    setState(() {
      if (selectedAnswer == answer) {
        selectedAnswer = null; // Unselect the answer if already selected
      } else {
        selectedAnswer = answer; // Select the answer if not selected
      }
    });
  }

  bool isGameOver() {
    return lives <= 0 || questionIndex >= questions.length;
  }

  void submitAnswer() {
    if (selectedAnswer != null) {
      // Check the answer
      String correctAnswer =
          questions[questionIndex]['correctAnswer'] as String;

      bool isCorrect = selectedAnswer == correctAnswer;

      showDialog(
        context: context,
        builder: (BuildContext context) {
          if (!isCorrect) {
            // Deduct one life for incorrect answer
            lives--;
          }

          return AlertDialog(
            backgroundColor: Colors.transparent,
            title: Text(
              isCorrect ? 'Correct!' : 'Incorrect',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            content: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(
                      'images/pop.png'), // Replace with your image asset path
                  fit: BoxFit.cover,
                ),
                border: Border.all(
                    color: Color(0xffff8ffa), width: 8.0), // Border settings
                borderRadius: BorderRadius.circular(10.0), // Border radius
              ),
              padding: EdgeInsets.symmetric(
                  vertical: 10.0, horizontal: 20.0), // Adjust padding
              child: Column(
                mainAxisSize: MainAxisSize.min, // Set mainAxisSize to min
                children: [
                  Text(
                    isCorrect
                        ? 'Congratulations! You got it right.'
                        : 'Oops! That\'s not the correct answer. Try again!',
                    style: TextStyle(color: Colors.white),
                  ),
                  // Add more content or widgets here if needed
                ],
              ),
            ),
            actions: [
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop(); // Close the dialog
                  setState(() {
                    if (isCorrect) {
                      score++;
                    }

                    selectedAnswer = null; // Reset selected answer
                    questionIndex++;

                    if (lives <= 0) {
                      // User ran out of lives, show game over message
                      showGameOverDialog();
                    } else if (questionIndex >= questions.length) {
                      // Show quiz completion message or navigate to a result screen
                      _quizCompleted();
                      resetGame(); // Reset the game after completion
                    }
                  });
                },
                style: ElevatedButton.styleFrom(
                  primary: Color(
                      0xffe215b9), // Set the background color of the button
                ),
                child: Text(
                  'Next',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          );
        },
      );
    }
  }

  void showGameOverDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.transparent,
          content: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                    'images/pop.png'), // Replace with your image asset path
                fit: BoxFit.cover,
              ),
              border: Border.all(
                color: Color(0xffff8ffa), // Border color
                width: 2.0, // Border width
              ),
              borderRadius: BorderRadius.circular(10),
            ),
            padding: EdgeInsets.symmetric(vertical: 20, horizontal: 30),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "Game Over",
                  style: TextStyle(
                    color: Color(0xfffffaff),
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  "You ran out of lives. Your score: $score",
                  style: TextStyle(
                    color: Color(0xffffffff),
                    fontSize: 16,
                  ),
                ),
                SizedBox(height: 20),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    resetGame();
                  },
                  style: TextButton.styleFrom(
                    backgroundColor:
                        Color(0xfff126cf), // Set the background color
                  ),
                  child: Text(
                    "Play Again",
                    style: TextStyle(
                      color: Color(0xffffffff),
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _quizCompleted() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.transparent,
          content: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                    'images/pop.png'), // Replace with your image asset path
                fit: BoxFit.cover,
              ),
              border: Border.all(
                color: Color(0xffff8ffa), // Border color
                width: 2.0, // Border width
              ),
              borderRadius: BorderRadius.circular(10),
            ),
            padding: EdgeInsets.symmetric(vertical: 20, horizontal: 30),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "Congratulations!",
                  style: TextStyle(
                    color: Color(0xffffffff),
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  "You completed the quiz. Your score: $score",
                  style: TextStyle(
                    color: Color(0xffffffff),
                    fontSize: 16,
                  ),
                ),
                SizedBox(height: 20),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    resetGame();
                  },
                  style: TextButton.styleFrom(
                    backgroundColor:
                        Color(0xfff126cf), // Set the background color
                  ),
                  child: Text(
                    "Play Again",
                    style: TextStyle(
                      color: Color(0xffffffff),
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void resetGame() {
    setState(() {
      questionIndex = 0;
      score = 0;
      lives = 5;
      selectedAnswer = null; // Reset selected answer
      questions.shuffle();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          flexibleSpace: Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Color(0xff650868), Color(0xff961f9a)],
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                  ),
                ),
              ),
              Center(
                child: Container(
                  padding: EdgeInsets.all(16.0),
                  child: Text(
                    'History Quiz',
                    style: TextStyle(
                      // Add any desired styles for the title text
                      color: Colors.white,
                      fontSize: 18.0,
                    ),
                  ),
                ),
              ),
            ],
          ),
          elevation: 1,
        ),
        body: Center(
          child: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                    'images/4.jpg'), // Replace with your image asset path
                fit: BoxFit.cover,
              ),
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 90, horizontal: 20),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding:
                            EdgeInsets.symmetric(vertical: 20, horizontal: 30),
                        decoration: BoxDecoration(
                          color: Color(0xffeecbfb),
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            color: Color(0xff4e054b), // Set border color
                            width: 4.0, // Set border width
                          ),
                        ),
                        child: Text(
                          ' Score: $score',
                          style: TextStyle(
                            color: Color(0xff4e054b),
                            fontWeight: FontWeight.bold,
                            fontSize: 28,
                          ),
                        ),
                      ),
                      Row(
                        children: List.generate(
                          lives,
                          (index) => Icon(
                            Icons.favorite,
                            color: Color(0xffe6a3ff),
                            size: 30,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 30),
                  Container(
                    height: 400,
                    width: 300,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      gradient: LinearGradient(
                        colors: [Color(0xffc461c8), Color(0xff961f9a)],
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                      ),
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(20),
                      child: Column(
                        children: [
                          Text(
                            '${questions[questionIndex]['question']}',
                            style: TextStyle(fontSize: 20, color: Colors.white),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(height: 20),
                          ...(questions[questionIndex]['answers']
                                  as List<String>)
                              .map((answer) {
                            return Container(
                              margin: EdgeInsets.only(bottom: 10),
                              width: double.infinity,
                              child: ElevatedButton(
                                onPressed: () => toggleAnswer(answer),
                                style: ElevatedButton.styleFrom(
                                  primary: isAnswerSelected(answer)
                                      ? Color(0xffe7abdd)
                                      : Colors.white,
                                  onPrimary: Colors.black,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: Text(
                                    answer,
                                    style: TextStyle(fontSize: 16),
                                  ),
                                ),
                              ),
                            );
                          }).toList(),
                          SizedBox(height: 20),
                          ElevatedButton(
                            onPressed: submitAnswer,
                            style: ElevatedButton.styleFrom(
                              primary:
                                  Color(0xbd15072e), // Set the background color
                              onPrimary: Colors.white, // Set the text color
                              minimumSize: Size(150, 50), // Set the button size
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                    10), // Set the button border radius
                              ),
                            ),
                            child: Text(
                              ' Answer',
                              style: TextStyle(
                                  fontSize: 18,
                                  color: Colors
                                      .white), // Set the text size and color
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
