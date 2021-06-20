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
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          brightness: Brightness.light,
          primaryColorBrightness: Brightness.dark,
          shadowColor: Colors.cyan[300],
          cardColor: Colors.cyan[100],
          buttonColor: Colors.cyan[500],
          backgroundColor: Colors.cyan[100],
          indicatorColor: Colors.cyan[700],
          hintColor: Colors.cyan[400],          
          
          appBarTheme: AppBarTheme(
            backgroundColor: Colors.cyan[600],
            shadowColor: Colors.cyan,
            foregroundColor: Colors.cyan,
            elevation: 2, centerTitle: false,),
          primaryColor: Colors.cyan[300],
          accentColor: Colors.cyan[500],
          fontFamily: 'Hind',
          dividerColor: Colors.cyan[500],
          primarySwatch: Colors.cyan,
        ),
        //First widget to render
        home: SplashScreen(),
        routes: routes);
  }
}
