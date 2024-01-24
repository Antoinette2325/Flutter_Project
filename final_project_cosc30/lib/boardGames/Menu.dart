import 'package:flutter/material.dart';
import 'Time.dart';
import 'ResetButton.dart';
import 'Move.dart';

//Menu.dart
class Menu extends StatelessWidget {
  final VoidCallback reset;
  final int move;
  final int secondsPassed;
  final Size size;

  Menu(this.reset, this.move, this.secondsPassed, this.size);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: size.height * 0.15,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          ResetButton(reset, "Reset"),
          Move(move),
          Time(secondsPassed),
        ],
      ),
    );
  }
}
