import 'package:flutter/material.dart';

class TitleImage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 200,
      left: 50,
      child: Image.asset(
        'assets/images/title.png', 
      // height: 80,
      // width: 200, 
      fit: BoxFit.fill,),
    );
  }
}
