import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:scuba_man/utils/globals.dart' as globals;

class HighScore extends StatefulWidget {
  final HighScoreState state; 
  HighScore(this.state);
  

  @override
  HighScoreState createState() {
    return state;
  }
}

class HighScoreState extends State<HighScore> {
  int _score = globals.score; 

  HighScoreState();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Align(
          alignment: Alignment.topCenter,
          child: Text(
            _score.toString(),
            style: TextStyle(fontSize: 24, color: Colors.green[300]),
          ),
        ),
      ),
    );
  }
}
