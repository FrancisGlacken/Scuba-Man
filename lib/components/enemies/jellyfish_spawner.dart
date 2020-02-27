import 'package:flame/components/component.dart';
import 'package:flame/components/mixins/has_game_ref.dart';
import 'package:flame/time.dart';
import 'package:scuba_man/components/enemies/jellyfish.dart';
import 'package:scuba_man/scuba_man_game.dart';

import 'dart:ui';
import 'dart:math';

class JellyfishSpawner extends Component with HasGameRef<ScubaManGame> {
  
  Timer timer;
  Random rng = Random(); 

  JellyfishSpawner() {
    timer = Timer(5, repeat: true, callback: () {
      gameRef.add(
        JellyFish(
          rng.nextInt(gameRef.size.width.toInt()).toDouble(), 
          gameRef.size.height));
    });
    timer.start();
  }

  @override
  void update(double t) {
    timer.update(t); 
  }

  @override
  void render(Canvas c) {
  }
}