import 'dart:math';

import 'package:flame/components/mixins/has_game_ref.dart';
import 'package:flame/components/sprite_animation_component.dart';
import 'package:flame/sprite_animation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:scuba_man/utils/utils.dart';
import 'package:vector_math/vector_math_64.dart';

class Fishy extends SpriteAnimationComponent {
  static const num BALL_RADIUS = 8.0;
  Random rng = new Random();
  Random rngCharge = new Random();
  double speedModifier = 80; 
  bool isDestroyed = false;

  ImagesLoader images = new ImagesLoader();

  Fishy(Vector2 size, SpriteAnimation animation) : super(size, animation);

  @override
  void update(double t) {
    x -= speedModifier * t;
    speedModifier -= .5;
    if (speedModifier <= 4) speedModifier = 80; 
    if (x < 0) {
      destroy(); 
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
