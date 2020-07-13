import 'package:box2d_flame/box2d.dart';
import 'package:flame/box2d/box2d_component.dart';
import 'package:flame/components/mixins/has_game_ref.dart';
import 'package:flutter/widgets.dart';
import 'package:scuba_man/scuba_man_game.dart';

class BorderWall {
  List<BodyComponent> _bodies = List();

  BorderWall(Box2DComponent box) {
    _bodies.add(BorderBody(box, 1.0, 0.01, Alignment.topCenter));
    _bodies.add(BorderBody(box, 1.0, 0.01, Alignment.bottomCenter));
    _bodies.add(BorderBody(box, 0.01, 1.0, Alignment.centerRight));
    _bodies.add(BorderBody(box, 0.01, 1.0, Alignment.centerLeft));
  }

  List<BodyComponent> get bodies => _bodies;
}

class BorderBody extends BodyComponent {
  Orientation orientation;
  double widthPercent;
  double heightPercent;
  Alignment alignment;

  bool first = true;

  BorderBody(
      Box2DComponent box, this.widthPercent, this.heightPercent, this.alignment)
      : super(box) {
    _createBody();
  }

  void _createBody() {
    double width = box.viewport.width * widthPercent;
    double height = box.viewport.height * heightPercent;

    double x = alignment.x * (box.viewport.width - width);
    double y = (-alignment.y) * (box.viewport.height - height);

    final shape = PolygonShape();
    shape.setAsBoxXY(width, height);

    final bodyDef = BodyDef();
    bodyDef.position = Vector2(x / 2, y / 2);
    bodyDef.userData = this; 

    final fixtureDef = FixtureDef();
    fixtureDef.shape = shape;
    fixtureDef.restitution = 0.0;
    fixtureDef.friction = 0.2;
    fixtureDef.userData = "wall"; 

    Body groundBody = world.createBody(bodyDef);
    groundBody.createFixtureFromFixtureDef(fixtureDef);
    this.body = groundBody;
  }

  void impact() {
    //gameRef.toTitle();
  }
}
