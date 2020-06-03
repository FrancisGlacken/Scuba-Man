import 'package:flame/box2d/box2d_component.dart';
import 'package:box2d_flame/box2d.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';
import 'package:scuba_man/utils.dart';
import 'dart:math';

class Scuba extends BodyComponent {
  static const num BALL_RADIUS = 8.0; 
  Random rng = new Random(); 
  Random rngCharge = new Random(); 
  double posX, posY, chargeX = 1, chargeY = 1;  

  ImagesLoader images = new ImagesLoader(); 

  Scuba(box2d, double x, double y) : super(box2d) {
    posX = x; 
    posY = y; 
    _loadImages();
    _createBody();
  }

  void _loadImages() {
      images.load("scuba", "sprite_scuba_man.png");
  }

  void renderCircle(Canvas c, Offset center, double radius) {
    var _image;
    _image = images.get("scuba");
  
    paintImage(
        canvas: c,
        image: _image,
        rect: new Rect.fromCircle(center: center, radius: radius),
        fit: BoxFit.contain);
  }

  _createBody() {
    //Create Body
    final bodyDef = new BodyDef();

    if (rng.nextBool()) chargeX = chargeX * -1;
    if (rng.nextBool()) chargeY = chargeY * -1;
    bodyDef.position = new Vector2(posX, posY);
    bodyDef.type = BodyType.DYNAMIC;
    bodyDef.bullet = true;
    bodyDef.userData = this; 

    //Create SHape
    final shape = new CircleShape(); 
    shape.radius = Scuba.BALL_RADIUS;
    shape.p.x = 0.0; 

    // Create Fixture which is the thing that holds the physics
    final fixtureDef = new FixtureDef();
    fixtureDef.shape = shape; 
    fixtureDef.restitution = 0.7;
    fixtureDef.density = .1;
    fixtureDef.friction = 0.2;
    fixtureDef.userData = this; 
    
  
    this.body = world.createBody(bodyDef)..createFixtureFromFixtureDef(fixtureDef);
  }

  // void input(Offset position) {
  //   Vector2 force = position.dx < 250 ? new Vector2(-1.0, 0.0) : new Vector2(1.0, 0.0);
  //   body.applyForce(force..scale(10000.0), center); 
  // }

  void handleDragUpdate(DragUpdateDetails details) {
    impulse(details.delta);
  }

  void handleDragEnd(DragEndDetails details) {
    //impulse(details.velocity.pixelsPerSecond); 
  }

  void impulse(Offset velocity) {
    Vector2 force = new Vector2(velocity.dx * 3, -velocity.dy * 4)..scale(2.0);
    body.applyLinearImpulse(force, center, true);
  }

  void stop() {
    body.linearVelocity = new Vector2(0.0, 0.0);
    body.angularVelocity = 0.0;
  }
}