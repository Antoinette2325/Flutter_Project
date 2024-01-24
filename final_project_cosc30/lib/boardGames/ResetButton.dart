import 'package:flutter/material.dart';

class ResetButton extends StatelessWidget {
  final VoidCallback reset;
  final String text;

  ResetButton(this.reset, this.text);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.white, width: 5), // Add white border
        borderRadius: BorderRadius.circular(10),
      ),
      child: ElevatedButton(
        onPressed: reset,
        style: ElevatedButton.styleFrom(
          primary: Color.fromARGB(255, 236, 236, 236),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(3.0),
          ),
        ),
        child: Text(
          text,
          style: TextStyle(
              color: Color.fromARGB(255, 0, 0, 0),
              fontWeight: FontWeight.bold,
              fontSize: 15),
        ),
      ),
    );
  }
}
