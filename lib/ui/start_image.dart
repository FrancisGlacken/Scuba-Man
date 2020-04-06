import 'package:flutter/material.dart';

class StartImage extends StatelessWidget {
  const StartImage({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Image.asset(
          'assets/images/start_game.png',
        ),
      ),
    );
  }
}