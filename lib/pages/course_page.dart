import 'package:flutter/material.dart';
import 'package:login/actions/courses.dart';
import 'package:login/models/course.dart';

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
    } );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        title: Text(course.name),
      ),
      body: new Center(
        child: new Text(course.professor.name),
      ),
    );
  }
}