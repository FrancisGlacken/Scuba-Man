import 'dart:math';
import 'package:flame/components.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:scuba_man/scuba_game.dart';

class BulletFish extends SpriteAnimationComponent with HasGameRef<ScubaGame> {
  static const num BALL_RADIUS = 32.0;
  Random rng = new Random();
  Random rngCharge = new Random();
  double speedModifier;
  bool isDestroyed = false;

  BulletFish(bulletAnim) {
    animation = bulletAnim; 
    size = Vector2.all(32); 
    x = gameRef.size.x;
    y = gameRef.size.y * rng.nextDouble();
  }

  
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
      gameRef.damageHealth();
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
