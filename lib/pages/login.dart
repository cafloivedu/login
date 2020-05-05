import 'package:login/models/auth.dart';
import 'package:login/pages/signup.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();
  String _password;
  String _email;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Login Page Flutter"),
        ),
        body: Container(
            padding: EdgeInsets.all(20.0),
            child: Form(
                key: _formKey,
                child: new ListView(shrinkWrap: true, children: <Widget>[
                  SizedBox(height: 20.0),
                  Text(
                    'Información de Login',
                    style: TextStyle(fontSize: 20),
                  ),
                  SizedBox(height: 20.0),
                  TextFormField(
                      onSaved: (value) => _email = value,
                      keyboardType: TextInputType.emailAddress,
                      decoration:
                          InputDecoration(labelText: "Direccion de Email")),
                  TextFormField(
                      onSaved: (value) => _password = value,
                      obscureText: true,
                      decoration: InputDecoration(labelText: "Contraseña")),
                  SizedBox(height: 20.0),
                  FlatButton(
                    child: Text("LOGIN"),
                    color: Colors.tealAccent,
                    onPressed: () async {
                      final form = _formKey.currentState;
                      form.save();
                      if (form.validate()) {
                        print("$_email $_password");
                      }
                      var result = await Provider.of<Auth>(context)
                          .signInRequest(email: _email, password: _password);

                      if (result != null) {
                        
                      } else {
                        return _buildShowErrorDialog(
                            context, "Credenciales inválidas");
                      }
                    },
                  ),
                  FlatButton(
                      child: new Text('Crear una cuenta',
                          style: new TextStyle(
                              fontSize: 18.0, fontWeight: FontWeight.w300)),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => SignUp()),
                        );
                      })
                ]))));
  }

  Future<void> _buildShowErrorDialog(BuildContext context, _message) {
    return showDialog(
      builder: (context) {
        return AlertDialog(
          title: Text('Advertencia'),
          content: Text(_message),
          actions: <Widget>[
            FlatButton(
                child: Text('Cancelar'),
                color: Colors.tealAccent,
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
