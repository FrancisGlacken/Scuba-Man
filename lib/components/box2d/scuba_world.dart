import 'package:scuba_man/components/box2d/demo.dart';
import 'package:scuba_man/components/player/scuba.dart';
import 'package:flame/box2d/box2d_component.dart';
import 'package:flutter/material.dart';

class ScubaWorld extends Box2DComponent {
  Scuba scuba; 
  var levels; 

  ScubaWorld() : super(scale: 1.0);

  @override
  void initializeWorld() {
    addAll(levels = BorderWall(this).bodies); 
  }

  @override
  void update(double t) {
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

  void handleTap(Offset position) {
    scuba.stop();
  }

  void handleDragUpdate(DragUpdateDetails d) {
    scuba.handleDragUpdate(d); 
  }

  void handleDragEnd(DragEndDetails d) {
    scuba.handleDragEnd(d); 
  }

}
