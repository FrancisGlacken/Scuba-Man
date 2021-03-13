import 'package:flutter/material.dart';
import 'package:scuba_man/scuba_game.dart';

class RecordForm extends StatefulWidget {
  final ScubaGame game; 
   
  RecordForm(this.game);

  @override
  State<StatefulWidget> createState() {
    return RecordFormState(game);
  }
}

class RecordFormState extends State<RecordForm> {
  String _name;
  final ScubaGame game; 

  RecordFormState(this.game); 

  Widget _buildNameEntry() {
    return TextFormField(
      decoration: InputDecoration(labelText: 'Name'),
      keyboardType: TextInputType.visiblePassword,
      validator: (String value) {
        if (value.isEmpty) {
          return 'Enter your name!';
        }

        return null;
      },
      onSaved: (String value) {
        _name = value;
      },
    );
  }

  Widget _buildEntryButton() {
    return TextButton(
      child: Image.asset('assets/images/sand.png'),
      onPressed: () {
        print(_name);
      },
    );
  }

  Widget _buildScore() {
    return Text(
            game.score.toString(),
            style: TextStyle(
                fontSize: 24,
                color: Colors.green[300]),
          );
  }

  //Widget _buildExitButton() { return null;}
  //Widget _buildHighScore() {  return null;}

  
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
          width: 200,
          height: 200,
          padding: EdgeInsets.all(20),
          color: Colors.green[400],
          child: Form(
              child: Column(
            children: [
              _buildScore(),
              _buildNameEntry(),
              _buildEntryButton()
            ],
          ))),
    );
  }
}
