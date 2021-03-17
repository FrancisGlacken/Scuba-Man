
import 'dart:math';
import 'package:flame/components.dart';
import 'package:scuba_man/scuba_game.dart';

class JellyFish extends SpriteAnimationComponent with HasGameRef<ScubaGame> {
  Random rng = new Random();
  double speedModifier = 80;

  JellyFish(jellyAnim) {
    animation = jellyAnim; 
    x = gameRef.size.x + 32;
    y = (gameRef.size.y * rng.nextDouble()) + 50;
  }
 
  @override
    void update(double t) {
      x -= speedModifier * t;
      speedModifier -= .5;
      if (speedModifier <= 4) speedModifier = 80; 
      y = y + speedModifier * t; 
      super.update(t);

      if (x < -100 || x > gameRef.size.x+100 || y < -100 || y > gameRef.size.y+100) {
      this.remove(); 
      }

      if (this.toRect().overlaps(gameRef.scubaGuy.toRect())) {
        gameRef.damageHealth(); 
      }

      super.update(t); 
    }

  void destroy() {
    shouldRemove = true; 
  }

  void impact() {
    //gameRef.updateScore(1);
    destroy(); 
  }
}
