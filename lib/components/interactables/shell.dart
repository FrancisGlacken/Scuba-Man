import 'dart:math';
import 'package:flame/components/mixins/has_game_ref.dart';
import 'package:flame/components/sprite_animation_component.dart';
import 'package:flame/sprite_animation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:scuba_man/utils/utils.dart';
import 'package:vector_math/vector_math_64.dart';

class Shell extends SpriteAnimationComponent {
  static const num BALL_RADIUS = 4.0;
  Random rng = new Random();
  Random rngCharge = new Random();
  double posX, posY, acceleration;
  bool isDestroyed = false;

  ImagesLoader images = new ImagesLoader();

  Shell(Vector2 size, SpriteAnimation animation) : super(size, animation);

  void _loadImages() {
    images.load("shell", "sprite_sheet_shell.png");
  }

  void collisionCollect() {
    // gameRef.uiState.updateScoreForShell();
    //destroyOnFinish = true;
  }

  void onTapDown(TapDownDetails d) {
    print("shell tapped");
  }

  @override
  bool destroy() {
    return isDestroyed;
  }

  void destroyed() {
    isDestroyed = true; 
  }
}
