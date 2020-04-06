import 'package:flutter/material.dart';
import 'package:scuba_man/components/background-ocean.dart';
import 'package:scuba_man/components/enemies/jellyfish_spawner.dart';
import 'package:scuba_man/components/enemies/shark_spawner.dart';
import 'package:scuba_man/components/interactables/fishy_spawner.dart';
import 'package:scuba_man/components/interactables/shell_spawner.dart';
import 'package:scuba_man/scuba_man_game.dart';
import 'package:scuba_man/ui/swim_up.dart';
import 'ui_screens.dart';
import 'package:scuba_man/ui/high_score.dart';
import 'package:scuba_man/ui/title_image.dart';
import 'package:scuba_man/ui/start_button.dart';
import 'package:scuba_man/ui/quit_button.dart';
import 'package:scuba_man/ui/health_widget.dart';

class ScubaManUI extends StatefulWidget {
  final ScubaManUIState state = ScubaManUIState();
  State<StatefulWidget> createState() => state;
}

class ScubaManUIState extends State<ScubaManUI> with WidgetsBindingObserver {
  ScubaManGame game;
  UIScreen currentScreen = UIScreen.title;
  int score = 0;
  int health = 3;

  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Expanded(
            child: IndexedStack(
          sizing: StackFit.expand,
          children: <Widget>[titleScreen(), gameScreen()],
          index: currentScreen.index,
        )),
      ],
    );
  }

  Widget titleScreen() {
    return Positioned.fill(
      child: Stack(children: <Widget>[
        Column(
          children: <Widget>[
            TitleImage(),
            StartButton(this),
          ],
        ),
      ]),
    );
  }

  Widget gameScreen() {
    return Positioned.fill(
      child: Stack(children: <Widget>[
        HealthBar(returnHealthImageKey(health)),
        HighScore(score),
        QuitButton(this),
        SwimUp(this)
      ]),
    );
  }

  void toGameScreen() {
    setState(() {
      game.playGameBGM();
      game.add(JellyfishSpawner());
      game.add(SharkSpawner());
      game.add(FishySpawner());
      game.add(ShellSpawner());
      currentScreen = UIScreen.game;
      spawnScuba(); 
    });
    //spawnScuba(); 
  }

  void toTitleScreen() {
    setState(() {
      game.playHomeBGM();
      score = 0;
      health = 3;
      game.components.clear();
      game.add(Ocean());

      currentScreen = UIScreen.title;
      despawnScuba();
    });
    //despawnScuba(); 
  }

  void updateScoreForShell() {
    setState(() {
      score += 1;
    });
  }

  void updateScoreForFishy() {
    setState(() {
      score += 2;
    });
  }

  void updateHealthForDamage() {
    setState(() {
      health--;
    });
  }

  String returnHealthImageKey(int health) {
    String image;
    switch (health) {
      case 0:
        image = 'assets/images/health_bar_0.png';
        break;
      case 1:
        image = 'assets/images/health_bar_1.png';
        break;
      case 2:
        image = 'assets/images/health_bar_2.png';
        break;
      case 3:
        image = 'assets/images/health_bar_3.png';
        break;
      default:
    }
    return image;
  }


  void spawnScuba() { 
    game.world.spawnScuba(); 
  }

  void despawnScuba() {
    game.world.despawnScuba(); 
  }
}
