import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:rlbasic/crear.dart';
import 'package:rlbasic/entrar.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
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
      );
    }

    createEmailInput() {
      return TextFormField(
        decoration: InputDecoration(hintText: 'Email'),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Por favor, introduce un correo';
          } else
            return value;
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
            return value;
        },
        obscureText: true,
      );
    }

    createConPasswordInput() {
      return TextFormField(
        decoration: InputDecoration(hintText: 'Confirma la contraseña'),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Por favor, introduce un texto';
          } else
            return value;
        },
        obscureText: true,
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
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => EntrarPage()));
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
          createEmailInput(),
          // spacer
          SizedBox(height: 12.0),
          createPasswordInput(),
          createConPasswordInput(),
          createRegisterButton(context)
        ],
      ),
    );
  }
}
