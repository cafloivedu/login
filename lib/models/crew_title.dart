import 'package:flutter/material.dart';
import 'package:login/pages/course_page.dart';

class CrewTitle extends StatelessWidget {
  final String name;
  final String profesor;
  final String username;
  final int courseId;
  final String token;
  final int students;
  CrewTitle({this.name, this.profesor, this.courseId, this.username, this.token, this.students});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 8.0),
      child: Card(
        margin: EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 0),
        child: InkWell(
          onTap: () => Navigator.of(context).push(new MaterialPageRoute(builder: (BuildContext context) => CourseView(pageName: name, username: username, token: token, courseId: courseId,))),
          child: ListTile(
            leading: CircleAvatar(
              radius: 25.0,
              backgroundColor: Colors.brown,
            ),
            title: Text(name),
            subtitle: Text('Profesor: $profesor, Estudiantes: $students'),
          ),
        ),
      ),
    );
  }
}
