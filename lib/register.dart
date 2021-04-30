import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:rlbasic/entrar.dart';
import 'package:rlbasic/services/userServices.dart';
import 'package:rlbasic/termsAndConditions.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  // bool _value = true;
  var name, email, password, conpassword, token;

  @override
  Widget build(BuildContext context) {
    createNameInput() {
      return TextFormField(
        decoration: InputDecoration(filled: true, hintText: 'Nombre completo'),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Por favor, introduce un texto';
          } else
            return value;
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
          } else
            return value;
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
          if (value == null || value.isEmpty ) {
            return 'Por favor, introduce un texto';
          }
          if(value != password){
            return 'Las contraseñas han de ser iguales';
          } else
            return value;
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
            return 'Por favor, introduce un texto';
          } else
            return value;
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
              UserServices().register(name, email, password).then((val) {
                print(val.data);
                if (val.data['success']) {
                  token = val.data['token'];
                  Fluttertoast.showToast(
                      msg: 'loged',
                      toastLength: Toast.LENGTH_SHORT,
                      timeInSecForIosWeb: 6);
                }
              });
              /* Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => EntrarPage()));
             */
            },
          ));
    }

    return Scaffold(
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
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
        ],
      ),
    );
  }
}
