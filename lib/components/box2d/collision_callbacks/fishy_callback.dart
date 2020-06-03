import 'package:box2d_flame/box2d.dart';
import 'package:flame/box2d/contact_callbacks.dart';
import 'package:scuba_man/components/interactables/fishy.dart';
import 'package:scuba_man/components/player/scuba.dart';

class FishyCallback implements ContactCallback<Fishy, Scuba>{

  FishyCallback();

  @override
  ContactTypes<Fishy, Scuba> types;

  @override
  void begin(Fishy fishy, Scuba scuba, Contact contact) {
    fishy.destroy(); 
    scuba.destroy(); 
  }

  @override
  void end(Fishy fishy, Scuba scuba, Contact contact) {
    // TODO: implement end
  }

  @override
  void postSolve(Fishy fishy, Scuba scuba, Contact contact, ContactImpulse impulse) {
    // TODO: implement postSolve
  }

  @override
  void preSolve(Fishy a, Scuba b, Contact contact, Manifold oldManifold) {
    // TODO: implement preSolve
  }

}