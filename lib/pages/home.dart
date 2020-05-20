import 'package:login/actions/courses.dart';
import 'package:login/models/auth.dart';
import 'package:flutter/material.dart';
import 'package:login/models/crew_title.dart';
import 'package:login/pages/course_page.dart';
import 'package:provider/provider.dart';
import 'package:login/models/course.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:login/pages/course_page.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String token;
  String email;
  String name;
  String username;
  Future<List> futureList;
  List<CourseInfo> _courses = [];
  String profilePicture = "https://api.adorable.io/avatars/285/";

  @override
  void initState() {
    super.initState();
    // load data on startup
    _readPreferences();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
          child: new ListView(children: <Widget>[
        new UserAccountsDrawerHeader(
            accountName: new Text(name),
            accountEmail: new Text(email),
            currentAccountPicture: new GestureDetector(
                onTap: () => print(name),
                child: new CircleAvatar(
                  backgroundImage: new NetworkImage(profilePicture + email),
                )),
            decoration: new BoxDecoration(
              image: new DecorationImage(
                  fit: BoxFit.fill,
                  image:
                      new NetworkImage("https://source.unsplash.com/random")),
            )),
        new ListTile(
          title: new Text("Cursos"),
          trailing: new Icon(Icons.arrow_upward),
          onTap: () {
            Navigator.of(context).pop();
          },
        ),
        new ListTile(
          title: new Text("Profesores"),
          trailing: new Icon(Icons.arrow_right),
          //llamar ventana
        ),
        new ListTile(
          title: new Text("Estudiantes"),
          trailing: new Icon(Icons.arrow_right),
          //llamar ventana
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
        itemBuilder: (context, index) => this._buildRow(index),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          futureList = fetchCourses(username, token);
          futureList.then((value) {
            setState(() {
              _courses = value;
            });
          });
          postCourse(username, token).then(
            (course) {
              addCourse(course);
              print(course.name);
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
    return CrewTitle(
      name: _courses[index].name,
      profesor: _courses[index].professorName,
      username: username,
      courseId: _courses[index].id,
      token: token,
      students: _courses[index].students,
    );
  }

  void addCourse(CourseInfo course) {
    _courses.add(course);
  }

  _readPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      token = prefs.getString('token');
    });
    setState(() {
      name = prefs.getString('name');
    });
    setState(() {
      username = prefs.getString('username');
    });
    setState(() {
      email = prefs.getString('email');
    });
    //futureList = fetchCourses(username, token);
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
