import 'package:flutter/material.dart';

class CrewTitle extends StatelessWidget {

  final String name;
  final String profesor;
  CrewTitle({this.name, this.profesor});


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 8.0),
      child: Card(
        margin: EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 0),
        child: ListTile(
          leading: CircleAvatar(
            radius: 25.0,
            backgroundColor: Colors.brown,
          ),
          title: Text(name),
          subtitle: Text('Profesor: ${profesor}'),
        ),
      ),
    );
  }
}