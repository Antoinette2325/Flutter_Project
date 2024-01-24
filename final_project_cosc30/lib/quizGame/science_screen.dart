// science_screen.dart
import 'package:flutter/material.dart';

class ScienceScreen extends StatefulWidget {
  @override
  _ScienceScreenState createState() => _ScienceScreenState();
}

class _ScienceScreenState extends State<ScienceScreen> {
  int questionIndex = 0;
  int score = 0;
  int lives = 5;

  List<Map<String, Object>> questions = [
    {
      'question': 'What is the largest planet in our solar system?',
      'answers': ['Jupiter', 'Saturn', 'Mars'],
      'correctAnswer': 'Jupiter',
    },
    {
      'question': 'What is the powerhouse of the cell?',
      'answers': ['Nucleus', 'Mitochondria', 'Endoplasmic Reticulum'],
      'correctAnswer': 'Mitochondria',
    },
    {
      'question': 'What is the atomic number of oxygen?',
      'answers': ['8', '16', '32'],
      'correctAnswer': '8',
    },
    {
      'question': 'Which gas do plants absorb during photosynthesis?',
      'answers': ['Oxygen', 'Carbon Dioxide', 'Nitrogen'],
      'correctAnswer': 'Carbon Dioxide',
    },
    {
      'question': 'What is the smallest bone in the human body?',
      'answers': ['Stapes', 'Femur', 'Radius'],
      'correctAnswer': 'Stapes',
    },
    {
      'question': 'Who developed the theory of relativity?',
      'answers': ['Isaac Newton', 'Albert Einstein', 'Galileo Galilei'],
      'correctAnswer': 'Albert Einstein',
    },
    {
      'question': 'What is the chemical symbol for gold?',
      'answers': ['Au', 'Ag', 'Fe'],
      'correctAnswer': 'Au',
    },
    {
      'question': 'Which planet is known as the Morning Star?',
      'answers': ['Venus', 'Mars', 'Mercury'],
      'correctAnswer': 'Venus',
    },
    {
      'question': 'What is the largest organ in the human body?',
      'answers': ['Heart', 'Liver', 'Skin'],
      'correctAnswer': 'Skin',
    },
    {
      'question': 'What is the speed of light?',
      'answers': ['300,000 km/s', '150,000 km/s', '450,000 km/s'],
      'correctAnswer': '300,000 km/s',
    },
    {
      'question': 'Which gas makes up the majority of Earth\'s atmosphere?',
      'answers': ['Oxygen', 'Carbon Dioxide', 'Nitrogen'],
      'correctAnswer': 'Nitrogen',
    },
    {
      'question': 'Who discovered penicillin?',
      'answers': ['Marie Curie', 'Alexander Fleming', 'Louis Pasteur'],
      'correctAnswer': 'Alexander Fleming',
    },
    {
      'question': 'What is the powerhouse of the cell?',
      'answers': ['Nucleus', 'Mitochondria', 'Endoplasmic Reticulum'],
      'correctAnswer': 'Mitochondria',
    },
    {
      'question': 'What is the atomic number of carbon?',
      'answers': ['6', '12', '18'],
      'correctAnswer': '6',
    },
    {
      'question': 'Which planet is known as the Red Planet?',
      'answers': ['Mars', 'Jupiter', 'Venus'],
      'correctAnswer': 'Mars',
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
                    'Science Quiz',
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
