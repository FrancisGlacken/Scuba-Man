// import 'package:box2d_flame/box2d.dart';
// import 'package:flame/box2d/contact_callbacks.dart';
// import 'package:scuba_man/components/enemies/shark.dart';
// import 'package:scuba_man/components/player/scuba.dart';
// import 'package:scuba_man/scuba_man_game.dart';

// class SharkCallback extends ContactCallback<Shark, Scuba> {
//   final ScubaManGame game; 
//   SharkCallback(this.game);

//   @override
//   void begin(Shark shark, Scuba scuba, Contact contact) { 

//     if (shark is Shark || scuba is Scuba) {
//       game.updateHealth(-1); 
//     }
  
//   }
//   @override
//   void end(Shark shark, Scuba scuba, Contact contact) {
//   }
// }