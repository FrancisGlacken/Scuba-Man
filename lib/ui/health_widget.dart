import 'dart:ui';
import 'package:flutter/material.dart';

class HealthBar extends StatelessWidget {
  final String health;

  HealthBar(this.health);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Align(
          alignment: Alignment.topLeft,
          child: Image.asset(health)),
    );
  }
}
