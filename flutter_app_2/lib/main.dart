import 'package:flutter/material.dart';
import 'package:flutter_app_2/Screens/Welcome/welcome.dart';

import 'package:flutter_app_2/constants.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Login',
      theme: ThemeData(
        primaryColor: Colors.green,
        scaffoldBackgroundColor: Colors.white,
      ),
      home: Welcome(),
    );
  }
}
