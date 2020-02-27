import 'package:flame/components/component.dart';
import 'package:flame/components/mixins/has_game_ref.dart';
import 'package:flame/time.dart';
import 'package:scuba_man/components/enemies/shark.dart';
import 'package:scuba_man/scuba_man_game.dart';

import 'dart:ui';
import 'dart:math';

class SharkSpawner extends Component with HasGameRef<ScubaManGame> {
  
  Timer timer;
  Random rng = Random(); 

  SharkSpawner() {
    timer = Timer(3, repeat: true, callback: () {
      gameRef.add(
        Shark(
          gameRef.size.width,
          rng.nextInt(gameRef.size.height.toInt()).toDouble()));
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