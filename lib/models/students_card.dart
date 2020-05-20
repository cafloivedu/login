import 'package:flutter/material.dart';

class StudentsCard extends StatelessWidget {

  final String name;
  final String email;
  final String username;
  StudentsCard({this.name, this.email,this.username});


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 8.0),
      child: InkWell(
        onTap: ,
      child: Card(
        margin: EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 0),
        child: ListTile(
          leading: CircleAvatar(
            radius: 25.0,
            backgroundImage: NetworkImage("https://api.adorable.io/avatars/285/"+username),
          ),
          title: Text(name),
          subtitle: Text('Email: $email'),
        ),
      ),
    ),
    );
  }
}