import 'package:flutter/material.dart';
import 'package:rlbasic/models/user.dart';
import 'package:rlbasic/pantallas/splashScreen.dart';
import 'my_navigator.dart';

late User user;
void main() {
  runApp(MyApp());
}

//MyApp heredates of StatelessWidget ---> overwrite build method
class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'SmartStock',
        theme: ThemeData(
          dividerColor: Colors.grey,
          primarySwatch: Colors.blue,
        ),
        //First widget to render
        home: SplashScreen(),
        routes: routes);
  }
}
