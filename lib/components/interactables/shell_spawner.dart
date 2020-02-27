import 'package:flame/components/component.dart';
import 'package:flame/components/mixins/has_game_ref.dart';
import 'package:flame/time.dart';
import 'package:scuba_man/components/interactables/shell.dart';
import 'package:scuba_man/scuba_man_game.dart';

import 'dart:ui';
import 'dart:math';

class ShellSpawner extends Component with HasGameRef<ScubaManGame> {
  
  Timer timer;
  var trash; 
  Random rng = Random(); 

  ShellSpawner() {
    timer = Timer(5, repeat: true, callback: () {
      gameRef.add(
        Shell(
          rng.nextInt(gameRef.size.width.toInt()).toDouble(),
          0));
    });
    timer.start();
  }

  @override
  void update(double t) {
    timer.update(t); 
    //this is deleted now
  }

  @override
  void render(Canvas c) {
  }
}