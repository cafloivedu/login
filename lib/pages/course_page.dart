import 'package:flutter/material.dart';

class CourseView extends StatelessWidget {
  
  final String pageName;

  CourseView(this.pageName);

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
