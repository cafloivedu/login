import 'dart:async';
import 'package:flutter/material.dart';

class Auth with ChangeNotifier {
  var currentUser;
  var createdEmail;
  var createdPass;

  Auth() {
    currentUser = "";
    createdEmail = "";
    createdPass = "";
  }

  Future getUser() {
    return Future.value(currentUser);
  }

  // wrappinhg the firebase calls
  Future logout() {
    this.currentUser = null;
    notifyListeners();
    return Future.value(currentUser);
  }

  // wrapping the firebase calls
  Future createUser({String email, String password}) async {
    createdEmail = email;
    createdPass = password;
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
}
