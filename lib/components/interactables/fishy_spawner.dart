import 'package:flame/components/component.dart';
import 'package:flame/components/mixins/has_game_ref.dart';
import 'package:flame/components/sprite_component.dart';
import 'package:flame/extensions/vector2.dart';
import 'package:flame/sprite_animation.dart';
import 'package:flame/timer.dart';
import 'package:scuba_man/components/interactables/fishy.dart';
import 'package:scuba_man/scuba_game.dart';
import 'dart:ui';
import 'dart:math';

class FishySpawner extends Component with HasGameRef<ScubaGame> {
  Timer timer;
  Random rng = Random();
  bool isDestroyed = false; 
  SpriteAnimation fishyAnim;
  Image fishyImage; 
  Fishy fishy; 

  FishySpawner() {
    timer = Timer(1, repeat: true, callback: () {
      fishy = Fishy(Vector2.all(32), fishyAnim);
      fishy.x = gameRef.size.x + 32;
      fishy.y = rng.nextDouble() * gameRef.size.y;
      gameRef.add(fishy);
    });
    timer.start();
  }

  @override
  Future<void> onLoad() async {

    // TODO: implement onLoad
    fishyImage = await gameRef.images.load('fishy.png');

    fishyAnim = SpriteAnimation.fromFrameData(
      fishyImage,
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

  void destroy() {
    shouldRemove = true; 
  }
}
