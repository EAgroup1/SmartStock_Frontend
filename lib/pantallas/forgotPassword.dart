//we import some packages
import 'package:rlbasic/models/_aux.dart';
//import 'package:rlbasic/models/user.dart';
//import 'package:rlbasic/pantallas/login.dart';
//import '../my_navigator.dart';
//first essential package for the widgets!!
import 'package:flutter/material.dart';

//dark works with UpperCamelCase!! ---> never with CamelCase
//we work with a standard schema and we customize in all categories

//widgets with state=button (statefulWidget) and NO state= layout (stateless)
//ok --> this page has 3 widgets (2 stateless & 1 stateful) 
class ForgotPasswordPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //variable button
    final resetbutton = new InkWell(
      //container is the same as div on html ---> more/less
      child: new Container(
        margin: new EdgeInsets.only(
          top: 30.0,
          left: 20.0,
          right:20
        ),

        //button dimensions
        height: 50.0,
        width: 180.0,

        decoration: new BoxDecoration(
          boxShadow: [
            new BoxShadow(
              color: Color(0xFF01579B),
              //dimensions of the shadow
              offset: new Offset(10.0, 10.0),
              //degradation level
              blurRadius: 30.0
            )
          ],
          //if we want a circle button we write this
          borderRadius: new BorderRadius.circular(30.0),
          //the color of the button
          color: Color(0xFF03A9F4),
        ),
        //text of the button
        child : new Center(
          child: new Text(
            "Reset Password",
            //we add some styles at this button
            style: const TextStyle(
              fontSize: 12.0,
              color: Colors.white,
              fontWeight: FontWeight.w900
            ),
          ),
        ), 

      ),
    );

    // TODO: implement build
    throw UnimplementedError();
  }
}

class Header extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }
}

class EmailBack extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }
}

//we can print on the screen but it has a methods to change some values
class ButtonBack extends StatefulWidget{
  //we can show all screen again after state
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    throw UnimplementedError();
  }
}