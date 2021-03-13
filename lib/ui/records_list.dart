import 'package:flutter/material.dart';
import 'package:scuba_man/ui/record.dart';


class Records extends StatefulWidget {
  final List<Record> records; 

  Records(this.records); 
  @override
  RecordsState createState() {
    return RecordsState(records); 
  } 

}

class RecordsState extends State<Records> {
  List<Record> records; 
  RecordsState(this.records); 

  Widget _buildRecordItem(BuildContext context, int index) {
    
    int position = index + 1; 
    return Card(
      color: Colors.lightBlue[300],
      child: Column(
            
            children: <Widget>[
              Row(
                children: [
                  Text("$position.",  style: TextStyle(color: Colors.blue)),
                  Text(records[index].score.toString(), style: TextStyle(color: Colors.deepPurple)),
                  Text(records[index].name, style: TextStyle(color: Colors.deepPurple)),
                ],
              )
            ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(80.0),
      child: ListView.builder(
        itemBuilder: _buildRecordItem,
        itemCount: records.length,
      ),
    );
  }
}
