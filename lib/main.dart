import 'package:flutter/material.dart';
import 'package:flame/flame.dart';
import 'package:scuba_man/scuba_man_game.dart';
import 'package:flame/util.dart';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';

import 'package:path_provider/path_provider.dart' as path_provider;
import 'package:scuba_man/scuba_man_ui.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final appDocumentsDirectory =
      await path_provider.getApplicationDocumentsDirectory();
  Hive.init(appDocumentsDirectory.path);
  //await Hive.openBox("scuba_box");

  // Create util for fullscreen and set orientation
  Util flameUtil = Util();
  await flameUtil.fullScreen();
  await flameUtil.setOrientation(DeviceOrientation.portraitUp);
  final size = await Flame.util.initialDimensions();

  // await Flame.images.loadAll(<String>[
  //   'assets/images/bg_ocean.png'
  // ]);
  ScubaManUI gameUI = ScubaManUI();
  ScubaManGame game = ScubaManGame(size, gameUI.state);
  gameUI.state.game = game;
  runApp(game.widget);

  runApp(MaterialApp(
    title: 'Scuba Man',
    theme: ThemeData(
      primarySwatch: Colors.orange,
      fontFamily: 'HVD',
    ),
    home: Scaffold(
      resizeToAvoidBottomPadding: false,
        body: Stack(
      fit: StackFit.expand,
      children: <Widget>[
        Positioned.fill(
          child: GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTapDown: game.onTapDown,
            child: game.widget,
          ),
        ),
        Positioned.fill(child: gameUI)
      ],
    )),
    debugShowCheckedModeBanner: false,
  ));
}
