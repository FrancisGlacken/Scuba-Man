import 'package:flame/components/animation_component.dart';
import 'package:flame/components/mixins/has_game_ref.dart';
import 'package:flame/animation.dart';
import 'package:flutter/gestures.dart';
import 'package:scuba_man/scuba_man_game.dart';

class JellyFish extends AnimationComponent with HasGameRef<ScubaManGame> {
  JellyFish(double x, double y) : super(24, 24, 
      Animation.sequenced("sprite_sheet_jellyfish.png", 10, textureWidth: 16, textureHeight: 16)){
        
      this.x = x;
      this.y = y;
  }

  @override
  void update(double t) {
    super.update(t); 

    y -= 15 * t; 

    // if (gameRef.world.scuba.toRect().overlaps(toRect())) {
    //   collisionAttack(); 
    // }
  }

  collisionAttack() {
    gameRef.uiState.updateHealthForDamage(); 
    if (gameRef.uiState.health == 0){
      gameRef.uiState.toTitleScreen();
    }
  }


  void onTapDown(TapDownDetails d) {
    print("jelly tapped");
  }
}