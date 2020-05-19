import 'dart:math';

import 'package:flutter/material.dart';

class MyDrawer extends StatefulWidget {
  @override
  _MyDrawerState createState() => new _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  final email = Random();
  String currentProfilePic =
      "https://avatars3.githubusercontent.com/u/16825392?s=460&v=4";

  @override
  Widget build(BuildContext context) {
    return new Drawer(
      child: new ListView(
        children: <Widget>[
          new UserAccountsDrawerHeader(
            accountEmail: new Text("bramvbilsen@gmail.com"),//obtener email aquí
            accountName: new Text("Bramvbilsen"),//obtener username aquí
            currentAccountPicture: new GestureDetector(
              child: new CircleAvatar(
                backgroundImage: new NetworkImage("https://api.adorable.io/avatars/285/${this.email}"),//obtener avatar aquí
              ),
              onTap: () => print("This is your current account."),
            ),
            decoration: new BoxDecoration(
                image: new DecorationImage(
                    image: new NetworkImage(
                        "https://img00.deviantart.net/35f0/i/2015/018/2/6/low_poly_landscape__the_river_cut_by_bv_designs-d8eib00.jpg"),//obtener imagen aleatoria de fondo
                    fit: BoxFit.fill)),
          ),
          new ListTile(
              title: new Text("Page One"),
              trailing: new Icon(Icons.arrow_upward),
              onTap: () {
                Navigator.of(context).pop();
                // Navigator.of(context).push(new MaterialPageRoute(
                //     builder: (BuildContext context) =>
                //         new Page("First Page")));
              }),
          new ListTile(
              title: new Text("Page Two"),
              trailing: new Icon(Icons.arrow_right),
              onTap: () {
                Navigator.of(context).pop();
                // Navigator.of(context).push(new MaterialPageRoute(
                //     builder: (BuildContext context) =>
                //         new Page("Second Page")));
              }),
          new Divider(),
          new ListTile(
            title: new Text("Cancel"),
            trailing: new Icon(Icons.cancel),
            onTap: () => Navigator.pop(context),
          ),
        ],
      ),
    );
  }
}
