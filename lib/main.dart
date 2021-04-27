import 'package:flutter/material.dart';
import 'package:rlbasic/crear.dart';
import 'package:rlbasic/entrar.dart';
import 'login.dart';

void main() {
  runApp(MyApp());
}


class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          dividerColor: Colors.grey,
          primarySwatch: Colors.blue,
        ),
        home: LoginPage());
  }
}
