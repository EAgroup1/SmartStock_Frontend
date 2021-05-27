import 'package:flutter/material.dart';
//initially, NOT required
import '../my_navigator.dart';
import '../../models/user.dart';
import '../../services/userServices.dart';
import 'package:fluttertoast/fluttertoast.dart';
 
// class CreateNewPassword extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Change password',
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
//               TextField(
//                 obscureText: true,
//                 decoration: InputDecoration(
//                   border: OutlineInputBorder(),
//                   labelText: 'New password',
//                 ),
//               ),
//               TextField(
//                 obscureText: true,
//                 decoration: InputDecoration(
//                   border: OutlineInputBorder(),
//                   labelText: 'Confirm password',
//                 ),
//               ),

//               //After that we show the floatingButton (not this type!!) ---> in progress
//               TextButton(
//                 onPressed: (){
//                   //respond to button press
//                   //createNewPass();
//                 },
//                 child: Text("Login"),
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

//again we create statefulW
class ResetPass extends StatefulWidget {
  ResetPass({Key? key}) : super(key: key);

  @override
  _ResetPassState createState() => _ResetPassState();
}

class _ResetPassState extends State<ResetPass> {

  //again we tried with these variables
  var resetLink, password, conpassword/*, token, id, email*/;
  // User user = User('', '', '', '', '');
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {

    //we follow the same structure that eric use on the registerPage
    createPasswordInput() {
      return TextFormField(
        decoration: InputDecoration(filled: true, hintText: 'Contraseña'),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Por favor, introduce una contraseña';
          } else if (value.length < 3) {
            return 'Introduce una contraseña de más de 3 carácteres';
          } else if (conpassword != password) {
            return 'Las contraseñas han de ser iguales';
          }
        },
        obscureText: true,
        onChanged: (val) {
          password = val;
        },
      );
    }

    createConPasswordInput() {
      return TextFormField(
        decoration:
            InputDecoration(filled: true, hintText: 'Confirma la contraseña'),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Por favor, introduce una contraseña';
          } else if (password != conpassword) {
            return 'Las contraseñas han de ser iguales';
          }
        },
        obscureText: true,
        onChanged: (val) {
          conpassword = val;
        },
      );
    }

    createResetPassButton(BuildContext context) {
      return Container(
          padding: const EdgeInsets.only(top: 30),
          child: ElevatedButton(
            child: Text(
              'Cambiar contraseña',
            ),
            onPressed: () {
              try {
                if (_formKey.currentState!.validate()) {
                  UserServices().resetPass(resetLink, password, conpassword).then((val) {
                    print(val.statusCode);
                    if (val.statusCode == 200) {
                      //we return to the login page to complete the process
                      MyNavigator.goToLogin(context);
                      Fluttertoast.showToast(
                            msg: 'Has cambiado la contraseña correctamente',
                            toastLength: Toast.LENGTH_SHORT,
                            timeInSecForIosWeb: 6);
                    } else if (val.statusCode == 400) {
                      Fluttertoast.showToast(
                          msg: 'Error al cambiar la contraseña',
                          toastLength: Toast.LENGTH_SHORT,
                          timeInSecForIosWeb: 6);
                    } else if (val.statusCode == 401) {
                      Fluttertoast.showToast(
                          msg: 'No existen token para este usuario',
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
                          createPasswordInput(),
                          SizedBox(height: 12.0),
                          createConPasswordInput(),
                          createResetPassButton(context)
                        ])))));
  }
}