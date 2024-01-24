import 'package:flutter/material.dart';
import 'package:finalproject/slotmachine.dart';

void main() {
  runApp(SlotMachine());
}

class SlotHome extends StatelessWidget {
  SlotHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
              'images/slot machine.png',
            ), // Replace with your image path
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 170.0),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 20.0),
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 81, 4, 100),
                  borderRadius: BorderRadiusDirectional.circular(25),
                  boxShadow: [
                    BoxShadow(
                      color: Color.fromARGB(255, 187, 5, 193),
                      spreadRadius: 1,
                      blurRadius: 8,
                      offset: Offset(4, 4),
                    ),
                    BoxShadow(
                      color: Color.fromARGB(255, 239, 224, 239),
                      spreadRadius: 2,
                      blurRadius: 8,
                      offset: Offset(-4, -4),
                    ),
                  ],
                ),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SlotMachine()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 10), // Adjust the padding here
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25.0),
                    ),
                    primary: Color.fromARGB(255, 42, 4, 109),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.play_arrow,
                        size: 40.0,
                        color: Color.fromARGB(255, 252, 247, 252),
                      ),
                      SizedBox(width: 7.0),
                      Text(
                        "PLAY", // Add your button label here
                        style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 255, 252, 244),
                          fontFamily: 'Press',
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
    );
  }
}
