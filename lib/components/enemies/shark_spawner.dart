import 'package:flame/components.dart';
import 'package:flame/timer.dart';
import 'package:scuba_man/components/enemies/shark.dart';

import 'dart:ui';
import 'dart:math';

import 'package:scuba_man/scuba_game.dart';

class SharkSpawner extends Component with HasGameRef<ScubaGame> {
  Timer timer;
  Random rng = Random();
  bool isDestroyed = false;
  Image sharkImage;
  SpriteAnimation sharkAnim;
  Shark shark;

  SharkSpawner() {
    timer = Timer(6, repeat: true, callback: () {
      sharkAnim = SpriteAnimation.fromFrameData(
        sharkImage,
        SpriteAnimationData.sequenced(
          amount: 1,
          textureSize: Vector2.all(32),
          stepTime: 1,
          loop: false,
        ),
      );
      shark = Shark.fromSpriteAnimation(Vector2.all(64), sharkAnim);
      shark.x = gameRef.size.x;
      shark.y = gameRef.size.y * rng.nextDouble();
      gameRef.add(shark);
    });
    timer.start();
  }

  @override
  Future<void> onLoad() async {
    // TODO: implement onLoad
    sharkImage = await gameRef.images.load('sprite_sheet_bullet_fish.png');

    return super.onLoad();
  }

  @override
  void update(double t) {
    timer.update(t);
  }

  @override
  void render(Canvas c) {}

  void destroy() {
    shouldRemove = true;
  }

  void destroyed() {
    timer.stop();
    isDestroyed = true;
  }
}
