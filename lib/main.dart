import 'dart:ui';
//import 'package:hive/hive.dart';
//import 'package:path_provider/path_provider.dart' as path_provider;
import 'package:flame/game.dart';
import 'package:flutter/services.dart';
import 'package:scuba_man/scuba_game.dart';
import 'package:flutter/material.dart';
import 'package:scuba_man/ui/health_widget.dart';
import 'package:scuba_man/ui/high_score.dart';
import 'package:scuba_man/ui/record.dart';
import 'package:scuba_man/ui/records_image.dart';
import 'package:scuba_man/ui/records_list.dart';
import 'package:scuba_man/ui/start_image.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  //final appDocumentsDirectory = await path_provider.getApplicationDocumentsDirectory();
  // Hive.init(appDocumentsDirectory.path);
  // //await Hive.openBox("scuba_box");

  await SystemChrome.setEnabledSystemUIOverlays([]);
  await SystemChrome.setPreferredOrientations(
    <DeviceOrientation>[DeviceOrientation.portraitUp],
  );
  runApp(ScubaManApp());
}

class ScubaManApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final healthBarState = new HealthBarState();
  final scoreState = new HighScoreState();
  var records = new List<Record>(); 
  ScubaGame _myGame;

  Widget titleImageBuilder(BuildContext context, ScubaGame game) {
    return Positioned(
      top: 200,
      left: 50,
      child: Image.asset(
        'assets/images/title.png',
        // height: 80,
        // width: 200,
        fit: BoxFit.fill,
      ),
    );
  }

  Widget startButtonBuilder(BuildContext context, ScubaGame game) {
    return Positioned(
      left: 150,
      top: 380,
      child: GestureDetector(
        onTapUp: (TapUpDetails details) {
          game.startGame();
        },
        child: StartImage(),
      ),
    );
  }

  Widget recordButtonBuilder(BuildContext context, ScubaGame game) {
    return Positioned(
      left: 150,
      top: 480,
      child: GestureDetector(
        onTapUp: (TapUpDetails details) {
          game.toLeaderBoard();
        },
        child: RecordsImage(),
      ),
    );
  }

  Widget healthBarBuilder(BuildContext context, ScubaGame game) {
    return HealthBar(healthBarState);
  }

  Widget highScoreBuilder(BuildContext context, ScubaGame game) {
    return HighScore(scoreState);
  }

  Widget quitButtonBuilder(BuildContext context, ScubaGame game) {
    return Positioned(
      left: 20,
      top: 20,
      child: GestureDetector(
          onTapDown: (TapDownDetails details) {
            game.toTitle();
          },
          child: Image.asset('assets/images/quit_game.png')),
    );
  }

  Widget leaderBoardBuilder(BuildContext buildContext) {

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
    return Records(records); 
  }

  @override
  Widget build(BuildContext context) {
    _myGame = ScubaGame(healthBarState, scoreState);
    return Scaffold(
      body: _myGame == null
          ? const Text('Wait')
          : GameWidget<ScubaGame>(
              game: _myGame,
              overlayBuilderMap: {
                'title_image': titleImageBuilder,
                'start_button': startButtonBuilder,
                'record_button': recordButtonBuilder,
                'health_bar': healthBarBuilder,
                'score': highScoreBuilder,
                'quit_button': quitButtonBuilder
              },
              initialActiveOverlays: const [
                'title_image',
                'start_button',
                'record_button'
              ],
            ),
    );
  }

  // void newGame() {
  //   setState(() {
  //     _myGame = ScubaGame();
  //     print('New game created');
  //   });
  // }
}
