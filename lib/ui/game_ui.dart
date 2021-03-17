import 'package:flutter/material.dart';
import 'package:scuba_man/scuba_game.dart';
import 'package:scuba_man/ui/record.dart';
import 'package:scuba_man/ui/records_button.dart';
import 'package:scuba_man/ui/records_list.dart';
import 'package:scuba_man/utils/ui_screens.dart';
import 'package:scuba_man/ui/high_score.dart';
import 'package:scuba_man/ui/title_image.dart';
import 'package:scuba_man/ui/start_button.dart';
import 'package:scuba_man/ui/quit_button.dart';
import 'package:scuba_man/ui/health_widget.dart';

class GameUI extends StatefulWidget {
  final GameUIState state = GameUIState();
  @override
  State<StatefulWidget> createState() => state;
}

class GameUIState extends State<GameUI> with WidgetsBindingObserver {
  ScubaGame game;
  HighScoreState scoreState = HighScoreState(); 
  HealthBarState healthState = HealthBarState(); 
  UIScreen currentScreen = UIScreen.title;
  int score = 0;
  int health = 3;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
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
          children: <Widget>[
            _titleScreen(game),
            _gameScreen(game),
            _recordsScreen(game)
          ],
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
            StartButton(game),
          ],
        ),
      ]),
    );
  }

  

  Widget _titleScreen(ScubaGame game) {
    return Center(
        child: Stack(
      children: [
        TitleImage(),
        StartButton(game),
        RecordsButton(game),
      ],
    ));
  }

  Widget _gameScreen(ScubaGame game) {
    return Center(
      child: Stack(
        children: [HealthBar(healthState), HighScore(scoreState), QuitButton(game)],
      ),
    );
  }

  // Widget _recordEntryScreen(BuildContext buildContext, ScubaGame game) {
  //   return Center(child: Stack(children: [QuitButton(game), RecordForm(game)]));
  // }

  Widget _recordsScreen(ScubaGame game) {
    List<Record> records = [];
    records.addAll([
      Record(50, "FRN"),
      Record(45, "FRN"),
      Record(40, "NAR"),
      Record(35, "ALY"),
      Record(30, "AMT"),
      Record(25, "FMG"),
      Record(20, "JMG"),
      Record(15, "JPG"),
      Record(10, "JHG"),
      Record(5, "ASS")
    ]);
    return Center(
        child: Stack(
      children: [Records(records), QuitButton(game)],
    ));
  }

  void toGameScreen() {
    setState(() {
      currentScreen = UIScreen.game;
    });
  }

  void toRecordsScreen() {
    setState(() {
      currentScreen = UIScreen.scoreboard;
    });
  }

  void toTitleScreen() {
    setState(() {
      currentScreen = UIScreen.title;
    });
  }

  void updateScore(int points) {
    scoreState.updateScore(points); 
  }

  void resetScore() {
    scoreState.resetScore();
  }

  void damageHealth() {
    healthState.damageHealth(); 
  }

  void resetHealth() {
    healthState.resetHealth(); 
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
}
