import 'package:flutter/material.dart';
import 'package:scuba_man/scuba_game.dart';

class StartButton extends StatelessWidget {
  final ScubaGame game;
  StartButton(this.game);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: 150,
      top: 380,
      child: GestureDetector(
        onTapUp: (TapUpDetails details) {
          game.toGame();
        },
        child: Image.asset('assets/images/start_game.png'),
      ),
    );
  }
}
