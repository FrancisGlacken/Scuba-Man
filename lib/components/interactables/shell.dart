import 'package:flame/components/animation_component.dart';
import 'package:flame/components/mixins/has_game_ref.dart';
import 'package:flame/animation.dart';
import 'package:flutter/gestures.dart';
import 'package:scuba_man/scuba_man_game.dart';

class Shell extends AnimationComponent with HasGameRef<ScubaManGame> {
  Shell(double x, doubly ) : super(16, 16, 
      Animation.sequenced("sprite_sheet_shell.png", 1, textureWidth: 16, textureHeight: 16)){
        
      this.x = x;
      this.y = y;
  }
  
  @override
  void update(double t) {
    super.update(t); 

    y += 15 * t; 

    if (gameRef.scubaMan != null && gameRef.scubaMan.toRect().overlaps(toRect())) {
      collisionCollect(); 
    }
  }

  void collisionCollect() {
    gameRef.uiState.updateScoreForShell();
    destroyOnFinish = true;
  }


  void onTapDown(TapDownDetails d) {
    print("jelly tapped");
  }
}