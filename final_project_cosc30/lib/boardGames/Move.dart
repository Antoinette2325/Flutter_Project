import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

// ignore: must_be_immutable
class Move extends StatelessWidget {
  int move;

  Move(this.move);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 0), // Changed bottom to top
      child: Container(
        margin: EdgeInsets.only(top: 10), // Set the top margin
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.3),
              spreadRadius: 1,
              blurRadius: 5,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          decoration: BoxDecoration(
            border:
                Border.all(color: Colors.white, width: 5), // Add white border
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Color.fromARGB(255, 107, 4, 185),
                Color.fromARGB(255, 160, 10, 176),
              ],
            ),
            borderRadius: BorderRadius.circular(15),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                FontAwesomeIcons.puzzlePiece,
                color: Color.fromARGB(255, 231, 231, 231),
                size: 18,
              ),
              SizedBox(width: 20),
              Text(
                "Move: ${move}",
                style: TextStyle(
                  fontSize: 18,
                  decoration: TextDecoration.none,
                  color: Color.fromARGB(255, 231, 231, 231),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
