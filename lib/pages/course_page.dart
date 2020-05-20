import 'package:flutter/material.dart';
import 'package:login/actions/courses.dart';
import 'package:login/actions/person.dart';
import 'package:login/models/course.dart';
import 'package:login/models/person.dart';
import 'package:login/models/students_card.dart';
import 'package:login/pages/details.dart';

class CourseView extends StatefulWidget {
  final String pageName;
  final String token;
  final int courseId;
  final String username;

  const CourseView({this.pageName, this.token, this.courseId, this.username});
  @override
  _CourseViewState createState() => _CourseViewState();
}

class _CourseViewState extends State<CourseView> {
  Course course;
  Person user;

  @override
  void initState() {
    fetchCourse(widget.username, widget.courseId, widget.token).then((value) {
      setState(() {
        course = value;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        title: Text(course.name),
      ),
      body: new ListView(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(16.0),
            child: Title(
              color: Colors.blueAccent,
              child: Center(
                child: Text(
                  'Profesores',
                  style: new TextStyle(fontSize: 25),
                ),
              ),
            ),
          ),
          new Card(
            margin: EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 0),
            child: InkWell(
              onTap: () async {
                await fetchProfessor(widget.username, course.professor.id, widget.token).then((value) => {
                  Navigator.of(context).push(new MaterialPageRoute(
                    builder: (BuildContext context) => UserDetails(
                      courseId: value.courseId, name: value.name, username: value.username, email: value.email, phone: value.phone, city: value.city, country: value.country, birth: value.birthday
                    )))
                });  
                  
              },
              child: ListTile(
                leading: CircleAvatar(
                  radius: 25.0,
                  backgroundImage: NetworkImage(
                      "https://api.adorable.io/avatars/285/${course.professor.username}"),
                ),
                title: Text(course.professor.name),
                subtitle: Text('Email: ${course.professor.email}'),
              ),
            ), //new Text(course.professor.name),
          ),
          Padding(
            padding: EdgeInsets.all(20.0),
            child: Title(
              color: Colors.black,
              child: Text(
                'Estudiantes',
                textAlign: TextAlign.center,
                style: new TextStyle(fontSize: 25),
              ),
            ),
          ),
          Container(
            height: 500,
            color: Colors.white,
            child: new ListView.builder(
              itemCount: course.students.length,
              itemBuilder: (context, index) => this._buildRow(index),
            ),
          ),
        ],
      ),
    );
  }

  _buildRow(int index) {
    return StudentsCard(
      name: course.students[index].name,
      email: course.students[index].email,
      username: course.students[index].username,
      id: course.students[index].id,
      token: widget.token,
      dbId: widget.username,
    );
  }
}
