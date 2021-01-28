import 'dart:ui';
import 'package:flutter/material.dart';

class LastScore extends StatefulWidget {
  final LastScoreState scoreState; 

  LastScore(this.scoreState); 

  @override
  LastScoreState createState() {
    return scoreState;
  } 
}

class LastScoreState extends State<LastScore> {
  int score = 0;  

  LastScoreState(); 

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
    return Positioned(
      top: 20,
      left: 20,
      child: Center(
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
      ),
    );
  }
}
