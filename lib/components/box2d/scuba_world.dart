import 'package:flame/components/mixins/has_game_ref.dart';
import 'package:scuba_man/components/interactables/shell.dart';
import 'package:scuba_man/components/player/scuba.dart';
import 'package:scuba_man/components/interactables/fishy.dart';
import 'package:flame/box2d/box2d_component.dart';
import 'package:flutter/material.dart';
import 'package:box2d_flame/box2d.dart' hide Timer;
import 'package:scuba_man/scuba_man_game.dart';

class ScubaWorld extends Box2DComponent with HasGameRef<ScubaManGame> implements ContactFilter, ContactListener {
  Scuba scuba; 
  Shell shell; 
  List<Fishy> fishies = new List<Fishy>(); 
  List<Shell> shells = new List<Shell>(); 
  var levels; 

  ScubaWorld() : super(scale: 2.0);

  @override
  void initializeWorld() {
    // addAll(levels = BorderWall(this).bodies); 
  }

  @override
  void update(double t) {
    world.setContactFilter(this);
    world.setContactListener(this); 
    super.update(t); 
  }

  void spawnScuba() {
    scuba = Scuba(this, 0, 0);
    add(scuba); 
  }

  void despawnScuba() {
    // levels.forEach((element) {
    //   remove(element); 
    // }); 
    remove(scuba); 
  }

  void spawnFishy(Fishy fish) {
    fishies.add(fish);
    add(fish); 
  }

  void despawnFishy(Fishy fish) {
    remove(fish);
  }

  void despawnFishies() {
    fishies.forEach((f){
      remove(f); 
    });
  }

  void spawnShell(Shell shell) {
    shells.add(shell);
    add(shell); 
  }

  void despawnShell(Shell shell) {
    remove(shell); 
  }

  void despawnShells() {
    shells.forEach((s) {
      remove(shell); 
    });
  }

  void handleTap(TapDownDetails details) {
    scuba.stop();
    print("handle tap clicked");
  }

  void handleDragUpdate(DragUpdateDetails d) {
    scuba.handleDragUpdate(d); 
  }

  void handleDragEnd(DragEndDetails d) {
    scuba.handleDragEnd(d); 
  }

  @override
  void beginContact(Contact contact) {
    // if (contact.fixtureA.userData == 'fishy' && contact.fixtureB.userData == 'scuba') {
      
    //   (contact.fixtureA.getBody().userData as Fishy).impact(); 
    // }
    // if (contact.fixtureB.userData == 'fishy' && contact.fixtureA.userData == 'scuba') {
    //   (contact.fixtureB.getBody().userData as Fishy).impact(); 
    // }
  }

  @override
  void endContact(Contact contact) {
    // TODO: implement endContact
  }

  @override
  void postSolve(Contact contact, ContactImpulse impulse) {
    // TODO: implement postSolve
  }

  @override
  void preSolve(Contact contact, Manifold oldManifold) {
    // TODO: implement preSolve
  }

  @override
  bool shouldCollide(Fixture fixtureA, Fixture fixtureB) {
    // Wall & Fishy
    if (fixtureA.userData == 'wall' && fixtureB.userData == 'fishy') {
      return false; 
    }
    if (fixtureB.userData == 'wall' && fixtureA.userData == 'fishy') {
      return false; 
    }

    // Scuba & Fishy
    // if (fixtureA.userData == 'scuba' && fixtureB.userData == 'fishy') {
    //   return false; 
    // }
    // if (fixtureB.userData == 'scuba' && fixtureA.userData == 'fishy') {
    //   return false; 
    // }
    return true; 
  }
}
