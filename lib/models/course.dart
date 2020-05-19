import 'package:login/models/person.dart';

class CourseInfo {
  final int id;
  final String name;
  final String professorName;
  final int students;

  const CourseInfo({this.id, this.name, this.professorName, this.students});

  factory CourseInfo.fromJson(Map<String, dynamic> json) {
    return CourseInfo(
      id: json['id'],
      name: json['name'],
      professorName: json['professor'],
      students: json['students'],
    );
  }
}

class Course {
  final String name;
  final PersonInfo professor;
  final List<PersonInfo> students;

  const Course({this.name, this.professor, this.students});

  factory Course.fromJson(Map<String, dynamic> json) {
    final List<PersonInfo> _students = [];
    List<dynamic> studentList = json['students'];
    studentList.forEach((studentJson) {
      _students.add(PersonInfo.fromJson(studentJson));
    });

    return Course(
      name: json['name'],
      professor: PersonInfo.fromJson(json['professor']),
      students: _students,
    );
  }

  void addStudent(PersonInfo student) {
    students.add(student);
  }
}
