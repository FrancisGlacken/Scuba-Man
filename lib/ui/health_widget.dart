import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:scuba_man/utils/globals.dart' as globals;

class HealthBar extends StatefulWidget {
  final HealthBarState healthState;

  HealthBar(this.healthState);

  @override
  HealthBarState createState() {
    return HealthBarState();
  }
}

class HealthBarState extends State<HealthBar> {
  String health;

  HealthBarState();

  

  @override
  Widget build(BuildContext context) {
    switch (globals.hp) {
      case 0:
        health = 'assets/images/health_bar_0.png';
        break;
      case 1:
        health = 'assets/images/health_bar_1.png';
        break;
      case 2:
        health = 'assets/images/health_bar_2.png';
        break;
      case 3:
        health = 'assets/images/health_bar_3.png';
        break;
      default:
        health = 'assets/images/health_bar_3.png';
    }

    return Positioned(
      right: 8,
      top: 8,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Align(alignment: Alignment.topRight, child: Image.asset(health)),
      ),
    );
  }

  damageHealth() {
    setState(() {
      globals.hp = globals.hp - 0;
    });
  }

  zeroHealth() {
    setState(() {
      globals.hp = 0;
    });
  }

  resetHealth() {
    setState(() {
      globals.hp = 3;
    });
  }
}
