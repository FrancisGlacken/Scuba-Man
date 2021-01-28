// import 'package:box2d_flame/box2d.dart';
// import 'package:flame/box2d/box2d_component.dart';
// import 'package:flutter/widgets.dart';
// import 'package:scuba_man/utils/utils.dart';

// class BorderWall {
//   List<BodyComponent> _bodies = List();

//   BorderWall(Box2DComponent box) {
//     _bodies.add(BorderBody(box, 1.0, 0, Alignment.topCenter));
//     _bodies.add(BorderBody(box, 0, 1.0, Alignment.centerRight));
//     _bodies.add(BorderBody(box, 0, 1.0, Alignment.centerLeft));
//   }

//   List<BodyComponent> get bodies => _bodies;
// }

// class Sand extends BodyComponent {
//   double y, width, height;
//   Size size; 

//   ImagesLoader images = new ImagesLoader();

//   Sand(box2d, this.size) : super(box2d) {
//     width = box.viewport.width;
//     height = box.viewport.height * .05;
//     _loadImages();
//     _createBody();
//   }

//   void _loadImages() {
//     images.load("sand", "sand.png");
//   }

//   void render(Canvas canvas) {
//     var _image;
//     _image = images.get("sand");

//     paintImage(
//       canvas: canvas,
//       image: _image,
//       rect: new Rect.fromLTWH(0, size.height * .95, width, height), 
//       //(width, box.viewport.height, width, 30),
//       repeat: ImageRepeat.repeat,
//       fit: BoxFit.fitWidth,
//       alignment: Alignment.bottomCenter,
//     );
//   }

//   _createBody() {
//     //Create SHape
//     final shape = new PolygonShape()..setAsBoxXY(box.viewport.width, height);
//     //Create Body
//     final bodyDef = new BodyDef()
//       ..setUserData("wall")
//       ..setType(BodyType.STATIC)
//       ..setPosition(Vector2(0, -box.viewport.height/2));
//     bodyDef.bullet = true;

//     // Create Fixture which is the thing that holds the physics
//     final fixtureDef = new FixtureDef();
//     fixtureDef.shape = shape;
//     fixtureDef.restitution = 0.7;
//     fixtureDef.density = .1;
//     fixtureDef.friction = 0.2;
//     fixtureDef.userData = "wall";

//     this.body = world.createBody(bodyDef)
//       ..createFixtureFromFixtureDef(fixtureDef);
//   }
// }

// class BorderBody extends BodyComponent {
//   double widthPercent;
//   double heightPercent;
//   Alignment alignment;
//   double width, height, x, y;
//   ImagesLoader images = new ImagesLoader();

//   bool first = true;

//   BorderBody(
//       Box2DComponent box, this.widthPercent, this.heightPercent, this.alignment)
//       : super(box) {
//     _createBody();
//   }

//   // @override
//   // void renderCirlce(Canvas canvas) {
//   //   var _image;
//   //   _image = images.get("ocean");

//   //   paintImage(canvas: canvas, rect: new Rect.fromLTWH(50, 50, width, height), image: _image);
//   //   super.render(canvas);
//   // }

//   // void _loadImages() {
//   //     images.load("ocean", "bg_ocean.png");
//   // }

//   void _createBody() {
//     width = box.viewport.width * widthPercent;
//     height = box.viewport.height * heightPercent;

//     x = alignment.x * (box.viewport.width - width);
//     y = (-alignment.y) * (box.viewport.height - height);

//     final shape = PolygonShape()..setAsBoxXY(width, height);

//     // This format is semantically the same as the fixture definition below
//     final bodyDef = BodyDef()
//       ..setUserData(this)
//       ..setPosition(Vector2(x / 2, y / 2));

//     final fixtureDef = FixtureDef();
//     fixtureDef.shape = shape;
//     fixtureDef.restitution = 0.0;
//     fixtureDef.friction = 0.2;
//     fixtureDef.userData = "wall";

//     Body groundBody = world.createBody(bodyDef);
//     groundBody.createFixtureFromFixtureDef(fixtureDef);
//     this.body = groundBody;
//   }
// }
