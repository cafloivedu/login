import 'package:flutter/material.dart';

class UserDetails extends StatefulWidget {

  final int courseId;
  final String name;
  final String username;
  final String email;
  final String phone;
  final String city;
  final String country;
  final String birth;

  const UserDetails({this.courseId,this.name,this.username,this.email,this.phone,this.city,this.country,this.birth});

  @override
  _UserDetailsState createState() => _UserDetailsState();
}

class _UserDetailsState extends State<UserDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.name),
      ),
      body: Padding(
        padding: EdgeInsets.only(top: 8.0),
        child: Card(
          margin: EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 0),
          child: ListTile(
            leading: CircleAvatar(
              radius: 25.0,
              backgroundImage: NetworkImage("https://api.adorable.io/avatars/285/"+widget.username),
            ),
            title: Text(''),
            subtitle: Text('Last Name: '),
          ),
        ),
      ),
    );
  }
}