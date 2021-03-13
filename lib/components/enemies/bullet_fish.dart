import 'dart:math';
import 'package:flame/components.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:scuba_man/scuba_game.dart';
import 'package:vector_math/vector_math_64.dart';

class BulletFish extends SpriteAnimationComponent with HasGameRef<ScubaGame> {
  static const num BALL_RADIUS = 32.0;
  Random rng = new Random();
  Random rngCharge = new Random();
  double speedModifier;
  bool isDestroyed = false;

  BulletFish.fromSpriteAnimation(Vector2 size, SpriteAnimation anim)
      : super.fromSpriteAnimation(size, anim);

  @override
  void update(double t) {
    x = x - 50 * t;

    if (x < -100 ||
        x > gameRef.size.x + 100 ||
        y < -100 ||
        y > gameRef.size.y + 100) {
      this.remove();
    }

    if (this.toRect().overlaps(gameRef.scubaGuy.toRect())) {
      gameRef.damageHealth(-1);
    }
    super.update(t);
  }

  void onTapDown(TapDownDetails d) {
    print("fishy tapped");
  }

  void destroy() {
    shouldRemove = true;
  }

  void impact() {
    //gameRef.updateScore(1);
    destroy();
  }
}
