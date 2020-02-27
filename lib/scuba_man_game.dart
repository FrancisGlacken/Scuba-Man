import 'dart:ui';
import 'package:flame/game.dart';
import 'package:flame/gestures.dart';
import 'package:flutter/widgets.dart';
import 'package:scuba_man/components/background-ocean.dart';
import 'package:scuba_man/components/player/player_scuba.dart';
import 'package:scuba_man/scuba_man_ui.dart';
import 'package:scuba_man/components/enemies/jellyfish.dart';
import 'package:flutter/gestures.dart';
import 'package:scuba_man/ui_screens.dart';


class ScubaManGame extends BaseGame with TapDetector {
  PlayerScuba scubaMan; 
  Ocean ocean;
  final ScubaManUIState uiState; 
  ScubaManGame game; 
  List<JellyFish> jellies; 

  ScubaManGame(Size size, this.uiState) {
    this.size = size; 
    add(ocean = Ocean());
  }

  void onTapDown(TapDownDetails tapDetails) {
    bool isHandled = false; 

    if (uiState.currentScreen == UIScreen.title) {
      isHandled = true; 
    }

    if (uiState.currentScreen == UIScreen.game && !isHandled) {
      scubaMan.swimTowardsTapDownPoint(tapDetails); 
      isHandled = true; 
    }
  }
}
