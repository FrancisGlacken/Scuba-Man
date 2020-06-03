import 'dart:math';

import 'package:flame/box2d/box2d_component.dart';
import 'package:flame/components/mixins/has_game_ref.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:scuba_man/scuba_man_game.dart';
import 'package:scuba_man/utils.dart';
import 'package:box2d_flame/box2d.dart';

class Fishy extends BodyComponent with HasGameRef<ScubaManGame> {
  static const num BALL_RADIUS = 4.0; 
  Random rng = new Random(); 
  Random rngCharge = new Random(); 
  double posX, posY, acceleration; 
  bool isDestroyed = false; 

  ImagesLoader images = new ImagesLoader(); 

  Fishy(box2D, double x, double y) : super(box2D){
    posX = x; 
    posY = y; 
    acceleration = 0; 
    _loadImages();
    _createBody(); 
  }

  void _loadImages() {
      images.load("fishy", "sprite_sheet_fishy.png");
  }

  void renderCircle(Canvas c, Offset center, double radius) {
    var _image;
    _image = images.get("fishy");
  
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

    bodyDef.linearVelocity = new Vector2(-10 - acceleration, 0);
    bodyDef.position = new Vector2(posX, posY);
    bodyDef.type = BodyType.DYNAMIC;
    bodyDef.bullet = true;
    bodyDef.userData = this; 
    bodyDef.gravityScale = 0.0; 
    
    

    //Create SHape
    final shape = new CircleShape(); 
    shape.radius = Fishy.BALL_RADIUS;
    shape.p.x = 0.0; 

    // Create Fixture which is the thing that holds the physics
    final fixtureDef = new FixtureDef();
    fixtureDef.shape = shape; 
    fixtureDef.restitution = 0.7;
    fixtureDef.density = 0.001;
    fixtureDef.friction = 0.2;


    this.body = world.createBody(bodyDef)..createFixtureFromFixtureDef(fixtureDef);
  }


  void collisionCollect() {
    gameRef.uiState.updateScoreForFishy();
    //destroyOnFinish = true; 
  }

  void onTapDown(TapDownDetails d) {
    print("fishy tapped");
  }

  @override
  bool destroy() {
  return isDestroyed;
  }

  void impact() {
    // collisionCollect();
    isDestroyed = true; 
  }
}