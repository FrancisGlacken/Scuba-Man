import 'dart:math';
import 'dart:ui';

import 'package:flame/components.dart';
import 'package:scuba_man/components/interactables/fishy.dart';
import 'package:scuba_man/scuba_game.dart';

class Scuba extends SpriteAnimationComponent
    with HasGameRef<ScubaGame>
    implements JoystickListener {
  final double speed = 159;
  double radAngle = 0;
  bool _move = false;
  double currentSpeed = 0;
  SpriteAnimation scubaAnim;
  Image scubaImage;
  Rect _rect;

  Scuba.fromSpriteAnimation(size, animation) : super.fromSpriteAnimation(size, animation); 

  @override
  void update(double dt) {
    super.update(dt);
    if (_move) {
      moveFromAngle(dt);
    }

    if (x < 0)
      x = 0;
    else if (x > gameRef.size.x - 32)
      x = gameRef.size.x - 32;
    else if (y < 0)
      y = 0;
    else if (y > gameRef.size.y - 32) y = gameRef.size.y - 32;

    // if (this.toRect().overlaps() = true; 
    // gameRef.fishies.forEach((Fishy f) {
    //   if (f.toRect().overlaps(this.toRect())) {
    //     shouldRemove = true;
    //   }
    // });
  }

  @override
  void onGameResize(Vector2 size) {
    _rect = animation.currentFrame.sprite.src;
    super.onGameResize(size);
  }

  @override
  void joystickAction(JoystickActionEvent event) {
    // if (event.event == ActionEvent.DOWN) {
    //   if (event.id == 1) {
    //     _paint = _paint == _whitePaint ? _bluePaint : _whitePaint;
    //   }
    //   if (event.id == 2) {
    //     _paint = _paint == _whitePaint ? _greenPaint : _whitePaint;
    //   }
    // }
  }

  @override
  void joystickChangeDirectional(JoystickDirectionalEvent event) {
    _move = event.directional != JoystickMoveDirectional.IDLE;
    if (_move) {
      radAngle = event.radAngle;
      currentSpeed = speed * event.intensity;
    }

  }

  void moveFromAngle(double dtUpdate) {
    final double nextX = (currentSpeed * dtUpdate) * cos(radAngle);
    final double nextY = (currentSpeed * dtUpdate) * sin(radAngle);

    if (_rect == null) {
      return;
    }

    final Offset diffBase = Offset(
          _rect.center.dx + nextX,
          _rect.center.dy + nextY,
        ) -
        _rect.center;

    this.x = this.x + diffBase.dx;
    this.y = this.y + diffBase.dy;
  }
}
