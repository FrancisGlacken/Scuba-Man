// import 'package:box2d_flame/box2d.dart';
// import 'package:flame/box2d/contact_callbacks.dart';
// import 'package:scuba_man/components/interactables/shell.dart';
// import 'package:scuba_man/components/player/scuba.dart';
// import 'package:scuba_man/scuba_man_game.dart';

// class ShellCallback extends ContactCallback<Shell, Scuba> {
//   final ScubaManGame game; 
//   ShellCallback(this.game);

//   @override
//   void begin(Shell shell, Scuba scuba, Contact contact) { 

//     if (shell is Shell || scuba is Scuba) {
//       shell.isDestroyed = true; 
//       game.updateScore(2);
//     }
  
//   }
//   @override
//   void end(Shell shell, Scuba scuba, Contact contact) {
//   }
// }