import 'package:flutter/material.dart';
import 'package:scuba_man/scuba_man_ui.dart';
import 'start_image.dart';

class StartButton extends StatelessWidget {
  final ScubaManUIState state; 
  StartButton(this.state);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: FlatButton(
        onPressed: () {
          state.toGameScreen();
        },
        child: StartImage(),
      ),
    );
  }
}