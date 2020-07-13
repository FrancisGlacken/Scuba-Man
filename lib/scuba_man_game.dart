import 'dart:ui';
import 'package:flame/box2d/box2d_component.dart';
import 'package:flame/components/mixins/tapable.dart';
import 'package:flame/flame.dart';
import 'package:flame/gestures.dart';
import 'package:flutter/widgets.dart';
import 'package:scuba_man/components/background-ocean.dart';
import 'package:scuba_man/components/box2d/border_wall.dart';
import 'package:scuba_man/components/box2d/collision_callbacks/fishy_callback.dart';
import 'package:scuba_man/components/box2d/scuba_world.dart';
import 'package:scuba_man/scuba_man_ui.dart';
import 'package:scuba_man/components/enemies/jellyfish.dart';
import 'package:flutter/gestures.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flame/box2d/box2d_game.dart';

class ScubaManGame extends Box2DGame with PanDetector {
  final ScubaWorld world; 
  Ocean ocean;
  final ScubaManUIState uiState;  
  List<JellyFish> jellies; 
  List<BodyComponent> borders; 
  AudioPlayer homeBGM;
  AudioPlayer gameBGM; 

  ScubaManGame(this.world, Size size, this.uiState) : super(world) {
    this.size = size; 
    addContactCallback(FishyCallback());
    initialize(); 
  }

  void initialize() async {
    borders = BorderWall(world).bodies; 
    add(ocean = Ocean());

    homeBGM = await Flame.audio.loopLongAudio('bgm/ecco_title_gg.mp3', volume: .25);
    homeBGM.pause(); 

    gameBGM = await Flame.audio.loopLongAudio('bgm/password_mmx.mp3', volume: .25);
    gameBGM.pause(); 

    playHomeBGM(); 
    borders.forEach((b) {
      add(b); 
    }); 

  }

  updateScore(int points) {
    uiState.updateScoreForFishy(); 
  }

  // void toTitle() {
  //   uiState.toTitleScreen(); 
  // }

  playHomeBGM() {
      // gameBGM.pause();
      // gameBGM.seek(Duration.zero);
      // homeBGM.resume(); 
  }

  playGameBGM() {
      // homeBGM.pause();
      // homeBGM.seek(Duration.zero);
      // gameBGM.resume(); 
  }

  @override
  render(Canvas c) {
    super.render(c);
    world.render(c); 
  }

  @override
  update(double t) {
    super.update(t);
    world.update(t);
  }

  @override
  void resize(Size size) {
    world.resize(size);
  }


  // @override
  // void onTapDown(int pointerId, TapDownDetails details) {
  //   world.handleTap(details);
  // }

  @override
  void onPanUpdate(DragUpdateDetails details) {
    world.handleDragUpdate(details);
  }

  @override
  void onPanEnd(DragEndDetails details) {
    world.handleDragEnd(details); 
  }
}
