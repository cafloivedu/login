import 'package:flutter/material.dart';
import 'package:login/actions/courses.dart';
import 'package:login/models/course.dart';
import 'package:login/models/students_card.dart';

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
        children:<Widget>[ 
        Padding(
          padding: EdgeInsets.all(16.0),
          child: Title(color: Colors.blueAccent, 
          child: Center(
            child: Text('Profesores',
              style: new TextStyle(fontSize: 25),
            ),
          ), ),
        ),
        new Card(
          margin: EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 0),
          child: InkWell(
            //onTap: () => Navigator.of(context).push(new MaterialPageRoute(builder: (BuildContext context) => CourseView(pageName: name, username: username, token: token, courseId: courseId,))),
            child: ListTile(
              leading: CircleAvatar(
                radius: 25.0,
                backgroundColor: Colors.brown,
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
              style: new TextStyle(
                fontSize: 25
              ),
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
    return StudentsCard(name: course.students[index].name);
  }

}

