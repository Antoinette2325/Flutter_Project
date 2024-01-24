// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

void main() {
  runApp(const dev2());
}

class dev2 extends StatelessWidget {
  const dev2({Key? key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Stack(
          children: [
            // Background Image
            Positioned.fill(
              child: Image.asset(
                'images/cardBg.jpg', // Replace with your actual image path
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: IconButton(
                icon: Icon(
                  Icons.arrow_back,
                  color: Colors.white,
                  size: 40,
                ),
                onPressed: () {
                  Navigator.of(context)
                      .pop(); // Pop the current screen when back button is pressed
                },
              ),
            ),
            Container(
              child: SafeArea(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        width: 140.0,
                        height: 140.0,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: const Color.fromARGB(255, 15, 13, 13)
                                  .withOpacity(0.3),
                              spreadRadius: 2,
                              blurRadius: 5,
                              offset: Offset(0, 3),
                            ),
                          ],
                        ),
                        child: CircleAvatar(
                          radius: 100.0,
                          backgroundImage:
                              AssetImage('images/Cardimage/cris.jpg'),
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        'Cris John Angcaya',
                        style: TextStyle(
                          fontFamily: 'Montez',
                          fontSize: 40.0,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        'BSCS STUDENT 3-1',
                        style: TextStyle(
                          fontFamily: 'SourceCodePro',
                          fontSize: 17,
                          color: Colors.white54,
                          letterSpacing: 1.5,
                          fontWeight: FontWeight.normal,
                          height: 1,
                        ),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      SizedBox(
                        width: 150,
                        child: Divider(
                          thickness: 2,
                          color: Color.fromARGB(158, 255, 255, 255),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          FaIcon(
                            FontAwesomeIcons.facebook,
                            color: Colors.white,
                            size: 30,
                          ),
                          SizedBox(width: 10),
                          FaIcon(
                            FontAwesomeIcons.twitter,
                            color: Colors.white,
                            size: 30,
                          ),
                          SizedBox(width: 10),
                          FaIcon(
                            FontAwesomeIcons.instagram,
                            color: Colors.white,
                            size: 30,
                          ),
                        ],
                      ),
                      Card(
                        color: Color.fromARGB(227, 255, 255, 255),
                        margin: EdgeInsets.symmetric(
                            vertical: 20.0, horizontal: 30.0),
                        child: Padding(
                          padding: EdgeInsets.all(10.0),
                          child: Row(
                            children: [
                              Icon(
                                Icons.email_sharp,
                                color: Color.fromARGB(255, 108, 7, 136),
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              Expanded(
                                child: Text(
                                  'cjangcaya@gmail.com',
                                  style: TextStyle(
                                    fontFamily: 'SourceCodePro',
                                    fontSize: 15.0,
                                    fontWeight: FontWeight.bold,
                                    color: Color.fromARGB(255, 40, 1, 48),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Card(
                        color: Color.fromARGB(227, 255, 255, 255),
                        margin: EdgeInsets.symmetric(
                            vertical: 1.0, horizontal: 30.0),
                        child: Padding(
                          padding: EdgeInsets.all(10.0),
                          child: Row(
                            children: [
                              Icon(
                                Icons.location_city,
                                color: Color.fromARGB(255, 108, 7, 136),
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              Expanded(
                                child: Text(
                                  'Kaybagal North Tagaytay City',
                                  style: TextStyle(
                                    fontFamily: 'SourceCodePro',
                                    fontSize: 15.0,
                                    fontWeight: FontWeight.bold,
                                    color: Color.fromARGB(255, 18, 1, 31),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Card(
                        color: Color.fromARGB(227, 255, 255, 255),
                        margin: EdgeInsets.symmetric(
                            vertical: 1.0, horizontal: 30.0),
                        child: Padding(
                          padding: EdgeInsets.all(10.0),
                          child: Row(
                            children: [
                              Icon(
                                Icons.telegram,
                                color: Color.fromARGB(255, 108, 7, 136),
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              Expanded(
                                child: Text(
                                  ' 0927-0384-723',
                                  style: TextStyle(
                                    fontFamily: 'SourceCodePro',
                                    fontSize: 15.0,
                                    fontWeight: FontWeight.bold,
                                    color: Color.fromARGB(255, 18, 1, 31),
                                  ),
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
            ),
          ],
        ),
      ),
    );
  }
}
