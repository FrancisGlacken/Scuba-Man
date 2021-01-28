import 'dart:ui';
import 'package:flutter/material.dart';

class HighScore extends StatefulWidget {
  final HighScoreState scoreState;

  HighScore(this.scoreState);

  @override
  HighScoreState createState() {
    return scoreState;
  }
}

class HighScoreState extends State<HighScore> {
  int score = 0;

  HighScoreState();

  updateScore(points) {
    setState(() {
      score += points;
    });
  }

  resetScore() {
    setState(() {
      score = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Align(
          alignment: Alignment.topCenter,
          child: Text(
            score.toString(),
            style: TextStyle(fontSize: 24, color: Colors.white),
          ),
        ),
      ),
    );
  }
}
