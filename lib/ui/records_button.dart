import 'package:flutter/material.dart';
import 'package:scuba_man/scuba_game.dart';

class RecordsButton extends StatelessWidget {
  final ScubaGame game; 
  RecordsButton(this.game);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: 150,
      top: 480,
      child: GestureDetector(
        onTapUp: (TapUpDetails details) {
          game.toRecords();
        },
        child: Image.asset('assets/images/records.png'),
      ),
    );
  }
}
