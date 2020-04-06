import 'package:flame/components/animation_component.dart';
import 'package:flame/components/mixins/has_game_ref.dart';
import 'package:flame/animation.dart';
import 'package:flutter/gestures.dart';
import 'package:scuba_man/scuba_man_game.dart';

class Shark extends AnimationComponent with HasGameRef<ScubaManGame> {
  bool goingLeft = false;

  Shark(double x, double y)
      : super(
            64,
            32,
            Animation.sequenced("sprite-shark.png", 1,
                textureWidth: 32, textureHeight: 16)) {
    this.x = x;
    this.y = y;
  }

  @override
  void update(double t) {
    super.update(t);

    x -= 100 * t;

    // if (gameRef.scubaMan != null &&
    //     gameRef.scubaMan.toRect().overlaps(toRect())) {
    //   collisionAttack();
    //   if (gameRef.uiState.health == 0) {
    //     gameRef.uiState.toTitleScreen();
    //   }
    // }
  }

  collisionAttack() {
    gameRef.uiState.updateHealthForDamage();
  }

  void onTapDown(TapDownDetails d) {
    print("shark tapped");
  }
}
