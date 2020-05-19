import 'package:flutter/material.dart';
import 'pages/main_page.dart';
import 'package:provider/provider.dart';
import 'models/auth.dart';


void main() => runApp(
      ChangeNotifierProvider<Auth>(
        create: (context) => Auth(),
        child: MainPage(),
      ),
    );

