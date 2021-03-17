import 'package:flutter/material.dart';
import 'package:scuba_man/scuba_game.dart';

class QuitButton extends StatelessWidget {
  final ScubaGame game;
  const QuitButton(this.game);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: 20,
      top: 20,
      child: GestureDetector(
          onTapDown: (TapDownDetails details) {
            game.toTitle();
          },
          child: Image.asset('assets/images/green_frame.png')),
    );
  }
}
