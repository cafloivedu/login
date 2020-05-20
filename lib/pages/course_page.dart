import 'package:flutter/material.dart';
import 'package:login/actions/courses.dart';
import 'package:login/models/course.dart';

class CourseView extends StatelessWidget {
  
  final String pageName;
  final String token;
  final int courseId;
  final String username;

  CourseView({this.pageName, this.username, this.token, this.courseId});

  Course course;

  @override
  Widget build(BuildContext context) {
    fetchCourse(username, courseId, token).then((value) => course = value);
    print(course);
    return new Scaffold(
      appBar: AppBar(
        title: Text(pageName),
      ),
      body: new Center(
        child: new Text(pageName),
      ),
    );
  }
}
