import 'dart:convert';
import 'dart:io';
import 'package:login/models/person.dart';
import 'package:http/http.dart' as http;

const String baseUrl = 'movil-api.herokuapp.com';

Future<List> fetchProfessors(String dbId, String token) async {
  Uri uri = Uri.https(baseUrl, '$dbId/professors');
  final http.Response response = await http.get(
    uri,
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      HttpHeaders.authorizationHeader: "Bearer " + token,
    },
  );
  if (response.statusCode == 200) {
    List<PersonInfo> _professors = [];
    var body = json.decode(response.body);
    body.forEach((courseJson) {
      _professors.add(PersonInfo.fromJson(courseJson));
    });
    return _professors;
  } else if (response.statusCode == 401) {
    Map<String, dynamic> body = json.decode(response.body)[0];
    return Future<List>.error('Unauthorized');
  } else {
    throw Exception('Failed to login User');
  }
}

Future<Person> fetchProfessor(String dbId, int professorId, String token) async {
  Uri uri = Uri.http(baseUrl, '$dbId/professors/$professorId');
  final http.Response response = await http.get(
    uri,
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      HttpHeaders.authorizationHeader: "Bearer " + token,
    },
  );
  if (response.statusCode == 200) {
    return Person.fromJson(json.decode(response.body));
  } else if (response.statusCode == 401) {
    Map<String, dynamic> body = json.decode(response.body);
    return Future<Person>.error('Unauthorized');
  } else {
    throw Exception('Failed to login User');
  }
}

Future<List> fetchStudents(String dbId, String token) async {
  Uri uri = Uri.https(baseUrl, '$dbId/students');
  final http.Response response = await http.get(
    uri,
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      HttpHeaders.authorizationHeader: "Bearer " + token,
    },
  );
  if (response.statusCode == 200) {
    List<PersonInfo> _students = [];
    var body = json.decode(response.body);
    body.forEach((courseJson) {
      _students.add(PersonInfo.fromJson(courseJson));
    });
    return _students;
  } else if (response.statusCode == 401) {
    Map<String, dynamic> body = json.decode(response.body)[0];
    return Future<List>.error('Unauthorized');
  } else {
    throw Exception('Failed to login User');
  }
}

Future<Person> fetchStudent(String dbId, int studentId, String token) async {
  Uri uri = Uri.http(baseUrl, '$dbId/students/$studentId');
  final http.Response response = await http.get(
    uri,
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      HttpHeaders.authorizationHeader: "Bearer " + token,
    },
  );

  if (response.statusCode == 200) {
    return Person.fromJson(json.decode(response.body));
  } else if (response.statusCode == 401) {
    Map<String, dynamic> body = json.decode(response.body);
    return Future<Person>.error('Unauthorized');
  } else {
    print(response.body);
    throw Exception('Failed to login User');
  }
}

Future<PersonInfo> postStudent(String dbId, int courseId, String token) async {
  Uri uri = Uri.http(baseUrl, '$dbId/students');
  final http.Response response = await http.post(
    uri,
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      HttpHeaders.authorizationHeader: "Bearer " + token,
    },
    body: jsonEncode(<String, int>{
      'courseId': courseId,
    }),
  );
  if (response.statusCode == 200) {
    return PersonInfo.fromJson(json.decode(response.body));
  } else if (response.statusCode == 401) {
    Map<String, dynamic> body = json.decode(response.body);
    return Future<PersonInfo>.error('Unauthorized');
  } else {
    throw Exception('Failed to login User');
  }
}
