import 'dart:math';
import 'dart:ui';
import 'package:flame/components/mixins/has_game_ref.dart';
import 'package:flame/components/sprite_animation_component.dart';
import 'package:flame/sprite_animation.dart';
import 'package:flutter/gestures.dart';
import 'package:scuba_man/scuba_game.dart';
import 'package:vector_math/vector_math_64.dart';

class Bubble extends SpriteAnimationComponent with HasGameRef<ScubaGame> {
  static const num BALL_RADIUS = 8.0;
  Random rng = new Random();
  Random rngCharge = new Random();
  double posX, posY, acceleration;
  bool isDestroyed = false;
  
  Bubble(Vector2 size, SpriteAnimation animation) : super(size, animation);

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
