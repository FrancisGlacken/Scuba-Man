import 'dart:ui';
import 'package:flame/components/sprite_animation_component.dart';
import 'package:flame/extensions/vector2.dart';
import 'package:flame/game/game_widget.dart';
import 'package:flame/flame.dart';
import 'package:flame/sprite_animation.dart';
import 'package:flame/util.dart';

import 'package:flutter/services.dart';
//import 'package:hive/hive.dart';
//import 'package:path_provider/path_provider.dart' as path_provider;
import 'package:flame/components/joystick/joystick_component.dart';
import 'package:flame/components/joystick/joystick_directional.dart';
import 'package:flame/components/parallax_component.dart';
import 'package:flame/gestures.dart';
import 'package:scuba_man/components/box2d/border_wall.dart';
import 'package:scuba_man/components/box2d/collision_callbacks/fishy_callback.dart';
import 'package:scuba_man/components/box2d/collision_callbacks/jelly_callback.dart';
import 'package:scuba_man/components/box2d/collision_callbacks/shark_callback.dart';
import 'package:scuba_man/components/box2d/collision_callbacks/shell_callback.dart';
import 'package:flutter/gestures.dart';
import 'package:flame/game.dart';
import 'package:scuba_man/components/enemies/jellyfish.dart';
import 'package:scuba_man/components/enemies/jellyfish_spawner.dart';
import 'package:scuba_man/components/enemies/shark.dart';
import 'package:scuba_man/components/enemies/shark_spawner.dart';
import 'package:scuba_man/components/interactables/bubble_spawner.dart';
import 'package:scuba_man/components/interactables/fishy_spawner.dart';
import 'package:scuba_man/components/interactables/shell.dart';
import 'package:scuba_man/components/interactables/shell_spawner.dart';
import 'package:scuba_man/components/parallax_bg.dart';
import 'package:scuba_man/components/player/scuba.dart';
import 'package:scuba_man/components/interactables/fishy.dart';
import 'package:scuba_man/ui/last_score.dart';
import 'package:scuba_man/ui/record.dart';
import 'package:scuba_man/ui/high_score.dart';
import 'package:scuba_man/utils/utils.dart';
import 'package:flutter/material.dart' hide Image;

class ScubaGame extends BaseGame with MultiTouchDragDetector {
  //AudioPlayer homeBGM;
  //AudioPlayer gameBGM;
  ImagesLoader oceanBG;
  Scuba scubaGuy;
  Shell shell;
  List<Fishy> fishies = new List<Fishy>();
  List<Shell> shells = new List<Shell>();
  List<JellyFish> jellies = new List<JellyFish>();
  List<Shark> sharks = new List<Shark>();
  List<ParallaxImage> imagesBG = new List<ParallaxImage>();
  List<Record> records = new List<Record>();
  FishySpawner fishySpawner;
  // ShellSpawner shellSpawner = new ShellSpawner();
  JellyfishSpawner jellySpawner;
  BubbleSpawner bubbleSpawner;
  SharkSpawner sharkSpawner;
  HighScore scoreCard;
  HighScoreState scoreState;
  LastScore lastScoreCard;
  LastScoreState lastScoreState;
  //HealthBar healthBar;
  //HealthBarState healthState;
  var levels;
  int score, health;
  //Sand sand;
  JoystickComponent joystick;
  Image bgImage, scubaImage;
  SpriteAnimation scubaAnim;
  ParallaxComponent parallaxComponent; 

  @override
  Future<void> onLoad() async {
    bgImage = await images.load('bg_ocean.png');
    scubaImage = await images.load('sprite_scuba_man.png');

    joystick = JoystickComponent(
      directional: JoystickDirectional(
          margin: EdgeInsets.only(left: size.x * .8, bottom: size.y * .1)),
    );

    scubaAnim = SpriteAnimation.fromFrameData(
      scubaImage,
      SpriteAnimationData.sequenced(
        amount: 1,
        textureSize: Vector2.all(32),
        stepTime: 0.15,
        loop: false,
      ),
    );

    scubaGuy = Scuba(Vector2.all(50), scubaAnim);
    joystick.addObserver(scubaGuy);

    imagesBG.add(new ParallaxImage('bg_ocean.png',
        repeat: ImageRepeat.repeat,
        alignment: Alignment.center,
        fill: LayerFill.height));
    add(parallaxComponent = ParallaxBg(imagesBG));
    add(bubbleSpawner = BubbleSpawner());
    initializeTitleScreen(); 
  }

  ScubaGame() {
    score = 0;
   // health = 3;
    //sand = Sand(box2D, size);
    scoreState = new HighScoreState();
    lastScoreState = new LastScoreState();
    // healthState = new HealthBarState();
    // addContactCallback(FishyCallback(this));
    // addContactCallback(ShellCallback(this));
    // addContactCallback(JellyCallback(this));
    // addContactCallback(SharkCallback(this));

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

    //List<BodyComponent> borders = BorderWall(box2D).bodies;
    // borders.forEach((b) {
    //   add(b);
    // });

    //add(BubbleSpawner());
    // _initializeMusic();
  }

  void startGame() {
    _clearTitleScreen();
    //   playGameBGM();
    //   // addWidgetOverlay('score', scoreCard = HighScore(scoreState));
    //   // addWidgetOverlay('lastScore', lastScoreCard = LastScore(lastScoreState));
    overlays.add('health_bar');
    overlays.add('quit_button');
    overlays.add('score'); 
    addScuba();
    add(fishySpawner = FishySpawner());
    // add(shellSpawner = ShellSpawner());
    add(jellySpawner = JellyfishSpawner());
    add(sharkSpawner = SharkSpawner());
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
    add(parallaxComponent);  
    overlays.add('health_bar'); 
    initializeTitleScreen(); 
    
    // overlays.add('title_image');
    // overlays.add('start_image');
    // overlays.add('record_button');
  }

  void initializeTitleScreen() { 
    overlays.add('title_image');
    overlays.add('start_button'); 
    overlays.add('record_button');
  }
  


  void addHighScore() {
    records.add(Record(score, "NEW"));
    records.removeLast();
  }

  void _clearTitleScreen() {
    overlays.remove('title_image');
    overlays.remove('start_button');
    overlays.remove('record_button');
  }
  

  void clearUI() {
    components.forEach((element) {
      if (element!= parallaxComponent)
      element.shouldRemove = false; 
    });
    overlays.add('title_image');

    
    // removeWidgetOverlay('title');
    // removeWidgetOverlay('start_button');
    // removeWidgetOverlay('board_button');
    // removeWidgetOverlay('record_list');
    // removeWidgetOverlay('quit_button');
  }

  updateScore(int points) {
    scoreState.updateScore(points);
  }

  resetScore() {
    scoreState.resetScore();
  }

  updateHealth(int damage) {
    health += damage;
    //healthState.updateHealth(damage);
    if (health < 1) {
      // _gameOver();
    }
  }

  resetHealth() {
    health = 3;
    //healthState.resetHealth();
  }

  void _gameOver() {
    resetHealth();
    addHighScore();
    resetScore();
    // scuba.destroyed();
    fishySpawner.destroy();
    // shellSpawner.destroyed();
    jellySpawner.destroy();
    sharkSpawner.destroy();

    fishies.forEach((element) {
      element.destroy();
    });
    fishies.clear();

    shells.forEach((element) {
      element.destroyed();
    });

    jellies.forEach((element) {
      element.destroy();
    });

    sharks.forEach((element) {
      element.destroy();
    });
  }

  @override
  void onTapDown(TapDownDetails details) {
    if (overlays.isActive('quit_button')) {
      toTitle(); 
    }
  }


  @override
  void onReceiveDrag(DragEvent drag) {
    // TODO: implement onReceiveDrag
    joystick.onReceiveDrag(drag);
    super.onReceiveDrag(drag);
  }

  // void _initializeMusic() async {
  //   homeBGM =
  //       await Flame.audio.loopLongAudio('bgm/ecco_title_gg.mp3', volume: .25);
  //   homeBGM.pause();
  //   gameBGM =
  //       await Flame.audio.loopLongAudio('bgm/password_mmx.mp3', volume: .25);
  //   gameBGM.pause();
  // }

  //playHomeBGM() {
  // gameBGM.pause();
  // gameBGM.seek(Duration.zero);
  // homeBGM.resume();
  //}

  playGameBGM() {
    // homeBGM.pause();
    // homeBGM.seek(Duration.zero);
    // gameBGM.resume();
  }

  pauseBGM() {
    // homeBGM.pause();
    // gameBGM.pause();
    // homeBGM.seek(Duration.zero);
    // gameBGM.seek(Duration.zero);
  }

  addScuba() {
    add(scubaGuy);
    add(joystick);
  }

  addFishy(Fishy fish) {
    fishies.add(fish);
    add(fish);
  }

  addShell(Shell shell) {
    shells.add(shell);
    add(shell);
  }

  addJelly(JellyFish jellyFish) {
    jellies.add(jellyFish);
    add(jellyFish);
  }

  addShark(Shark shark) {
    sharks.add(shark);
    add(shark);
  }
}

// class ScubaBox2D extends Box2DComponent implements ContactFilter {
//   ScubaBox2D() : super(scale: 1.0);

//   @override
//   void initializeWorld() {}

//   @override
//   void update(double t) {
//     world.setContactFilter(this);
//     super.update(t);
//   }

//   // finish implementing contact filter
//   @override
//   bool shouldCollide(Fixture fixtureA, Fixture fixtureB) {
//     // Wall & Fishy
//     if (fixtureA.userData == 'wall' && fixtureB.userData == 'fishy') {
//       return false;
//     }
//     // if (fixtureA.userData == 'wall' && fixtureB.userData == 'shell') {
//     //   return false;
//     // }
//     if (fixtureA.userData == 'wall' && fixtureB.userData == 'jellyfish') {
//       return false;
//     }
//     if (fixtureA.userData == 'wall' && fixtureB.userData == 'shark') {
//       return false;
//     }

//     // Fishy collision
//     if (fixtureA.userData == 'fishy' && fixtureB.userData == 'shell') {
//       return false;
//     }
//     if (fixtureA.userData == 'fishy' && fixtureB.userData == 'jellyfish') {
//       return false;
//     }
//     if (fixtureA.userData == 'fishy' && fixtureB.userData == 'fishy') {
//       return false;
//     }
//     if (fixtureA.userData == 'fishy' && fixtureB.userData == 'shark') {
//       return false;
//     }

//     if (fixtureA.userData == 'jellyfish' && fixtureB.userData == 'fishy') {
//       return false;
//     }
//     if (fixtureA.userData == 'jellyfish' && fixtureB.userData == 'shell') {
//       return false;
//     }
//     if (fixtureA.userData == 'jellyfish' && fixtureB.userData == 'shark') {
//       return false;
//     }
//     if (fixtureA.userData == 'jellyfish' && fixtureB.userData == 'jellyfish') {
//       return false;
//     }

//     if (fixtureA.userData == 'shell' && fixtureB.userData == 'fishy') {
//       return false;
//     }
//     if (fixtureA.userData == 'shell' && fixtureB.userData == 'jellyfish') {
//       return false;
//     }
//     if (fixtureA.userData == 'shell' && fixtureB.userData == 'shell') {
//       return false;
//     }
//     if (fixtureA.userData == 'shell' && fixtureB.userData == 'shark') {
//       return false;
//     }

//     if (fixtureA.userData == 'shark' && fixtureB.userData == 'fishy') {
//       return false;
//     }
//     if (fixtureA.userData == 'shark' && fixtureB.userData == 'jellyfish') {
//       return false;
//     }
//     if (fixtureA.userData == 'shark' && fixtureB.userData == 'shell') {
//       return false;
//     }
//     if (fixtureA.userData == 'shark' && fixtureB.userData == 'shark') {
//       return false;
//     }

//     if (fixtureA.userData == 'bubble' || fixtureB.userData == 'bubble') {
//       return false; // No contact for bubbles
//     }

//     return true;
//   }
//}
