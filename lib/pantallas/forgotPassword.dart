//first essential package for the widgets!!
import 'package:flutter/material.dart';
//import '../../models/user.dart';
import '../../services/userServices.dart';
import 'package:fluttertoast/fluttertoast.dart';

//dark works with UpperCamelCase!! ---> never with CamelCase
//we work with a standard schema and we customize in all categories

//widgets with state=button (statefulWidget) and NO state= layout (stateless)
//ok --> this page has 3 widgets (2 stateless & 1 stateful)
 
// class ForgotPasswordPage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Forgot password',
//       home: Scaffold(
//         //on these initial screens there aren't appBar 
//         // appBar: AppBar(
//         //   title: Text('Material App Bar'),
//         // ),
//         body: SizedBox(
//           width: double.infinity,
//           child: Column(

//             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//             crossAxisAlignment: CrossAxisAlignment.stretch,

//             children: <Widget>[

//               //be careful with the size of the top image
//               Image.asset(
//                 'assets/images/logoSmartStock.jpeg',
//                 width: 300.00,
//                 height: 240,
//               ),
//               Text("We will send you a email to reset your password"),
//               TextField(
//                 obscureText: true,
//                 decoration: InputDecoration(
//                   border: OutlineInputBorder(),
//                   labelText: 'Enter email',
//                 ),
//               ),

//               //After that we show the floatingButton (not this type!!) ---> in progress
//               TextButton(
//                 onPressed: (){
//                   //go to the reset password for the moment
//                   MyNavigator.goToCreateNewPassword(context);
//                 },
//                 child: Text("Reset password"),
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

class ForgotPass extends StatefulWidget {
  ForgotPass({Key? key}) : super(key: key);

  @override
  _ForgotPassState createState() => _ForgotPassState();
}

class _ForgotPassState extends State<ForgotPass> {
  //some variables that possible we use
  var email/*, token, id*/;
  //User user = User('', '', '', '', '');
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {

    createEmailInput() {
      return TextFormField(
        decoration: InputDecoration(filled: true, hintText: 'Email'),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Por favor, introduce un correo';
          } else if (RegExp(
                  r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
              .hasMatch(value)) {
            return null;
          } else {
            return 'Introduce un correo válido';
          }
        },
        onChanged: (val) {
          email = val;
        },
      );
    }

    createForgotPassButton(BuildContext context) {
      return Container(
          padding: const EdgeInsets.only(top: 30),
          child: ElevatedButton(
            child: Text(
              'Enviar correo',
            ),
            onPressed: () {
              try {
                if (_formKey.currentState!.validate()) {
                  UserServices().forgotPass(email).then((val) {
                    print(val.statusCode);
                    if (val.statusCode == 401) {
                      Fluttertoast.showToast(
                            msg: '¡Este correo no existe!',
                            toastLength: Toast.LENGTH_SHORT,
                            timeInSecForIosWeb: 6);
                    } else if (val.statusCode == 500) {
                      Fluttertoast.showToast(
                          msg: 'Error al conectarse a la base de datos',
                          toastLength: Toast.LENGTH_SHORT,
                          timeInSecForIosWeb: 6);
                    } else {
                      Fluttertoast.showToast(
                          msg: val.status,
                          toastLength: Toast.LENGTH_SHORT,
                          timeInSecForIosWeb: 6);
                    }
                  });
                }
              } catch (err) {
                print(err);
                Fluttertoast.showToast(
                    msg: err.toString(),
                    toastLength: Toast.LENGTH_SHORT,
                    timeInSecForIosWeb: 6);
              }
            },
          ));
    }

    return Material(
        child: Form(
            key: _formKey,
            child: SafeArea(
                child: Align(
                    alignment: Alignment.center,
                    child: ListView(
                        padding: const EdgeInsets.all(30),
                        children: <Widget>[
                          Image.asset(
                            'assets/images/logoSmartStock.jpeg',
                            width: 300.00,
                            height: 240,
                          ),
                          createEmailInput(),
                          SizedBox(height: 30.0),
                          createForgotPassButton(context)
                        ])))));
  }
}