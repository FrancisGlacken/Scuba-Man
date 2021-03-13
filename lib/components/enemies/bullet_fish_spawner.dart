import 'package:flame/components.dart';
import 'package:flame/timer.dart';
import 'package:scuba_man/components/enemies/bullet_fish.dart';
import 'dart:ui';
import 'dart:math';
import 'package:scuba_man/scuba_game.dart';

class BulletFishSpawner extends Component with HasGameRef<ScubaGame> {
  Timer timer;
  Random rng = Random();
  bool isDestroyed = false;
  Image sharkImage;
  SpriteAnimation sharkAnim;
  BulletFish bulletFish;

  BulletFishSpawner() {
    timer = Timer(6, repeat: true, callback: () {
      sharkAnim = SpriteAnimation.fromFrameData(
        sharkImage,
        SpriteAnimationData.sequenced(
          amount: 12,
          textureSize: Vector2.all(32),
          stepTime: .3,
          loop: true,
        ),
      );
      bulletFish = BulletFish.fromSpriteAnimation(Vector2.all(64), sharkAnim);
      bulletFish.x = gameRef.size.x;
      bulletFish.y = gameRef.size.y * rng.nextDouble();
      gameRef.add(bulletFish);
    });
    timer.start();
  }

  @override
  Future<void> onLoad() async {
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
