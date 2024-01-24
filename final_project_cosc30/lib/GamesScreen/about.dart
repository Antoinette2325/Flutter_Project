import 'package:flutter/material.dart';

class AboutPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff4e208b),
        title: Text('About '),
      ),
      body: SingleChildScrollView(
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color(0xff9b3dba),
                Color(0xff3f095e),
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Astromind Explorer',
                style: TextStyle(
                  fontSize: 30,
                  fontFamily: 'Press',
                  fontWeight: FontWeight.bold,
                  color: Colors.white, // Set font color to white
                ),
              ),
              SizedBox(height: 16),
              Text(
                'Game Duration:',
                style: TextStyle(
                  fontFamily: 'Salsa',
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              Text(
                'December 25, 2023 - January 1, 2024',
                style: TextStyle(
                  fontFamily: 'Genos',
                  fontSize: 18,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 16),
              Text(
                'Developers:',
                style: TextStyle(
                  fontFamily: 'Salsa',
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              Text(
                'Astromind Explorer Team ',
                style: TextStyle(
                  fontFamily: 'Genos',
                  fontSize: 18,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10),
              Text(
                'Antoinnete Nadala',
                style: TextStyle(
                  fontFamily: 'Genos',
                  fontSize: 18,
                  color: Colors.white,
                ),
              ),
              Text(
                'Cris John Angcaya',
                style: TextStyle(
                  fontFamily: 'Genos',
                  fontSize: 18,
                  color: Colors.white,
                ),
              ),
              Text(
                'Jenny Lyn Vallador',
                style: TextStyle(
                  fontFamily: 'Genos',
                  fontSize: 18,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 16),
              Text(
                'Purpose:',
                style: TextStyle(
                  fontFamily: 'Salsa',
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              Text(
                'Final Project for Development Course',
                style: TextStyle(
                  fontFamily: 'Genos',
                  fontSize: 18,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 16),
              Text(
                'About the Game:',
                style: TextStyle(
                  fontFamily: 'Salsa',
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              Text(
                'Astromind Explorer is not just a single game; it is a collection of multiple challenging games within the vast universe. Each game presents a unique set of puzzles, missions, and adventures, offering a diverse and thrilling gaming experience.',
                style: TextStyle(
                  fontFamily: 'Genos',
                  fontSize: 18,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 16),
              Text(
                'Embark on a journey through different galaxies, where you will encounter various game environments, from treacherous asteroid fields to alien civilizations. Solve mind-bending puzzles, engage in epic space battles, and unlock the mysteries of the cosmos in each distinct game within Astromind Explorer.',
                style: TextStyle(
                  fontFamily: 'Genos',
                  fontSize: 18,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 16),
              Text(
                'We invite you to immerse yourself in the dynamic world of Astromind Explorer, where every game is a new adventure waiting to be explored!',
                style: TextStyle(
                  fontFamily: 'Genos',
                  fontSize: 18,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
