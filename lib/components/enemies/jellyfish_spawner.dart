import 'package:flame/components/component.dart';
import 'package:flame/components/mixins/has_game_ref.dart';
import 'package:flame/extensions/vector2.dart';
import 'package:flame/sprite_animation.dart';
import 'package:flame/timer.dart';
import 'package:scuba_man/components/enemies/jellyfish.dart';
import 'package:scuba_man/scuba_game.dart';

import 'dart:ui';
import 'dart:math';

class JellyfishSpawner extends Component with HasGameRef<ScubaGame> {
  Timer timer;
  Random rng = Random();
  bool isDestroyed = false; 
  Image jellyImage; 
  SpriteAnimation jellyAnim; 
  JellyFish jelly; 

  JellyfishSpawner() {
    timer = Timer(7, repeat: true, callback: () {
      jelly = JellyFish(Vector2.all(32), jellyAnim);
      jelly.x = gameRef.size.x;
      jelly.y = gameRef.size.y * rng.nextDouble();
      gameRef.add(jelly);
    });
    timer.start();
  }

  @override
  Future<void> onLoad() async {
    // TODO: implement onLoad
    jellyImage = await gameRef.images.load('sprite_sheet_jellyfish.png');

    jellyAnim = SpriteAnimation.fromFrameData(
      jellyImage,
      SpriteAnimationData.sequenced(
        amount: 10,
        textureSize: Vector2.all(16),
        stepTime: 0.5,
        loop: true,
      ),
    );
    return super.onLoad();
  }

  @override
  void update(double t) {
    timer.update(t);
  }

  @override
  void render(Canvas c) {}

  @override
  bool destroy() {
    return isDestroyed;
  }

  void destroyed() {
    timer.stop(); 
    isDestroyed = true; 

  }
  
}
