import 'dart:async';
import 'package:flutter/material.dart';
import 'package:login/models/user_info.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class Auth with ChangeNotifier {
  UserInfo userInfo;
  var currentUser;
  var createdEmail;
  var createdPass;

  Auth() {
    currentUser = null;
    createdEmail = null;
    createdPass = null;
  }

  void load(name, token) {
    userInfo = UserInfo.partialLoad(token, name);
    notifyListeners();
  }

  void manageJson(UserInfo classInfo, String pass) {
    userInfo = classInfo;
    saveLoginStatus(true);
    saveToken(userInfo.token);
    saveEmail(userInfo.email);
    savePass(pass);
    notifyListeners();
  }

  Future getUser() {
    return Future.value(currentUser);
  }

  
  Future logout() {
    this.currentUser = null;
    notifyListeners();
    saveLoginStatus(false);
    return Future.value(currentUser);
  }

  
  Future createUser(
      {String email, String password, String username, String name}) async {
    createdEmail = email;
    createdPass = password;
    signUpRequest(
        email: email, password: password, username: username, name: name);
    return Future.value(1);
  }

  // logs in the user if password matches
  Future loginUser({String email, String password}) {
    if (createdEmail == null) {
      this.currentUser = null;
      return Future.value(null);
    }
    if (createdEmail == email && createdPass == password) {
      this.currentUser = {'email': email};
      notifyListeners();
      return Future.value(currentUser);
    } else {
      this.currentUser = null;
      return Future.value(null);
    }
  }

  Future loginUser2({String email}) {
    this.currentUser = {'email': email};
    notifyListeners();
    
    return Future.value(currentUser);
  }

  Future<UserInfo> signUpRequest(
      {String email, String password, String username, String name}) async {
    final http.Response response = await http.post(
      'https://movil-api.herokuapp.com/signup',
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'email': email,
        'password': password,
        'username': username,
        'name': name
      }),
    );

    print('${response.body}');
    print('${response.statusCode}');
    if (response.statusCode == 200) {
      print("signup successful");
      return userInfo;
    } else {
      print("signup failed");
      throw Exception(response.body);
    }
  }

  Future<UserInfo> signInRequest({String email, String password}) async {
    final http.Response response = await http.post(
      'https://movil-api.herokuapp.com/signin',
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{'email': email, 'password': password}),
    );

    print('${response.body}');
    print('${response.statusCode}');
    if (response.statusCode == 200) {
      print("signin successful");
      manageJson(UserInfo.fromSignUp(json.decode(response.body)), password);
      notifyListeners();
      return userInfo;
    } else {
      print("signup failed");
      throw Exception(response.body);
    }
  }

  Future<bool> checkTokenRequest(
      {String email, String password, String username, String name}) async {
    final http.Response response = await http.post(
      'https://movil-api.herokuapp.com/check/token',
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'email': email,
        'password': password,
        'username': username,
        'name': name
      }),
    );

    print('${response.body}');
    print('${response.statusCode}');
    if (response.statusCode == 200) {
      print("Token verification was done successfully");
      return json.decode(response.body)['valid'];
    } else {
      print("Token verification failed");
      throw Exception(response.body);
    }
  }

  void saveLoginStatus(bool logged) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    print('Saving logged into the shared preferences!');
    await prefs.setBool('logged', logged);
  }

  void saveToken(String token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    print('Saving logged into the shared preferences!');
    await prefs.setString('token', token);
  }

  void saveEmail(String email) async {
    loginUser2(email: email);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    print('Saving logged into the shared preferences!');
    await prefs.setString('email', email);
  }

  void savePass(String pass) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    print('Saving logged into the shared preferences!');
    await prefs.setString('password', pass);
  }
}
