// import 'package:box2d_flame/box2d.dart';
// import 'package:flame/box2d/contact_callbacks.dart';
// import 'package:scuba_man/components/box2d/border_wall.dart';
// import 'package:scuba_man/components/interactables/fishy.dart';
// import 'package:scuba_man/components/player/scuba.dart';
// import 'package:scuba_man/scuba_man_game.dart';

// class FishyCallback extends ContactCallback<Fishy, Scuba> {
//   final ScubaManGame game; 
//   FishyCallback(this.game);

//   @override
//   void begin(Fishy fishy, Scuba scuba, Contact contact) { 

//     if (fishy is Fishy || scuba is Scuba) {
//       fishy.isDestroyed = true; 
//       game.updateScore(1);
//     }
  
//   }
//   @override
//   void end(Fishy a, Scuba b, Contact contact) {
//   }

// }

// class FishyToWallCallback extends ContactCallback<Fishy, BorderBody> {
//   final ScubaManGame game; 
//   FishyToWallCallback(this.game);

//   @override
//   void begin(Fishy fishy, BorderBody border, Contact contact) { 

//     // if (fishy is Fishy || border is BorderBody) {
//     //   return true; 
//     // }
  
//   }
//   @override
//   void end(Fishy a, BorderBody b, Contact contact) {
//   }

// }