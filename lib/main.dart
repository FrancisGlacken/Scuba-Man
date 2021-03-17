//import 'package:hive/hive.dart';
//import 'package:path_provider/path_provider.dart' as path_provider;
import 'package:flame/game.dart';
import 'package:flutter/services.dart';
import 'package:scuba_man/scuba_game.dart';
import 'package:flutter/material.dart';

import 'ui/game_ui.dart';

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
  final GameUI _myGameUI = GameUI();
  ScubaGame _myGame;

  @override
  Widget build(BuildContext context) {
    _myGame = ScubaGame(_myGameUI.state);
    _myGameUI.state.game = _myGame;
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Positioned.fill(
            child: _myGame == null
                ? const Text('Wait')
                : GameWidget<ScubaGame>(
                    game: _myGame,
                  ),
          ),
          Positioned.fill(child: _myGameUI)
        ],
      ),
    );
  }
}




//void myTapCallback() {
  //   setState(() {
  //     _myGame.score = _myGame.score + 1;
  //     print('New game created');
  //   });
  // }

  