import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:rlbasic/models/user.dart';
import 'package:rlbasic/my_navigator.dart';
import 'package:rlbasic/pantallas/user/user.dart';
import 'package:rlbasic/pantallas/termsAndConditions.dart';
import 'package:rlbasic/services/userServices.dart';
import 'package:rlbasic/pantallas/bankData.dart';
import '../my_navigator.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  var name, email, password, conpassword, token, id;
  bool termsAccepted = false;
  User user = User('', '', '', '', '');
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    createNameInput() {
      return TextFormField(
        decoration: InputDecoration(filled: true, hintText: 'Nombre completo'),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Por favor, introduce nombre';
          }
        },
        onChanged: (val) {
          name = val;
        },
      );
    }

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

    termsAndConditions(){
      return ButtonBar(
        children: <Widget>[
          Container(
            padding: const EdgeInsets.all(16.0),
            child: TextButton(
              child: Text('Términos y condiciones'),
              onPressed: () {
                MyNavigator.goToTerms(context);
              },
            ),
          ),
        ],
      );
    }

    termsAndConditionsCheckbox() {
      return Center(
        child: CheckboxListTile(
          title: const Text('Acepto los términos y condiciones'),
          value: termsAccepted,
          onChanged: (bool? value) {
            setState(() { termsAccepted = value!; });
          },
          controlAffinity: 
            ListTileControlAffinity.leading
        ),
      );
      
    }

    createRegisterButton(BuildContext context) {
      return Container(
          padding: const EdgeInsets.only(top: 30),
          child: ElevatedButton(
            child: Text(
              'Entrar',
            ),
            onPressed: () {
              try {
                if(termsAccepted){
                if (_formKey.currentState!.validate()) {
                  UserServices().register(name, email, password).then((val) {
                    print(val.statusCode);
                    if (val.statusCode == 200) {
                      globalData.setId(val.data['_id']);
                      globalData.setToken(val.data['token']);
                      globalData.setUserName(val.data['userName']);
                      MyNavigator.goToBankData(context);
                      Fluttertoast.showToast(
                            msg: 'Logged successfully',
                            toastLength: Toast.LENGTH_SHORT,
                            timeInSecForIosWeb: 6);
                    } else if (val.statusCode == 401) {
                      Fluttertoast.showToast(
                          msg: 'Email o contraseña incorrectos',
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
                }else{
                  Fluttertoast.showToast(msg: "Debes aceptar los términos y condiciones");
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
                            'assets/images/smartstock.jpeg',
                            width: 300.00,
                            height: 240,
                          ),
                          createNameInput(),
                          SizedBox(height: 12.0),
                          createEmailInput(),
                          SizedBox(height: 30.0),
                          createPasswordInput(),
                          SizedBox(height: 12.0),
                          createConPasswordInput(),
                          termsAndConditions(),
                          termsAndConditionsCheckbox(),
                          createRegisterButton(context)
                        ])))));
  }
}
