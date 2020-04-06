import 'package:flame/components/animation_component.dart';
import 'package:flame/components/mixins/has_game_ref.dart';
import 'package:flame/animation.dart';
import 'package:flutter/gestures.dart';
import 'package:scuba_man/scuba_man_game.dart';

class PlayerScuba extends AnimationComponent with HasGameRef<ScubaManGame> {
  bool fishfood = false;
  bool swimming = false;
  double gravity = 5;
  double swimForceUp = 0;
  double swimForceLeft = 0;
  double swimForceRight = 0;
  double swimForceDown = 0; 

  PlayerScuba()
      : super(
            16,
            24,
            Animation.sequenced("sprite_scuba_man.png", 1,
                textureWidth: 16, textureHeight: 24)) {
    x = 100;
    y = 100;
  }

  @override
  void update(double t) {
    super.update(t);
    y += gravity * t;

    y += swimForceUp * t;
    swimForceUp -= 10 * t;
    if (swimForceUp <= 0) swimForceUp = 0; 

    y -= swimForceDown * t;
    swimForceDown -= 10 * t; 
    if (swimForceDown <= 0) swimForceDown = 0; 

    x -= swimForceLeft * t; 
    swimForceLeft -= 10 * t; 
    if (swimForceLeft <= 0) swimForceLeft = 0; 

    x += swimForceRight * t;
    swimForceRight -= 10 * t; 
    if (swimForceRight <= 0) swimForceRight = 0; 

    

    handleCollisionDetection();
  }

  void swimTowardsTapDownPoint(TapDownDetails d) {
    if (d.globalPosition.dy > y) {
      swimForceUp += 10;
    } else if (d.globalPosition.dy < y) {
      swimForceDown += 10; 
    } 
    if (d.globalPosition.dx < x) {
      swimForceLeft += 10; 
    } else if (d.globalPosition.dx > x) {
      swimForceRight += 10; 
    }
  }

  void handleCollisionDetection() {
    // Handles CollisionDetection
    if (x <= 15) {
      x = 16;
      if (swimForceLeft > 0) { swimForceLeft = 0; }
    } else if (x >= gameRef.size.width - 15) {
      x = gameRef.size.width - 16;
      if (swimForceRight > 0) { swimForceRight = 0; }
    } else if (y <= 23) {
      y = 24;
      if (swimForceUp > 0) { swimForceUp = 0; }
    } else if (y >= gameRef.size.height - 23) {
      y = gameRef.size.height - 24;
      if (swimForceDown > 0) { swimForceDown = 0; }
    }
  }
}
