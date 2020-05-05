import 'package:login/models/auth.dart';
import 'package:login/pages/home.dart';
import 'package:login/pages/login.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:login/models/user_info.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}


class _MainPageState extends State<MainPage> {
  bool _logged = false;
  Auth userModel = Auth();

  @override
  void initState(){
    super.initState();
    _loginStatus();
  }

  void _loginStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _logged = (prefs.getBool('logged') ?? false);
      print(_logged);
      if (_logged) {
        String email = (prefs.getString('email') ?? 'null');
        String pass = (prefs.getString('password') ?? 'null');
        Home();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(primarySwatch: Colors.teal),
      home: FutureBuilder(
        // get the Provider, and call the getUser method
        future: Provider.of<Auth>(context).getUser(),
        // wait for the future to resolve and render the appropriate
        // widget for HomePage or LoginPage
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            print("snapshotdata");
            print(snapshot.data);
            return snapshot.hasData ? Home() : Login();
          } else {
            return Container(color: Colors.white);
          }
        },
      ),
    );
  }
}
class LoadingCircle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        child: CircularProgressIndicator(),
        alignment: Alignment(0.0, 0.0),
      ),
    );
  }
}
