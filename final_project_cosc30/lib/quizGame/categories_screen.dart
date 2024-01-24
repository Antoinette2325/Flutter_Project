import 'package:finalproject/GamesScreen/games.dart';
import 'package:flutter/material.dart';
import 'general_knowledge_screen.dart';
import 'science_screen.dart';
import 'math_screen.dart';
import 'history_screen.dart';
import 'technology_screen.dart';

class CategoriesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(),
        child: Stack(
          children: [
            Positioned.fill(
              child: Image.asset(
                'images/3.jpg', // Replace with the actual path to your image
                fit: BoxFit.cover,
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                buildCategoryButton(
                    context, 'General Knowledge', GeneralKnowledgeScreen()),
                buildCategoryButton(context, 'Science', ScienceScreen()),
                buildCategoryButton(context, 'Math', MathScreen()),
                buildCategoryButton(context, 'History', HistoryScreen()),
                buildCategoryButton(context, 'Technology', TechnologyScreen()),
              ],
            ),
            buildBottomBar(context),
          ],
        ),
      ),
    );
  }

  Widget buildCategoryButton(
      BuildContext context, String title, Widget screen) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      child: ElevatedButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => screen),
          );
        },
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.zero,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
        ),
        child: Ink(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xffc461c8), Color(0xff961f9a)],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            ),
            borderRadius: BorderRadius.circular(15.0),
          ),
          child: Container(
            padding: EdgeInsets.all(15),
            child: Center(
              child: Text(
                title,
                style: TextStyle(fontSize: 18, color: Color(0xffffffff)),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildBottomBar(BuildContext context) {
    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
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
                color: Color(0xffff8ffa), // Choose the border color
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
                    'Welcome to the Quiz App Tutorial!',
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
                    '1. Choose a category from the main screen.',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white, // Set text color to white
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    '2. Answer the questions to test your knowledge.',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white, // Set text color to white
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    '3. Use the bottom bar to navigate home, get help, or control volume.',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white, // Set text color to white
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    '4. Have fun and learn something new!',
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
                primary:
                    Color(0xffe215b9), // Set the background color of the button
              ),
              child: Text('Close'),
            ),
          ],
        );
      },
    );
  }
}
