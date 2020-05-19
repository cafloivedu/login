import 'dart:collection';
import 'package:login/models/course.dart';
import 'package:login/models/person.dart';
import 'package:flutter/material.dart';

class ListProvider extends ChangeNotifier {
  int _listView = 0;
  String title = "Cursos";
  bool _showFAB = true;
  List<PersonInfo> _professors = [];
  List<PersonInfo> _students = [];
  List<CourseInfo> _courses = [];

  UnmodifiableListView<PersonInfo> get professors =>
      UnmodifiableListView(_professors);
  UnmodifiableListView<PersonInfo> get students =>
      UnmodifiableListView(_students);
  UnmodifiableListView<CourseInfo> get courses =>
      UnmodifiableListView(_courses);
  int get view => _listView;
  bool get isVisible => _showFAB;

  void changeList(List list) {
    switch (_listView) {
      case 1:
        _professors = list;
        title = "Profesores";
        break;
      case 2:
        _students = list;
        title = "Estudiantes";
        break;
      default:
        _courses = list;
        title = "Cursos";
        break;
    }
  }

  set view(int index) {
    _listView = index;
    switch (index) {
      case 1:
        title = "Profesores";
        _showFAB = false;
        break;
      case 2:
        title = "Estudiantes";
        _showFAB = false;
        break;
      default:
        title = "Cursos";
        _showFAB = true;
        break;
    }
  }

  void addCourse(CourseInfo course) {
    _courses.add(course);
    notifyListeners();
  }

  void addStudent(PersonInfo student) {
    _students.add(student);
    notifyListeners();
  }
}
