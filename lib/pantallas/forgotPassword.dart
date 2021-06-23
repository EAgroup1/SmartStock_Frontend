//first essential package for the widgets!!
import 'package:flutter/material.dart';
//import '../../models/user.dart';
import '../../services/userServices.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../my_navigator.dart';

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