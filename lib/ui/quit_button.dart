import 'package:flutter/material.dart';
import 'package:scuba_man/scuba_man_ui.dart';

class QuitButton extends StatelessWidget {
  final ScubaManUIState state; 
  QuitButton(this.state);

  @override
  Widget build(BuildContext context) {
    return Positioned(
        right: 0,
        bottom: 0,
        child: FlatButton(
          onPressed: () {
            state.toTitleScreen();
          },
          child: Image.asset(
            'assets/images/quit-game.png'
          ),
        ));
  }
}