import 'dart:ui';
import 'package:flame/game.dart'; 
import 'package:flame/flame.dart';
import 'package:flame/gestures.dart';
import 'package:flutter/widgets.dart';
import 'package:scuba_man/components/background-ocean.dart';
import 'package:scuba_man/components/box2d/scuba_world.dart';
import 'package:scuba_man/scuba_man_ui.dart';
import 'package:scuba_man/components/enemies/jellyfish.dart';
import 'package:flutter/gestures.dart';
import 'package:audioplayers/audioplayers.dart';


class ScubaManGame extends BaseGame with TapDetector, PanDetector{
  final ScubaWorld world = ScubaWorld(); 
  Ocean ocean;
  final ScubaManUIState uiState;  
  List<JellyFish> jellies; 
  AudioPlayer homeBGM;
  AudioPlayer gameBGM; 

  ScubaManGame(Size size, this.uiState) {
    this.size = size; 
  
    initialize(); 
  }

  void initialize() async {
    add(ocean = Ocean());

    homeBGM = await Flame.audio.loopLongAudio('bgm/ecco_title_gg.mp3', volume: .25);
    homeBGM.pause(); 

    gameBGM = await Flame.audio.loopLongAudio('bgm/password_mmx.mp3', volume: .25);
    gameBGM.pause(); 

    playHomeBGM(); 
    world.initializeWorld(); 

  }

  playHomeBGM() {
      gameBGM.pause();
      gameBGM.seek(Duration.zero);
      homeBGM.resume(); 
  }

  playGameBGM() {
      homeBGM.pause();
      homeBGM.seek(Duration.zero);
      gameBGM.resume(); 
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

  @override
  void onTapUp(TapUpDetails details) {
    world.handleTap(details.globalPosition);
  }

  @override
  void onPanUpdate(DragUpdateDetails details) {
    world.handleDragUpdate(details);
  }

  @override
  void onPanEnd(DragEndDetails details) {
    world.handleDragEnd(details); 
  }
}
