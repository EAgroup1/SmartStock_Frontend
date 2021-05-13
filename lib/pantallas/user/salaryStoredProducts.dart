//mateapp to design a standard project ---> tree of widgets
import 'package:flutter/material.dart';

//working on forgotPassword.dart
 
void main() => runApp(MyApp());
 
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      //title: 'Selected storage product',
      title: 'Account',
      home: Scaffold(
        appBar: AppBar(
          title: Text('My store products'),
        ),
        //we center all body for this moment
        body: Center(

          // //test iconbutton
          // child: IconButton(
          //   icon: Icon(Icons.euro_symbol),
          //   onPressed: (){
          //     //print something but we can acces in other screen
          //     print("say something");
          //   },
          //   iconSize: 20,
          // )

          //we create child container on standard mateapp
          child: Container(
            //child: Text('Hello World'),
            child: Image.asset(
              'assets/images/smartstock.jpeg',
              height: 80,
            ),
          ),
        ),
        //we put the toolbar or dropdown on the right (appbar)
        drawer: Drawer(),

        //scaffold allows to play with back color ---> Dark Mode?
        //backgroundColor: Colors.black,

        //button on the right bottom ---> Be careful!!
        floatingActionButton: FloatingActionButton(
            child: Text("Do something!"),
            onPressed: (){},
        ),
      ),
    );
  }
}