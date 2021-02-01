import 'dart:ui';
import 'package:flutter/material.dart';

class HealthBar extends StatefulWidget {
  final HealthBarState state; 

  HealthBar(this.state);

  @override
  HealthBarState createState() {
    return state;
  }

  
}

class HealthBarState extends State<HealthBar> {
  int hp = 3; 
  String health; 

  HealthBarState();

  updateHealth(health) {
    setState(() {
      hp = health; 
    });
  }

  resetHealth() {
    setState(() {
      hp = 3; 
    });
  }

  @override
  Widget build(BuildContext context) {
    
    switch(hp) {
      case 0: health = 'assets/images/health_bar_0.png';
      break;
      case 1: health = 'assets/images/health_bar_1.png';
      break;
      case 2: health = 'assets/images/health_bar_2.png';
      break;
      case 3: health = 'assets/images/health_bar_3.png';
      break; 
      default: health = 'assets/images/health_bar_3.png'; 
    }

    return Positioned(
      right: 8,
      top: 8, 
          child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Align(
            alignment: Alignment.topRight,
            child: Image.asset(health)), 
      ),
    );
  }
}
