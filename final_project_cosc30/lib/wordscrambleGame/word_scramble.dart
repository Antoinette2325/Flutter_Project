import 'dart:math';
import 'package:flutter/material.dart';
import 'package:finalproject/GamesScreen/games.dart';
import 'package:audioplayers/audioplayers.dart';

void main() {
  runApp(WordScrambleApp());
}

class WordScrambleApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: WordScrambleGame(),
      debugShowCheckedModeBanner: false, // Remove debug banner
    );
  }
}

class WordScrambleGame extends StatefulWidget {
  @override
  _WordScrambleGameState createState() => _WordScrambleGameState();
}

class _WordScrambleGameState extends State<WordScrambleGame> {
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
    _nextWord();
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

  List<String> words = [
    'KNOWLEDGE',
    'TRIVIA',
    'LEARNING',
    'CONSERVATION',
    'APPLE',
    'BANANA',
    'CARROT',
    'DOG',
    'ELEPHANT',
    'FLOWER',
    'GUITAR',
    'HAPPY',
    'ISLAND',
    'JUMP',
    'KANGAROO',
    'LAMP',
    'MOUNTAIN',
    'NOTEBOOK',
    'OCEAN',
    'PENCIL',
    'QUIET',
    'RAINBOW',
    'SUNSHINE',
    'TIGER',
    'UMBRELLA',
    'VIOLET',
    'WATERFALL',
    'XYLOPHONE',
    'YELLOW',
    'ZEBRA',
    'AIRPLANE',
    'BOOK',
    'CLOCK',
    'DANCE',
    'ECHO',
    'FIREWORKS',
    'GLOBE',
    'HARMONY',
    'IGLOO',
    'JAZZ',
    'KITE',
    'LION',
    'MAGIC',
    'NATURE',
    'OBSERVE',
    'PEACE',
    'QUARTER',
    'RIVER',
    'SILVER',
    'TREASURE',
    'UNIVERSE',
    'VACATION',
    'WONDER',
    'GRAMMAR',
    'VOCABULARY',
    'READING',
    'WRITING',
    'SPEAKING',
    'LISTENING',
    'LANGUAGE',
    'COMMUNICATION',
    'SYNTAX',
    'PRONUNCIATION',
    'LITERATURE',
    'DICTIONARY',
    'SENTENCE',
    'PARAGRAPH',
    'ESSAY',
    'GRAMMATICAL',
    'DIAGRAM',
    'NOUN',
    'VERB',
    'ADJECTIVE',
    'ADVERB',
    'PREPOSITION',
    'CONJUNCTION',
    'INTERJECTION',
    'PARTICIPLE',
    'INFINITIVE',
    'GERUND',
    'SIMILE',
    'METAPHOR',
    'IDIOM',
    'PROVERB',
    'SYNONYM',
    'ANTONYM',
    'HOMOPHONE',
    'PRONOUN',
    'ARTICLE',
    'PREFIX',
    'SUFFIX',
    'CONTRACTION',
    'PUNCTUATION',
    'RHETORIC',
    'STYLE',
    'RHIME',
    'ALLITERATION',
    'HYPERBOLE',
    'IRONIC',
    'LITERAL',
    'FIGURATIVE',
  ];

  String scrambledWord = '';
  String currentWord = '';
  int score = 0;
  int lives = 5;
  TextEditingController answerController = TextEditingController();
  String feedbackMessage = '';

  void _nextWord() {
    setState(() {
      currentWord = words[Random().nextInt(words.length)];
      scrambledWord = _scrambleWord(currentWord);
      answerController.clear();
      feedbackMessage = '';
    });
  }

  String _scrambleWord(String word) {
    List<String> characters = word.split('');
    characters.shuffle();
    return characters.join();
  }

  void _checkAnswer(String answer) {
    if (answer.toUpperCase() == currentWord) {
      setState(() {
        score++;
        _showCorrectDialog();
      });
    } else {
      setState(() {
        lives--;
        if (lives == 0) {
          _showGameOverDialog();
        } else {
          _showIncorrectDialog();
        }
      });
    }
  }

  void _showCorrectDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.transparent,
          content: Container(
            height: 50, // Adjust the height as needed
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                    'images/pop.png'), // Replace with your background image path
                fit: BoxFit.cover,
              ),
              border: Border.all(
                  color: Color(0xffff8ffa), width: 2.0), // Border settings
              borderRadius: BorderRadius.circular(10.0), // Border radius
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Correct!', style: TextStyle(color: Colors.white)),
                SizedBox(height: 10),
                Text('Congratulations! You got it right.',
                    style: TextStyle(color: Colors.white)),
                SizedBox(height: 10),
                Text('Current Score: $score',
                    style: TextStyle(color: Colors.white)),
              ],
            ),
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
                _nextWord();
                answerController.clear(); // Clear the answer input
              },
              style: ElevatedButton.styleFrom(
                primary:
                    Color(0xffe215b9), // Set the background color of the button
              ),
              child: Text('Next'),
            ),
          ],
        );
      },
    );
  }

  void _showIncorrectDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.transparent,
          content: Container(
            height: 100, // Adjust the height as needed
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                    'images/pop.png'), // Replace with your background image path
                fit: BoxFit.cover,
              ),
              border: Border.all(
                  color: Color(0xffff8ffa), width: 2.0), // Border settings
              borderRadius: BorderRadius.circular(10.0), // Border radius
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Incorrect', style: TextStyle(color: Colors.white)),
                SizedBox(height: 10),
                Text("Oops! That's not the correct answer.",
                    style: TextStyle(color: Colors.white)),
                SizedBox(height: 10),
                Text('Lives remaining: $lives',
                    style: TextStyle(color: Colors.white)),
              ],
            ),
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
                _nextWord();
                answerController.clear(); // Clear the answer input
              },
              style: ElevatedButton.styleFrom(
                primary:
                    Color(0xffe215b9), // Set the background color of the button
              ),
              child: Text('ok'),
            ),
          ],
        );
      },
    );
  }

  void _showGameOverDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.transparent,
          content: Container(
            height: 100, // Adjust the height as needed
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                    'images/pop.png'), // Replace with your background image path
                fit: BoxFit.cover,
              ),
              border: Border.all(
                  color: Color.fromARGB(255, 169, 96, 165),
                  width: 2.0), // Border settings
              borderRadius: BorderRadius.circular(10.0), // Border radius
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Game Over', style: TextStyle(color: Colors.white)),
                SizedBox(height: 10),
                Text('You ran out of lives. Your final score: $score',
                    style: TextStyle(color: Colors.white)),
              ],
            ),
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
                _nextWord();
                answerController.clear(); // Clear the answer input
              },
              style: ElevatedButton.styleFrom(
                primary:
                    Color(0xffe215b9), // Set the background color of the button
              ),
              child: Text('Play again'),
            ),
          ],
        );
      },
    );
  }

  void _resetGame() {
    setState(() {
      score = 0;
      lives = 5;
      _nextWord();
    });
  }

  void _revealOneLetter() {
    setState(() {
      int index = Random().nextInt(currentWord.length);
      List<String> revealedCharacters = scrambledWord.split('');
      revealedCharacters[index] = currentWord[index];
      scrambledWord = revealedCharacters.join();
    });
  }

  void _gameOver() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Game Over'),
          content: Column(
            children: [
              Text('You ran out of lives. Your final score: $score'),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  _resetGame();
                },
                child: Text('Try Again'),
              ),
            ],
          ),
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
                    'Welcome to Word Scramble!',
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
                    'How to Play',
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
                    '1. Guess the correct word by rearranging the scrambled letters.',
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
                    '2. Use the "Hint" button to reveal one letter of the correct word.',
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
                    '3. Submit your answer by typing it in the text field and clicking "Submit".',
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
                    '4. You lose a life for each incorrect answer. Game ends when lives run out.',
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: null,
      extendBody: true,
      body: Stack(
        children: [
          Image.asset(
            'images/backgroundimage/Sramblr.gif', // Replace with your image path
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(height: 26),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Color(0xffe895e8),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        'Score: $score',
                        style:
                            TextStyle(fontSize: 18, color: Color(0xffffffff)),
                      ),
                    ),
                    Row(
                      children: List.generate(
                        lives,
                        (index) => Icon(
                          Icons.favorite,
                          color: Color(0xffe795fb),
                          size: 30,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 50),
                Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    scrambledWord,
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: _revealOneLetter,
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all(Color(0xff7f078b)),
                    // Set your desired background color
                    fixedSize: MaterialStateProperty.all(
                        Size(120, 50)), // Set your desired size
                  ),
                  child: Text('Hint'),
                ),
                SizedBox(height: 20),
                Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: TextField(
                    controller: answerController,
                    onChanged: (answer) {
                      setState(() {
                        feedbackMessage =
                            ''; // Clear feedback message on input change
                      });
                    },
                    decoration: InputDecoration(
                      hintText: 'Your Answer',
                      border: InputBorder.none,
                    ),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 18,
                      fontFamily: 'BlackHanSans',
                    ),
                  ),
                ),
                SizedBox(height: 26),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        _checkAnswer(answerController.text);
                      },
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(Color(
                            0xff9a0d7d)), // Set your desired background color
                        fixedSize: MaterialStateProperty.all(Size(120, 50)),
                        // Set your desired size
                      ),
                      child: Text('Submit'),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: _resetGame,
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(Color(
                            0xff6d0270)), // Set your desired background color
                        fixedSize: MaterialStateProperty.all(
                            Size(120, 50)), // Set your desired size
                      ),
                      child: Text('Reset'),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                Container(
                  child: Text(
                    feedbackMessage,
                    style: TextStyle(
                      fontSize: 18,
                      color: feedbackMessage.contains('Correct')
                          ? Colors.green
                          : Colors.red,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: buildBottomBar(), // Include the bottom bar here
    );
  }

  Widget buildBottomBar() {
    return Container(
        child: Container(
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
      ), // Add a background color if needed
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
    ));
  }
}
