import 'dart:ui';
import 'package:flutter/material.dart';

class HighScore extends StatelessWidget {
  final int score; 

  HighScore(this.score);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Align(
        alignment: Alignment.topCenter,
            child: Text(
          score.toString(),
          style: TextStyle(fontSize: 24, color: Colors.white),
        ),
      ),
    );
  }
}