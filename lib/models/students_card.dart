import 'package:flutter/material.dart';
import 'package:login/actions/person.dart';
import 'package:login/pages/details.dart';

class StudentsCard extends StatelessWidget {

  final String name;
  final String email;
  final String username;
  final String dbId;
  final int id;
  final String token;
  StudentsCard({this.name, this.email,this.username, this.id,this.token, this.dbId});


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 8.0),
      child: InkWell(
        onTap: () async{
          await fetchStudent(dbId, id, token).then((value) => {
                  Navigator.of(context).push(new MaterialPageRoute(
                    builder: (BuildContext context) => UserDetails(
                      courseId: value.courseId, name: value.name, username: value.username, email: value.email, phone: value.phone, city: value.city, country: value.country, birth: value.birthday
                    )))
                });
        },
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