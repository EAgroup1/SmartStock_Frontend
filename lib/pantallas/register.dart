import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:rlbasic/models/_aux.dart';
import 'package:rlbasic/models/user.dart';
import 'package:rlbasic/pantallas/user/user.dart';
import 'package:rlbasic/pantallas/termsAndConditions.dart';
import 'package:rlbasic/services/userServices.dart';

import 'my_navigator.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  // bool _value = true;
  var name, email, password, conpassword, token, id;
  late final User user;
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
          }
          if (value != password) {
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
          }
        },
        obscureText: true,
        onChanged: (val) {
          conpassword = val;
        },
      );
    }

    termsAndConditions() {
      return ButtonBar(
        children: <Widget>[
          Container(
            padding: const EdgeInsets.all(16.0),
            child: TextButton(
              child: Text('Terms and Conditions'),
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                      builder: (context) => TermsAndConditionsPage()),
                );
              },
            ),
          ),
        ],
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
                if (_formKey.currentState!.validate()) {
                  UserServices().register(name, email, password).then((val) {
                    print(val.data);
                    print(val.statusCode);
                    if (val.statusCode == 200) {
                      user = new User(name, email, password);
                      user.token = val.data['_aux']['token'];
                      user.id = val.data['_aux']['_id'];
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => UserPage(user: user)),
                      );
                      //  MyNavigator.goToUser(context, );
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
              } catch (err) {
                print(err);
                Fluttertoast.showToast(
                  msg: err.toString(),
                  toastLength: Toast.LENGTH_SHORT,
                  timeInSecForIosWeb: 6
                );
              }
            },
          ));
    }

    return Material(
        child: Form(
            key: _formKey,
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Image.asset(
                    'assets/images/smartstock.jpeg',
                    width: 300.00,
                    height: 240,
                  ),
                  createNameInput(),
                  SizedBox(height: 12.0),
                  createEmailInput(),
                  // spacer
                  SizedBox(height: 30.0),
                  createPasswordInput(),
                  SizedBox(height: 12.0),
                  createConPasswordInput(),
                  termsAndConditions(),
                  createRegisterButton(context)
                ])));
  }
}
