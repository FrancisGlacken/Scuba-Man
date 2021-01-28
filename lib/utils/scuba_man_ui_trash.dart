// import 'package:flutter/material.dart';
// import 'package:scuba_man/components/interactables/fishy_spawner.dart';
// import 'package:scuba_man/components/interactables/shell_spawner.dart';
// import 'package:scuba_man/scuba_man_game.dart';
// import 'ui_screens.dart';
// import 'package:scuba_man/ui/high_score.dart';
// import 'package:scuba_man/ui/title_image.dart';
// import 'package:scuba_man/ui/start_button.dart';
// import 'package:scuba_man/ui/quit_button.dart';
// import 'package:scuba_man/ui/health_widget.dart';

// class ScubaManUI extends StatefulWidget {
//   final ScubaManUIState state = ScubaManUIState();
//   State<StatefulWidget> createState() => state;
// }

// class ScubaManUIState extends State<ScubaManUI> with WidgetsBindingObserver {
//   ScubaManGame game;
//   UIScreen currentScreen = UIScreen.title;
//   int score = 0;
//   int health = 3;
//   FishySpawner fishySpawner; 
//   ShellSpawner shellSpawner; 

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: <Widget>[
//         Expanded(
//             child: IndexedStack(
//           sizing: StackFit.expand,
//           children: <Widget>[titleScreen(), gameScreen()],
//           index: currentScreen.index,
//         )),
//       ],
//     );
//   }

//   Widget titleScreen() {
//     return Positioned.fill(
//       child: Stack(children: <Widget>[
//         Column(
//           children: <Widget>[
//             TitleImage(),
//             StartButton(this),
//           ],
//         ),
//       ]),
//     );
//   }

//   Widget gameScreen() {
//     return Positioned.fill(
//       child: Stack(children: <Widget>[
//         HealthBar(returnHealthImageKey(health)),
//         HighScore(score),
//         QuitButton(this),
//       ]),
//     );
//   }

//   void toGameScreen() {
//     setState(() {
//       game.playGameBGM();
//       currentScreen = UIScreen.game;
//       // game.add(JellyfishSpawner());
//       // game.add(SharkSpawner());
//       // game.add(ShellSpawner());
//       game.add(fishySpawner = FishySpawner());
//       //game.add(shellSpawner = ShellSpawner()); 
//       spawnScuba(); 
//       //game.world.spawnFishy(); 
//     });
//     //spawnScuba(); 
//   }

//   void toTitleScreen() {
//     setState(() {
//       game.playHomeBGM();
//       score = 0;
//       health = 3;
//       game.components.remove(fishySpawner); 
//       //game.components.clear();
//       //game.add(Ocean());

//       currentScreen = UIScreen.title;
//       despawnScuba();
//       game.despawnFishies(); 
//     }); 
//   }

//   void updateScoreForShell() {
//     setState(() {
//       score += 1;
//     });
//   }

//   void updateScoreForFishy() {
//     setState(() {
//       score += 2;
//     });
//   }

//   void updateHealthForDamage() {
//     setState(() {
//       health--;
//     });
//   }

//   String returnHealthImageKey(int health) {
//     String image;
//     switch (health) {
//       case 0:
//         image = 'assets/images/health_bar_0.png';
//         break;
//       case 1:
//         image = 'assets/images/health_bar_1.png';
//         break;
//       case 2:
//         image = 'assets/images/health_bar_2.png';
//         break;
//       case 3:
//         image = 'assets/images/health_bar_3.png';
//         break;
//       default:
//     }
//     return image;
//   }


//   void spawnScuba() { 
//     game.spawnScuba(); 
//   }

//   void despawnScuba() {
//     game.despawnScuba(); 
//   }
// }
