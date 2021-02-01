
import 'package:flame/components.dart';
import 'package:flame/timer.dart';
import 'package:scuba_man/components/interactables/bubble.dart';

import 'dart:ui';
import 'dart:math';

import 'package:scuba_man/scuba_game.dart';

class BubbleSpawner extends Component with HasGameRef<ScubaGame> {
  Timer timer;
  Random rng = Random();
  bool isDestroyed = false;
  Image bubbleImage;
  SpriteAnimation bubbleAnim;
  Bubble bubble;
  final Vector2 spriteSize = Vector2.all(16);

  BubbleSpawner() {
    timer = Timer(1, repeat: true, callback: () {
      bubble = Bubble.fromSpriteAnimation(Vector2.all(32), bubbleAnim);
      bubble.x = rng.nextDouble() * gameRef.size.x;
      bubble.y = gameRef.size.y + 32;
      gameRef.add(bubble);
    });
    timer.start();
  }

  @override
  Future<void> onLoad() async {
    // TODO: implement onLoad
    bubbleImage = await gameRef.images.load('bubble.png');

    bubbleAnim = SpriteAnimation.fromFrameData(
      bubbleImage,
      SpriteAnimationData.sequenced(
        amount: 1,
        textureSize: Vector2.all(32),
        stepTime: 0.15,
        loop: false,
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

 
  void destroy() {
    shouldRemove = true;
  }
}
