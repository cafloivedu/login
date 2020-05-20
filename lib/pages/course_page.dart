import 'package:flutter/material.dart';

class CourseView extends StatelessWidget {
  
  final String pageName;
  final String token;
  final String courseId;
  final String username;

  CourseView({this.pageName, this.username, this.token, this.courseId});

  @override
  Widget build(BuildContext context) {
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
