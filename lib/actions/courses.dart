import 'dart:convert';
import 'dart:io';
import 'package:login/models/course.dart';
import 'package:http/http.dart' as http;

Future<List> fetchCourses(String username, String token) async {
  Uri uri = Uri.https('movil-api.herokuapp.com', '$username/courses');
  final http.Response response = await http.get(
    uri,
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      HttpHeaders.authorizationHeader: "Bearer " + token,
    },
  );
  if (response.statusCode == 200) {
    List<CourseInfo> _courses = [];
    var body = json.decode(response.body);
    body.forEach((courseJson) {
      _courses.add(CourseInfo.fromJson(courseJson));
    });
    return _courses;
  } else if (response.statusCode == 401) {
    Map<String, dynamic> body = json.decode(response.body)[0];
    return Future<List>.error('Unauthorized');
  } else {
    throw Exception('Failed to login User');
  }
}

Future<Course> fetchCourse(String username, int courseId, String token) async {
  Uri uri = Uri.http('movil-api.herokuapp.com', '$username/courses/$courseId');
  final http.Response response = await http.get(
    uri,
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      HttpHeaders.authorizationHeader: "Bearer " + token,
    },
  );
  if (response.statusCode == 200) {
    return Course.fromJson(json.decode(response.body));
  } else if (response.statusCode == 401) {
    Map<String, dynamic> body = json.decode(response.body);
    return Future<Course>.error('Unauthorized');
  } else {
    throw Exception('Failed to login User');
  }
}

Future<CourseInfo> postCourse(String username, String token) async {
  Uri uri = Uri.http('movil-api.herokuapp.com', '$username/courses');
  final http.Response response = await http.post(
    uri,
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      HttpHeaders.authorizationHeader: "Bearer " + token,
    },
  );
  if (response.statusCode == 200) {
    return CourseInfo.fromJson(json.decode(response.body));
  } else if (response.statusCode == 401) {
    Map<String, dynamic> body = json.decode(response.body);
    return Future<CourseInfo>.error('Unauthorized');
  } else {
    throw Exception('Failed to login User');
  }
}
