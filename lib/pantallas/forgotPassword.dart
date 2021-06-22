//first essential package for the widgets!!
import 'package:flutter/material.dart';
import 'package:rlbasic/services/userServices.dart';
import '../my_navigator.dart';


//dark works with UpperCamelCase!! ---> never with CamelCase
//we work with a standard schema and we customize in all categories

//widgets with state=button (statefulWidget) and NO state= layout (stateless)
//ok --> this page has 3 widgets (2 stateless & 1 stateful)
 
class ForgotPasswordPage extends StatelessWidget {
  UserServices user = new UserServices();
  var newpassword, email, conpassword;
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Contraseña olvidada',
      home: Scaffold(
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
              TextFormField(
              decoration: InputDecoration(hintText: 'Email'),
              controller: _passController,
              validator: (value) {
               if (value == null || value.isEmpty) {
               return 'Por favor, introduce un email';
               }
               },
                onChanged: (val) {
                  email = val;
        },
              ),
              TextFormField(
              decoration: InputDecoration(hintText: 'Contraseña'),
              controller: _passController,
              validator: (value) {
               if (value == null || value.isEmpty) {
               return 'Por favor, introduce una contraseña';
               }
               },
                obscureText: true,
                onChanged: (val) {
                  newpassword = val;
        },
      ),

      TextFormField(
              decoration: InputDecoration(hintText: 'Repite contraseña'),
              controller: _passController,
              validator: (value) {
               if (value == null || value.isEmpty) {
               return 'Por favor, introduce la misma contraseña';
               }
               },
                obscureText: true,
                onChanged: (val) {
                  conpassword = val;
        },
      ),

              //After that we show the floatingButton (not this type!!) ---> in progress
              TextButton(
                onPressed: (){
                  //go to the reset password for the moment

                },
                child: Text("Restaura la contraseña"),
              )
            ],
          ),
        ),
      ),
    );
  }
}
