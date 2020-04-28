import 'package:login/models/auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home Flutter Firebase"),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            SizedBox(height: 190.0),
            Text('Home Page'),
            SizedBox(height: 20.0),
            RaisedButton(
                child: Text("LOGOUT"),
                onPressed: () async {
                  await Provider.of<Auth>(context).logout();                  
                })
          ],
        ),
      ),
    );
  }
}
