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
  //   'assets/images/bg_ocean.png',
  //   'assets/images/health_bar_0.png',
  //   'assets/images/health_bar_1.png',
  //   'assets/images/health_bar_2.png',
  //   'assets/images/health_bar_3.png',
  //   'assets/images/quit_game.png',
  //   'assets/images/sprite_scuba_man.png',
  //   'assets/images/sprite_sheet_bubble.png',
  //   'assets/images/sprite_sheet_fishy.png',
  //   'assets/images/sprite_sheet_jellyfish.png',
  //   'assets/images/sprite_sheet_shell.png',
  //   'assets/images/sprite_shark.png',
  //   'assets/images/start_game.png',
  //   'assets/images/sprite_sheet_shell.png',
  //   'assets/images/swim_up.png',
  //   'assets/images/swim_left.png',
  //   'assets/images/swim_right.png',
  //   'assets/images/title.png',
  // ]);

  Flame.audio.disableLog();
  await Flame.audio
      .loadAll(<String>['bgm/ecco_title_gg.mp3', 'bgm/password_mmx.mp3']);

  ScubaManUI gameUI = ScubaManUI();
  ScubaManGame game = ScubaManGame(size, gameUI.state);
  gameUI.state.game = game;
  // runApp(game.widget);

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
