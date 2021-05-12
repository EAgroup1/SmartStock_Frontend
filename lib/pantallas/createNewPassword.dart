import 'package:flutter/material.dart';
 
void main() => runApp(MyApp());
 
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Change password',
      home: Scaffold(
        //on these initial screens there aren't appBar 
        // appBar: AppBar(
        //   title: Text('Material App Bar'),
        // ),
        body: SizedBox(
          width: double.infinity,
          child: Column(

            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.stretch,

            children: <Widget>[

              //be careful with the size of the top image
              Image.asset(
                'assets/images/logoSmartStock.jpeg',
                height: 80,
              ),
              TextField(
                obscureText: true,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'New password',
                ),
              ),
              TextField(
                obscureText: true,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Confirm password',
                ),
              ),

              //After that we show the floatingButton (not this type!!) ---> in progress
              TextButton(
                onPressed: (){
                  //respond to button press
                },
                child: Text("Login"),
              )
            ],
          ),
        ),
      ),
    );
  }
}