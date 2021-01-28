import 'package:flutter/material.dart';

import 'start_image.dart';

class StartButton extends StatelessWidget {
  final VoidCallback startGame;
  StartButton(this.startGame);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: 150,
      top: 380,
      child: GestureDetector(
        onTapUp: (TapUpDetails details) {
          startGame();
        },
        child: StartImage(),
      ),
    );
  }
}
