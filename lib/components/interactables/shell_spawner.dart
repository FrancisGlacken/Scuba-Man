// import 'package:flame/components/component.dart';
// import 'package:flame/components/mixins/has_game_ref.dart';
// import 'package:flame/timer.dart';
// import 'package:scuba_man/components/interactables/shell.dart';
// import 'package:scuba_man/main.dart';

// import 'dart:ui';
// import 'dart:math';

// class ShellSpawner extends Component with HasGameRef<ScubaManGame> {
//   Timer timer;
//   Random rng = Random();
//   bool isDestroyed = false; 

//   ShellSpawner() {
//     timer = Timer(10, repeat: true, callback: () {
//       gameRef.addShell(Shell(gameRef.box, 
//       rng.nextInt(gameRef.size.width.toInt()).toDouble() - gameRef.size.width/2,
//           gameRef.size.height/2));
//     });
//     timer.start();
//   }

//   @override
//   void update(double t) {
//     timer.update(t);
//   }

//   @override
//   void render(Canvas c) {}

//   @override
//   bool destroy() {
//     return isDestroyed;
//   }

//   void destroyed() {
//     timer.stop(); 
//     isDestroyed = true; 
//   }
// }
