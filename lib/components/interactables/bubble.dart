import 'dart:math';
import 'package:flame/components.dart';

import 'package:flutter/gestures.dart';
import 'package:scuba_man/scuba_game.dart';
import 'package:vector_math/vector_math_64.dart';

class Bubble extends SpriteAnimationComponent with HasGameRef<ScubaGame> {
  static const num BALL_RADIUS = 8.0;
  Random rng = new Random();
  Random rngCharge = new Random();
  double posX, posY, acceleration;
  bool isDestroyed = false;

  Bubble.fromSpriteAnimation(Vector2 size, SpriteAnimation anim)
      : super.fromSpriteAnimation(size, anim);

  @override
  void update(double t) {
    y = y - 50 * t;

    if (y < gameRef.size.y) {
      destroy();
    }
    super.update(t);
  }

  void onTapDown(TapDownDetails d) {
    print("shell tapped");
  }

  void destroy() {
    shouldRemove = true;
  }

  void collisionCollect() {
    //,gameRef.uiState.updateScoreForShell();
    //destroyOnFinish = true;
  }
}
