import 'dart:math';

import 'package:login/actions/courses.dart';
import 'package:login/models/auth.dart';
import 'package:flutter/material.dart';
import 'package:login/models/user_info.dart';
import 'package:provider/provider.dart';
import 'package:login/models/course.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String token;
  String email;
  Future<List> futureList;
  List<CourseInfo> _courses = [];
  String profilePicture = "https://api.adorable.io/avatars/285/${Random()}";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: new Drawer(
          child: new ListView(children: <Widget>[
        new UserAccountsDrawerHeader(
            accountName: new Text("John Doe"),
            accountEmail: new Text("random@example.com"),
            currentAccountPicture: new GestureDetector(
                onTap: () => print(" selected user info "),
                child: new CircleAvatar(
                  backgroundImage: new NetworkImage(profilePicture),
                )),
            decoration: new BoxDecoration(
              image: new DecorationImage(
                  fit: BoxFit.fill,
                  image: new NetworkImage(
                      "https://img00.deviantart.net/35f0/i/2015/018/2/6/low_poly_landscape__the_river_cut_by_bv_designs-d8eib00.jpg")),
            )),
        new ListTile(
          title: new Text("First Page"),
          trailing: new Icon(Icons.arrow_upward),
        ),
        new ListTile(
          title: new Text("Second Page"),
          trailing: new Icon(Icons.arrow_right),
        ),
        new Divider(),
        new ListTile(
          title: new Text("Cerrar Sesión"),
          onTap: () async {
            Navigator.of(context).pop();
            await Provider.of<Auth>(context).logout();
          },
          trailing: new Icon(Icons.cancel),
        )
      ])),
      appBar: AppBar(
        title: Text("Cursos"),
      ),
      body: ListView.builder(
          itemCount: this._courses.length,
          itemBuilder: (context, index) => this._buildRow(index)),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          postCourse(UserInfo().username, UserInfo().token).then(
            (course) {
              addCourse(course);
              print("intento");
            },
          ).catchError(
            (error) {
              if (error.toString() == 'Unauthorized') {
                _unauthorizedProtocol();
              }
            },
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }

  _buildRow(int index) {
    return Text("Item " + index.toString());
  }

  void addCourse(CourseInfo course) {
    _courses.add(course);
  }

  _readPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token') ?? "none";
    // Check token
    Provider.of<Auth>(context).checkToken(token)
        // if it's valid, load data
        .then((isValid) {
      if (isValid) {
        String name = prefs.getString('name');
        String username = prefs.getString('username');
        String email = prefs.getString('email');

        futureList = fetchCourses(username, token);
      } else {}
    });
  }

  _removePreferences() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove('token');
    prefs.remove('name');
    prefs.remove('username');
    prefs.remove('email');
  }

  _unauthorizedProtocol() {
    Navigator.of(context).maybePop();
    futureList = null;
    _removePreferences();
  }
}
