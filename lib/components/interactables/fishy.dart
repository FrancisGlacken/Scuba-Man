import 'package:flame/components/animation_component.dart';
import 'package:flame/components/mixins/has_game_ref.dart';
import 'package:flame/animation.dart';
import 'package:flutter/gestures.dart';
import 'package:scuba_man/scuba_man_game.dart';

class Fishy extends AnimationComponent with HasGameRef<ScubaManGame> {

  Fishy(double x, double y) : super(16, 16, 
      Animation.sequenced("sprite_sheet_fishy.png", 1, textureWidth: 8, textureHeight: 8)){
        
      this.x = x;
      this.y = y;
  }

  @override
  void update(double t) {
    super.update(t);

    x -= 50 * t;

    if (gameRef.scubaMan != null && gameRef.scubaMan.toRect().overlaps(toRect())) {
      collisionCollect(); 
    }
  }

  void collisionCollect() {
    gameRef.uiState.updateScoreForFishy();
    destroyOnFinish = true; 
  }

  void onTapDown(TapDownDetails d) {
    print("jelly tapped");
  }
}