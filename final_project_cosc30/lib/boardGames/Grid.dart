import 'package:flutter/material.dart';

class Grid extends StatelessWidget {
  final List<int> numbers;
  final Size size;
  final Function(int) clickGrid;

  Grid(this.numbers, this.size, this.clickGrid);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 4,
          crossAxisSpacing: 4.0,
          mainAxisSpacing: 4.0,
        ),
        itemCount: numbers.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () => clickGrid(index),
            child: Center(
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Color.fromARGB(255, 239, 239, 236),
                      Color.fromARGB(255, 115, 8, 214),
                    ],
                  ),
                ),
                child: Center(
                  child: Text(
                    numbers[index] == 0 ? '' : numbers[index].toString(),
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
