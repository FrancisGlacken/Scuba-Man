//import 'package:hive/hive.dart';
//import 'package:path_provider/path_provider.dart' as path_provider;
import 'package:flame/game.dart';
import 'package:flutter/services.dart';
import 'package:scuba_man/scuba_game.dart';
import 'package:flutter/material.dart';
import 'package:scuba_man/ui/health_widget.dart';
import 'package:scuba_man/ui/high_score.dart';
import 'package:scuba_man/ui/quit_button.dart';
import 'package:scuba_man/ui/record.dart';
import 'package:scuba_man/ui/record_form.dart';
import 'package:scuba_man/ui/records_button.dart';
import 'package:scuba_man/ui/records_list.dart';
import 'package:scuba_man/ui/start_button.dart';
import 'package:scuba_man/ui/title_image.dart';
import 'package:scuba_man/utils/globals.dart' as globals;


void main() async {
  WidgetsFlutterBinding.ensureInitialized();

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
  ScubaGame _myGame;
  final HighScoreState highScoreState = new HighScoreState(); 

  Widget _buildTitleScreen(BuildContext context, ScubaGame game) {
    return Center(
        child: Stack(
      children: [
        TitleImage(),
        StartButton(game),
        RecordsButton(game),
      ],
    ));
  }

  Widget _buildGameScreen(BuildContext context, ScubaGame game) {
    return Center(
      child: Stack(
        children: [HealthBar(), HighScore(highScoreState), QuitButton(game)],
      ),
    );
  }

  Widget _buildRecordEntryScreen(BuildContext buildContext, ScubaGame game) {
    return Center(child: Stack(children: [QuitButton(game), RecordForm(game)]));
  }

  Widget _buildRecordsScreen(BuildContext buildContext, ScubaGame game) {
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

  @override
  Widget build(BuildContext context) {
    _myGame = ScubaGame(myTapCallback);
    return Scaffold(
      body: _myGame == null
          ? const Text('Wait')
          : GameWidget<ScubaGame>(
              game: _myGame,
              overlayBuilderMap: {
                'title_screen': _buildTitleScreen,
                'game_screen': _buildGameScreen,
                'records_screen': _buildRecordsScreen,
                'record_entry_screen': _buildRecordEntryScreen,
              },
              initialActiveOverlays: const ['title_screen'],
            ),
    );
  }


  void myTapCallback() {
    setState(() {
      _myGame.score = _myGame.score + 1;
      print('New game created');
    });
  }
}
