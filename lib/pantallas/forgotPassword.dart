//first essential package for the widgets!!
import 'package:flutter/material.dart';
import '../my_navigator.dart';

//dark works with UpperCamelCase!! ---> never with CamelCase
//we work with a standard schema and we customize in all categories

//widgets with state=button (statefulWidget) and NO state= layout (stateless)
//ok --> this page has 3 widgets (2 stateless & 1 stateful)
 
class ForgotPasswordPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Forgot password',
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
                width: 300.00,
                height: 240,
              ),
              Text("Vamos a enviarte un email para cambiar tu contraseña"),
              TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Introduce el correo',
                ),
              ),

              //After that we show the floatingButton (not this type!!) ---> in progress
              TextButton(
                onPressed: (){
                  //go to the reset password for the moment
                  MyNavigator.goToCreateNewPassword(context);
                },
                child: Text("Cambia tu contraseña"),
              )
            ],
          ),
        ),
      ),
    );
  }
}

void forgotPass(){
//here we introduce the email & we call to the API to send the message
}