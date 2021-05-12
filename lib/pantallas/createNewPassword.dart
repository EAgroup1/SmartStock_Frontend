//tree widgets ---> my app - material app - home page, etc.

import 'package:flutter/material.dart';

//each widget is a class

class NewPasswordPage extends StatelessWidget{
  //we split the app for this params
  Widget build(BuildContext){ //returns a tree of widgets
    //we put scaffold for split header, body & footer
    //we create a variable for the widget ---> will see in the future
    var widget;
        return new Scaffold(
          //scaffold has no childrens but has different attributes
          //we put the header with the appBar
          appBar: new AppBar(
            title: new Text(widget.title),
      ),
      //now we introduce the body of the app
      body: new Center(
        //now we create a child for the father center
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          //some childrens for the column widgets ---> array of childrens or array of texts
          children: <Widget>[
            new Text(
              'etc.',
            ),
            new Text(
              'something text',
            ),
          ],
        ),
      ),
      //for the last section we introduce the footer, floatingButton
      floatingActionButton: new FloatingActionButton(
        onPressed: _somethingAction,
                tooltip: 'Something',
                child: new Icon(Icons.add),
              ),
            );
          }
          
          void _somethingAction() {
  }
}