import 'dart:math';

import 'package:flame/components.dart';
import 'package:scuba_man/scuba_game.dart';
import 'package:scuba_man/utils/utils.dart';
import 'package:vector_math/vector_math_64.dart';

class Fishy extends SpriteAnimationComponent with HasGameRef<ScubaGame> {
  static const num BALL_RADIUS = 8.0;
  Random rng = new Random();
  Random rngCharge = new Random();
  double speedModifier = 80;

  ImagesLoader images = new ImagesLoader();

  Fishy(fishAnim) {
    animation = fishAnim;
    size = Vector2.all(32); 
    x = gameRef.size.x + 32;
    y = rng.nextDouble() * gameRef.size.y;
  }

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
      gameRef.updateScore(1); 
      gameRef.remove(this); 
    }

    super.update(t);
  }
}
