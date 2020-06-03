import 'dart:math';

import 'package:flame/box2d/box2d_component.dart';
import 'package:flame/box2d/box2d_game.dart';
import 'package:box2d_flame/box2d.dart';

import 'package:flame/components/mixins/has_game_ref.dart';
import 'package:flame/animation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:scuba_man/scuba_man_game.dart';
import 'package:scuba_man/utils.dart';

class Shell extends BodyComponent with HasGameRef<ScubaManGame> {
  static const num BALL_RADIUS = 4.0;
  Random rng = new Random();
  Random rngCharge = new Random();
  double posX, posY, acceleration;
  bool isDestroyed = false;  

  ImagesLoader images = new ImagesLoader();

  Shell(box2d, double x, double y) : super(box2d) {
    posX = x;
    posY = y;
    acceleration = 0; 
    _loadImages();
    _createBody();
  }

  void _loadImages() {
    images.load("shell", "sprite_sheet_shell.png");
  }

  void renderCircle(Canvas c, Offset center, double radius) {
    var _image;
    _image = images.get("shell");

    paintImage(
        canvas: c,
        image: _image,
        rect: new Rect.fromCircle(center: center, radius: radius),
        fit: BoxFit.contain);
  }

  _createBody() {
    //Create Body
    final bodyDef = new BodyDef();
    acceleration = acceleration + 1;

    bodyDef.linearVelocity = new Vector2(10, 0);
    bodyDef.position = new Vector2(posX, posY);
    bodyDef.type = BodyType.DYNAMIC;
    bodyDef.bullet = true;
    bodyDef.userData = this;
    bodyDef.gravityScale = 0.0; 

    //Create SHape
    final shape = new CircleShape();
    shape.radius = Shell.BALL_RADIUS;
    shape.p.x = 0.0;

    // Create Fixture which is the thing that holds the physics
    final fixtureDef = new FixtureDef();
    fixtureDef.shape = shape;
    fixtureDef.restitution = 0.7;
    fixtureDef.density = 0.05;
    fixtureDef.friction = 0.2;

    this.body = world.createBody(bodyDef)..createFixtureFromFixtureDef(fixtureDef);
  }

  void collisionCollect() {
    gameRef.uiState.updateScoreForShell();
    //destroyOnFinish = true;
  }

  void onTapDown(TapDownDetails d) {
    print("shell tapped");
  }

  @override
  bool destroy() {
  return isDestroyed;
  }
}
