import 'package:flutter/material.dart';

class Game {
  final Color hiddenCard = Colors.red;
  List<Color>? gameColors;
  List<String>? gameImg;
  List<Color> cards = [
    Colors.green,
    Colors.yellow,
    Colors.yellow,
    Colors.green,
    Colors.blue,
    Colors.blue
  ];
  final String hiddenCardpath = "images/hidden.png";
  List<String> cards_list = [
    "images/circle.png",
    "images/triangle.png",
    "images/circle.png",
    "images/heart.png",
    "images/star.png",
    "images/triangle.png",
    "images/star.png",
    "images/circle.png",
    "images/heart.png",
    "images/triangle.png",
    "images/star.png",
    "images/heart.png",
    "images/triangle.png",
    "images/star.png",
    "images/circle.png",
    "images/heart.png",
  ];
  final int cardCount = 16;
  List<Map<int, String>> matchCheck = [];

  Object? get totalPossibleScore => null;

  //methods
  void initGame() {
    gameColors = List.generate(cardCount, (index) => hiddenCard);
    gameImg = List.generate(cardCount, (index) => hiddenCardpath);
  }
}
