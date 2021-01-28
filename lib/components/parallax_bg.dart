import 'package:flame/components/parallax_component.dart';
import 'package:flame/extensions/vector2.dart';
import 'package:flutter/material.dart';

class ParallaxBg extends ParallaxComponent {
  ParallaxBg(List<ParallaxImage> images) : super(images) {
    baseSpeed = Vector2(20, 0); 
    layerDelta = Vector2(0, 0); 
  }
}