import 'package:flutter/material.dart';
import 'package:scuba_man/ui/records_image.dart';

class RecordsButton extends StatelessWidget {
  final VoidCallback toScoreBoard;
  RecordsButton(this.toScoreBoard);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: 150,
      top: 480,
      child: GestureDetector(
        onTapUp: (TapUpDetails details) {
          toScoreBoard();
        },
        child: RecordsImage(),
      ),
    );
  }
}
