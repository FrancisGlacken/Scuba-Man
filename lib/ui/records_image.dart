import 'package:flutter/material.dart';

class RecordsImage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Image.asset('assets/images/records.png'),
      ),
    );
  }
}