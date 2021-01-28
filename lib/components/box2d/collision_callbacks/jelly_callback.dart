// import 'package:box2d_flame/box2d.dart';
// import 'package:flame/box2d/contact_callbacks.dart';
// import 'package:scuba_man/components/enemies/jellyfish.dart';
// import 'package:scuba_man/components/player/scuba.dart';
// import 'package:scuba_man/scuba_man_game.dart';

// class JellyCallback extends ContactCallback<JellyFish, Scuba> {
//   final ScubaManGame game; 
//   JellyCallback(this.game);

//   @override
//   void begin(JellyFish jelly, Scuba scuba, Contact contact) { 

//     if (jelly is JellyFish || scuba is Scuba) {
//       jelly.isDestroyed = true; 
//       game.updateHealth(-1);
//     }
  
//   }
//   @override
//   void end(JellyFish jelly, Scuba scuba, Contact contact) {
//   }
// }