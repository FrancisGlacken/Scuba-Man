import 'package:flutter/material.dart';

class TitleImage extends StatelessWidget {
  const TitleImage({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Image.asset('assets/images/title.png'),
    ));
  }
}