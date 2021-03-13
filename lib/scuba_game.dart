import 'package:flame/components.dart';
import 'package:flame/joystick.dart';
import 'package:flame/gestures.dart';
import 'package:flame/game.dart';
import 'package:scuba_man/components/enemies/bullet_fish_spawner.dart';
import 'package:scuba_man/components/enemies/jellyfish_spawner.dart';
import 'package:scuba_man/components/interactables/bubble_spawner.dart';
import 'package:scuba_man/components/interactables/fishy_spawner.dart';
import 'package:scuba_man/components/player/scuba.dart';
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
  int playerHealth, score; 
  JoystickComponent joystick;
  SpriteAnimation scubaAnim, jellyAnim;
  bool scubaIsInvincible = false;
  ParallaxComponent parallax;
  Timer invincibilityTimer;
  TimerComponent invincibilityTimerComponent;
  final VoidCallback myCallback; 

  ScubaGame(this.myCallback);

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

    joystick = JoystickComponent(
      directional: JoystickDirectional(
          margin: EdgeInsets.only(left: size.x * .8, bottom: size.y * .1)),
    );

    parallax = await ParallaxComponent.load(
      bgImages,
      baseVelocity: Vector2(20, 0),
      velocityMultiplierDelta: Vector2(1.8, 1.0),
      images: images,
    );

    scubaGuy = Scuba.fromSpriteAnimation(Vector2(70, 35), scubaAnim);
    scubaGuy.x = size.x / 2;
    scubaGuy.y = size.y / 2;
    joystick.addObserver(scubaGuy);
    add(bubbleSpawner = BubbleSpawner());
    add(parallax);
    overlays.add('title_screen'); 
    playerHealth = 3; 
  }

  @override
  void onReceiveDrag(DragEvent drag) {
    joystick.onReceiveDrag(drag);
    super.onReceiveDrag(drag);
  }

  void toGame() {
    overlays.remove('title_screen'); 
    overlays.add('game_screen'); 
    summonScuba();
    add(fishySpawner = FishySpawner());
    add(jellySpawner = JellyfishSpawner());
    add(bulletFishSpawner = BulletFishSpawner());
    resetScore(); 
  }

  void toRecords() {
    overlays.remove('title_screen'); 
    overlays.add('records_screen'); 
  }

  void toTitle() {
    overlays.remove('game_screen'); 
    overlays.remove('records_screen');
    if (overlays.isActive('record_entry_screen')) {
      overlays.remove('record_entry_screen'); 
    }
    overlays.add('title_screen'); 
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
    globals.score = globals.score + points; 
    myCallback(); 
  }

  resetScore() {
    globals.score = 0; 
    //scoreState.resetScore();
  }

  damageHealth(int damage) {
    if (scubaIsInvincible) {
      print("Scubaguy is invincible to this blow!");
    } else {
      scubaIsInvincible = true;
      add((invincibilityTimerComponent = TimerComponent(invincibilityTimer..start()))); 
      playerHealth += damage;
      //healthBarState.updateHealth(playerHealth);
      if (playerHealth < 3) {
        remove(invincibilityTimerComponent); 
        _gameOver();
      }
    }
  }

  _gameOver() {
    components.remove(scubaGuy); 
    components.remove(joystick); 
    overlays.add('record_entry_screen');
    //saveScoreAndGiveSplashScreen();
  }
}
