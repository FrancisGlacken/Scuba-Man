import 'package:flame/components.dart';
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
      jellyAnim = SpriteAnimation.fromFrameData(
        jellyImage,
        SpriteAnimationData.sequenced(
          amount: 10,
          textureSize: Vector2.all(16),
          stepTime: .5,
          loop: true,
        ),
      );
      jelly = JellyFish.fromSpriteAnimation(Vector2.all(32), jellyAnim);
      jelly.x = gameRef.size.x + 32;
      jelly.y = (gameRef.size.y * rng.nextDouble()) + 50;
      gameRef.add(jelly);
    });
    timer.start();
  }

  @override
  Future<void> onLoad() async {
    // TODO: implement onLoad
    jellyImage = await gameRef.images.load('sprite_sheet_jellyfish.png');
    return super.onLoad();
  }

  @override
  void update(double t) {
    timer.update(t);
  }
}
