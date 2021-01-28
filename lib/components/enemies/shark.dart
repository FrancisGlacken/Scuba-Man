import 'dart:math';
import 'package:flame/components/sprite_animation_component.dart';
import 'package:flame/sprite_animation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:vector_math/vector_math_64.dart';

class Shark extends SpriteAnimationComponent {
  static const num BALL_RADIUS = 32.0; 
  Random rng = new Random(); 
  Random rngCharge = new Random(); 
  double speedModifier; 
  bool isDestroyed = false; 


  Shark(Vector2 size, SpriteAnimation animation) : super(size, animation);

  @override
    void update(double t) {
      // TODO: implement update
      x = x - 50 * t; 
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