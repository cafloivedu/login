import 'package:login/models/auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final _formKey = GlobalKey<FormState>();
  String _password;
  String _email;
  String _username;
  String _name;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Sign Up"),
        ),
        body: Container(
            padding: EdgeInsets.all(20.0),
            child: Form(
                key: _formKey,
                child: new ListView(shrinkWrap: true, children: <Widget>[
                  Text(
                    'Información de registro',
                    style: TextStyle(fontSize: 20),
                  ),
                  SizedBox(height: 20.0),
                  TextFormField(
                      onSaved: (value) => _email = value,
                      keyboardType: TextInputType.emailAddress,
                      decoration:
                          InputDecoration(labelText: "Dirección de Email")),
                  TextFormField(
                      onSaved: (value) => _password = value,
                      obscureText: true,
                      decoration: InputDecoration(labelText: "Contraseña")),
                  TextFormField(
                      onSaved: (value) => _username = value,
                      keyboardType: TextInputType.text,
                      decoration:
                          InputDecoration(labelText: "Nombre de usuario")),
                  TextFormField(
                      onSaved: (value) => _name = value,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(labelText: "Nombre")),
                  SizedBox(height: 20.0),
                  RaisedButton(
                    child: Text("Sign Up"),
                    onPressed: () async {
                      // save the fields..
                      final form = _formKey.currentState;
                      form.save();

                      // Validate will return true if is valid, or false if invalid.
                      if (form.validate()) {
                        print("$_email $_password");
                      }
                      var result = await Provider.of<Auth>(context).createUser(
                          email: _email,
                          password: _password,
                          username: _username,
                          name: _name);

                      if (result != null) {
                        return _buildShowEDoneDioalog(context, "Hecho");
                      } else {
                        return _buildShowErrorDialog(
                            context, "Los campos no pueden estar vacios");
                      }
                    },
                  )
                ]))));
  }

  Future<void> _buildShowErrorDialog(BuildContext context, _message) {
    return showDialog(
      builder: (context) {
        return AlertDialog(
          title: Text('Message'),
          content: Text(_message),
          actions: <Widget>[
            FlatButton(
                child: Text('Cancel'),
                onPressed: () {
                  Navigator.of(context).pop();
                })
          ],
        );
      },
      context: context,
    );
  }

  Future<void> _buildShowEDoneDioalog(BuildContext context, _message) {
    return showDialog(
      builder: (context) {
        return AlertDialog(
          title: Text('Message'),
          content: Text(_message),
          actions: <Widget>[
            FlatButton(
                child: Text('Ok'),
                onPressed: () {
                  Navigator.of(context).pop();
                })
          ],
        );
      },
      context: context,
    );
  }
}
