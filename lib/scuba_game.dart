import 'package:flame/components.dart';
import 'package:flame/joystick.dart';
import 'package:flame/gestures.dart';
import 'package:flame/game.dart';
import 'package:scuba_man/components/enemies/bullet_fish_spawner.dart';
import 'package:scuba_man/components/enemies/jellyfish_spawner.dart';
import 'package:scuba_man/components/interactables/bubble_spawner.dart';
import 'package:scuba_man/components/interactables/fishy_spawner.dart';
import 'package:scuba_man/components/player/scuba.dart';
import 'package:scuba_man/ui/game_ui.dart';
import 'package:scuba_man/ui/record.dart';
import 'package:flutter/material.dart' hide Image;
import 'package:scuba_man/utils/globals.dart' as globals;


class ScubaGame extends BaseGame with MultiTouchDragDetector {
  Scuba scubaGuy;
  List<Record> records = [];
  List<String> bgImages = ['bg_ocean.png'];
  FishySpawner fishySpawner;
  JellyfishSpawner jellySpawner;
  BubbleSpawner bubbleSpawner;
  BulletFishSpawner bulletFishSpawner;
  JoystickComponent joystick;
  SpriteAnimation scubaAnim, jellyAnim;
  bool scubaIsInvincible = false;
  ParallaxComponent parallax;
  Timer invincibilityTimer;
  TimerComponent invincibilityTimerComponent;
  final GameUIState uiState; 


  ScubaGame(this.uiState);

  @override
  Future<void> onLoad() async {
    final scubaImage = await images.load('sprite_scuba_man.png');

    scubaAnim = SpriteAnimation.fromFrameData(
      scubaImage,
      SpriteAnimationData.sequenced(
        amount: 11,
        textureSize: Vector2(128, 64),
        stepTime: 0.1,
        loop: true,
      ),
    );

    invincibilityTimer = new Timer(3, repeat: true, callback: () {
      scubaIsInvincible = false;
    });

    joystick = JoystickComponent(gameRef: this,
      directional: JoystickDirectional(
          margin: EdgeInsets.only(left: size.x * .8, bottom: size.y * .1)),
    );

    parallax = await ParallaxComponent.load(
      bgImages,
      baseVelocity: Vector2(20, 0),
      velocityMultiplierDelta: Vector2(1.8, 1.0),
      images: images,
    );

    scubaGuy = Scuba(scubaAnim);
    joystick.addObserver(scubaGuy);
    add(bubbleSpawner = BubbleSpawner());
    add(parallax);
    overlays.add('title_screen'); 
  }

  void toGame() {
    uiState.toGameScreen(); 
    summonScuba();
    add(fishySpawner = FishySpawner());
    add(jellySpawner = JellyfishSpawner());
    add(bulletFishSpawner = BulletFishSpawner());
    add(bubbleSpawner = BubbleSpawner()); 
    resetScore(); 
  }

  void toRecords() {
    uiState.toRecordsScreen(); 
  }

  void toTitle() {
    uiState.toTitleScreen(); 
    removeAll(components);
    add(parallax);
  }

  void addHighScore() {
    //records.add(Record(score, "NEW"));
    records.removeLast();
  }

  summonScuba() {
    add(scubaGuy);
    add(joystick);
  }

  updateScore(int points) {
    uiState.updateScore(points); 
  }

  resetScore() {
    uiState.resetScore();
  }

  damageHealth() {
    if (scubaIsInvincible) {
      print("Scubaguy is invincible to this blow!");
    } else {
      scubaIsInvincible = true;
      add((invincibilityTimerComponent = TimerComponent(invincibilityTimer..start()))); 
      uiState.damageHealth();
      if (globals.hp < 1) {
        remove(invincibilityTimerComponent); 
        _gameOver();
      }
    }
  }

  resetHealth() {
    uiState.resetHealth(); 
  }

  

  _gameOver() {
    components.remove(scubaGuy); 
    components.remove(joystick); 
    overlays.add('record_entry_screen');
    //saveScoreAndGiveSplashScreen();
  }
}
