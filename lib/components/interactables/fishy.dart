import 'dart:math';

import 'package:flame/components.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:scuba_man/scuba_game.dart';
import 'package:scuba_man/utils/utils.dart';
import 'package:vector_math/vector_math_64.dart';

class Fishy extends SpriteAnimationComponent with HasGameRef<ScubaGame> {
  static const num BALL_RADIUS = 8.0;
  Random rng = new Random();
  Random rngCharge = new Random();
  double speedModifier = 80;

  ImagesLoader images = new ImagesLoader();

  Fishy.fromSpriteAnimation(Vector2 size, SpriteAnimation anim)
      : super.fromSpriteAnimation(size, anim);

  @override
  void update(double t) {
    x -= speedModifier * t;
    speedModifier -= .5;
    if (speedModifier <= 4) speedModifier = 80;
    if (x < -32) {
      gameRef.remove(this); 
    }

    if (x < -100 || x > gameRef.size.x+100 || y < -100 || y > gameRef.size.y+100) {
      this.remove(); 
    }

    if (this.toRect().overlaps(gameRef.scubaGuy.toRect())) {
      gameRef.scoreState.updateScore(1); 
      gameRef.remove(this); 
    }

    super.update(t);
  }

  void onTapDown(TapDownDetails d) {
    print("fishy tapped");
  }

  void impact() {
    //gameRef.updateScore(1);
    remove();
  }
}
