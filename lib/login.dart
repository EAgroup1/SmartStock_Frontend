import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:rlbasic/crear.dart';
import 'package:rlbasic/entrar.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  //final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    
    createEmailInput() {
      return TextFormField(
        decoration: InputDecoration(hintText: 'Usuario o Email'),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Por favor, introduce un texto';
          } else
            return null;
        },
      );
    }

    createPasswordInput() {
      return TextFormField(
        decoration: InputDecoration(hintText: 'Contraseña'),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Por favor, introduce un texto';
          } else
            return null;
        },
        obscureText: true,
      );
    }

    createLoginButton(BuildContext context) {
      return Container(
          padding: const EdgeInsets.only(top: 30),
          child: ElevatedButton(
            child: Text(
              'Entrar',
            ),
            onPressed: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => EntrarPage()));
            },
          ));
    }

    createAccountLink() {
      return Container(
          child: Text('Crea tu cuenta aquí', textAlign: TextAlign.right),
          padding: EdgeInsets.only(top: 40));
    }

    resetPassword() {
      return Container(
          child:
              Text('¿Has olvidado la contraseña?', textAlign: TextAlign.left),
          padding: EdgeInsets.only(bottom: 10));
    }

    divisor() {
      return Container(
          padding: const EdgeInsets.only(top: 5),
          child: Row(children: [
            Expanded(child: Divider(height: 1)),
            Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Text('ó')),
            Expanded(child: Divider(height: 1))
          ]));
    }

    facebookButton() {
      return Container(
          padding: const EdgeInsets.only(top: 32),
          child: RaisedButton(
            textColor: Colors.white,
            color: Colors.blue,
            child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              Icon(FontAwesomeIcons.facebookSquare),
              Padding(
                padding: const EdgeInsets.only(left: 32),
                child: Text('Entrar con Facebook', textAlign: TextAlign.center),
              )
            ]),
            onPressed: () {},
          ));
    }

    return Scaffold(
      //key: _formKey,
      body: ListView(
        children: <Widget>[
          Image.asset(
            'assets/images/smartstock.jpeg',
            width: 300.00,
            height: 240,
          ),
          createEmailInput(),
          createPasswordInput(),
          createLoginButton(context),
          createAccountLink(),
          resetPassword(),
          divisor(),
          facebookButton()
        ],
      ),
    );
  }
}
