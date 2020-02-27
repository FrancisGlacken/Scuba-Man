import 'package:scuba_man/scuba_man_game.dart';
import 'package:flame/components/mixins/has_game_ref.dart';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:scuba_man/scuba_man_ui.dart';


class SwimUp extends StatelessWidget with HasGameRef<ScubaManGame> {
  final ScubaManUIState state;
  SwimUp(this.state); 

  @override
  Widget build(BuildContext context) {
    return Positioned(
          top: 8,
          right: 8,
          child: FlatButton(
        onPressed: () {
          state.swimUpOnClick();
        },
      child: Image.asset('assets/images/swim_up.png')),
    );
  }
}