// technology_screen.dart
import 'package:flutter/material.dart';

class TechnologyScreen extends StatefulWidget {
  @override
  _TechnologyScreenState createState() => _TechnologyScreenState();
}

class _TechnologyScreenState extends State<TechnologyScreen> {
  int questionIndex = 0;
  int score = 0;
  int lives = 5;

  List<Map<String, Object>> questions = [
    {
      'question': 'Who is the co-founder of Microsoft?',
      'answers': ['Steve Jobs', 'Bill Gates', 'Elon Musk'],
      'correctAnswer': 'Bill Gates',
    },
    {
      'question': 'What does CPU stand for?',
      'answers': [
        'Central Processing Unit',
        'Computer Processing Unit',
        'Central Processor Unit'
      ],
      'correctAnswer': 'Central Processing Unit',
    },
    {
      'question': 'Which company developed the first computer mouse?',
      'answers': ['Apple', 'IBM', 'Xerox'],
      'correctAnswer': 'Xerox',
    },
    {
      'question':
          'What is the programming language developed by Apple for iOS and macOS app development?',
      'answers': ['Java', 'Swift', 'C#'],
      'correctAnswer': 'Swift',
    },
    {
      'question': 'Who is the CEO of Tesla and SpaceX?',
      'answers': ['Elon Musk', 'Mark Zuckerberg', 'Jeff Bezos'],
      'correctAnswer': 'Elon Musk',
    },
    {
      'question': 'What does HTML stand for in web development?',
      'answers': [
        'Hyperlink and Text Markup Language',
        'Hypertext Markup Language',
        'High-Level Text Markup Language'
      ],
      'correctAnswer': 'Hypertext Markup Language',
    },
    {
      'question': 'Which social media platform was founded by Mark Zuckerberg?',
      'answers': ['Twitter', 'Instagram', 'Facebook'],
      'correctAnswer': 'Facebook',
    },
    {
      'question':
          'What is the main function of a router in a computer network?',
      'answers': [
        'Data storage',
        'Internet connection',
        'Data traffic management'
      ],
      'correctAnswer': 'Data traffic management',
    },
    {
      'question': 'What is the largest e-commerce platform in the world?',
      'answers': ['Amazon', 'Alibaba', 'eBay'],
      'correctAnswer': 'Alibaba',
    },
    {
      'question': 'Who developed the World Wide Web (WWW)?',
      'answers': ['Tim Berners-Lee', 'Steve Jobs', 'Bill Gates'],
      'correctAnswer': 'Tim Berners-Lee',
    },
    {
      'question': 'What is the name of Google\'s mobile operating system?',
      'answers': ['iOS', 'Android', 'Windows Mobile'],
      'correctAnswer': 'Android',
    },
    {
      'question':
          'Which programming language is known for its use in artificial intelligence and machine learning?',
      'answers': ['Python', 'Java', 'C++'],
      'correctAnswer': 'Python',
    },
    {
      'question': 'In computer graphics, what does GPU stand for?',
      'answers': [
        'General Processing Unit',
        'Graphical Performance Unit',
        'Graphics Processing Unit'
      ],
      'correctAnswer': 'Graphics Processing Unit',
    },
    {
      'question': 'Who is known as the "Father of the Computer"?',
      'answers': ['Charles Babbage', 'Alan Turing', 'Ada Lovelace'],
      'correctAnswer': 'Charles Babbage',
    },
    {
      'question':
          'Which company is famous for its gaming consoles like PlayStation?',
      'answers': ['Microsoft', 'Nintendo', 'Sony'],
      'correctAnswer': 'Sony',
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
                    'Technology Quiz',
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
