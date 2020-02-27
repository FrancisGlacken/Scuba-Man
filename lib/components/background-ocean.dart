import 'dart:ui';
import 'package:flame/components/parallax_component.dart';
import 'package:flame/components/mixins/has_game_ref.dart';
import 'package:flame/sprite.dart';
import 'package:scuba_man/scuba_man_game.dart';

class Ocean extends ParallaxComponent with HasGameRef<ScubaManGame>{

  Sprite bgSprite;
  Rect bgRect; 
  static List<ParallaxImage> images = [
    ParallaxImage('bg_ocean.png'),
    ParallaxImage('bg_ocean.png')
  ];

  Ocean() : super(images, baseSpeed: const Offset(2, 0), layerDelta: const Offset(5, 0));

  
}
