import 'package:flame/components.dart';
import 'package:flame/flame.dart';
import 'package:flame/joystick.dart';
import 'package:flame/gestures.dart';
import 'package:flame/game.dart';
import 'package:scuba_man/components/enemies/jellyfish.dart';
import 'package:scuba_man/components/enemies/jellyfish_spawner.dart';
import 'package:scuba_man/components/enemies/shark.dart';
import 'package:scuba_man/components/enemies/shark_spawner.dart';
import 'package:scuba_man/components/interactables/bubble_spawner.dart';
import 'package:scuba_man/components/interactables/fishy_spawner.dart';
import 'package:scuba_man/components/interactables/shell.dart';
import 'package:scuba_man/components/player/scuba.dart';
import 'package:scuba_man/components/interactables/fishy.dart';
import 'package:scuba_man/ui/health_widget.dart';
import 'package:scuba_man/ui/last_score.dart';
import 'package:scuba_man/ui/record.dart';
import 'package:scuba_man/ui/high_score.dart';
import 'package:flutter/material.dart' hide Image;
import 'package:audioplayers/audio_cache.dart';


class ScubaGame extends BaseGame with MultiTouchDragDetector {
  final jukebox = AudioCache();
  // AudioPlayer gameBGM;
  Scuba scubaGuy;
  List<Fishy> fishies = new List<Fishy>();
  List<Shell> shells = new List<Shell>();
  List<JellyFish> jellies = new List<JellyFish>();
  List<Shark> sharks = new List<Shark>();
  List<Record> records = new List<Record>();
  List<String> bgImages = ['bg_ocean.png'];
  FishySpawner fishySpawner;
  JellyfishSpawner jellySpawner;
  BubbleSpawner bubbleSpawner;
  SharkSpawner sharkSpawner;
  HighScore scoreCard;
  LastScore lastScoreCard;
  HealthBarState healthBarState;
  HighScoreState scoreState;
  LastScoreState lastScoreState;
  int health;
  JoystickComponent joystick;
  SpriteAnimation scubaAnim, jellyAnim;
  bool scubaIsInvincible = false;
  ParallaxComponent parallax;
  Timer invincibilityTimer;
  TimerComponent invincibilityTimerComponent;

  @override
  Future<void> onLoad() async {
    final scubaImage = await images.load('sprite_scuba_man.png');

    scubaAnim = SpriteAnimation.fromFrameData(
      scubaImage,
      SpriteAnimationData.sequenced(
        amount: 1,
        textureSize: Vector2.all(32),
        stepTime: 0.15,
        loop: false,
      ),
    );

    print("this is print");
    // invincibilityTimerComponent =
    //     TimerComponent();
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

    scubaGuy = Scuba.fromSpriteAnimation(Vector2.all(64), scubaAnim);
    scubaGuy.x = size.x / 2;
    scubaGuy.y = size.y / 2;
    joystick.addObserver(scubaGuy);
    add(bubbleSpawner = BubbleSpawner());
    add(parallax);
    initializeTitleScreen();
    jukebox.loop('audio/bgm/password_mmx.aac');
  }

  @override
  void onReceiveDrag(DragEvent drag) {
    joystick.onReceiveDrag(drag);
    super.onReceiveDrag(drag);
  }

  ScubaGame(this.healthBarState, this.scoreState) {
    health = 3;

    records.addAll([
      Record(50, "FRN"),
      Record(45, "FRN"),
      Record(40, "NAR"),
      Record(35, "ALY"),
      Record(30, "AMT"),
      Record(25, "FMG"),
      Record(20, "JMG"),
      Record(15, "JPG"),
      Record(10, "JHG"),
      Record(5, "ASS")
    ]);
  }

  void startGame() {
    _clearTitleScreen();
    summonScuba();
    //   playGameBGM();
    overlays.add('health_bar');
    overlays.add('quit_button');
    overlays.add('score');
    add(fishySpawner = FishySpawner());
    add(jellySpawner = JellyfishSpawner());
    add(sharkSpawner = SharkSpawner());
    resetScore(); 
  }

  void toScoreBoard() {
    _clearTitleScreen();
    // addWidgetOverlay('record_list', Records(records));
    // addWidgetOverlay('quit_button', QuitButton(toTitle));
  }

  void toTitle() {
    overlays.remove('quit_button');
    overlays.remove('health_bar');
    removeAll(components);
    add(parallax);
    resetHealth();
    overlays.add('health_bar');
    initializeTitleScreen();
  }

  void initializeTitleScreen() {
    overlays.add('title_image');
    overlays.add('start_button');
    overlays.add('record_button');
  }

  void addHighScore() {
    //records.add(Record(score, "NEW"));
    records.removeLast();
  }

  void _clearTitleScreen() {
    overlays.remove('title_image');
    overlays.remove('start_button');
    overlays.remove('record_button');
  }

  summonScuba() {
    add(scubaGuy);
    add(joystick);
  }

  summonFishy(Fishy fish) {
    fishies.add(fish);
    add(fish);
  }

  // addShell(Shell shell) {
  //   shells.add(shell);
  //   add(shell);
  // }

  // addJelly(JellyFish jellyFish) {
  //   jellies.add(jellyFish);
  //   add(jellyFish);
  // }

  // addShark(Shark shark) {
  //   sharks.add(shark);
  //   add(shark);
  // }

  updateScore(int points) {
    scoreState.updateScore(points);
  }

  resetScore() {
    scoreState.resetScore();
  }

  damageHealth(int damage) {
    if (scubaIsInvincible) {
      print("Scubaguy is invincible to this blow!");
    } else {
      scubaIsInvincible = true;
      add((TimerComponent(invincibilityTimer..start()))); 
      health += damage;
      healthBarState.updateHealth(health);
      if (health < 1) {
        gameOver();
      }
    }
  }

  resetHealth() {
    health = 3;
    healthBarState.resetHealth();
  }

  gameOver() {
    //saveScoreAndGiveSplashScreen();
    toTitle();
  }
}
