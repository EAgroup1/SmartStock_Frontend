import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class LoginPage extends StatelessWidget {
  Widget CreateEmailInput() {
    return Padding(
        padding: const EdgeInsets.only(top: 30.0),
        child: TextFormField(
          decoration: InputDecoration(hintText: 'Usuario o Email'),
        ));
  }

  Widget CreatePasswordInput() {
    return Padding(
      padding: const EdgeInsets.only(top: 30.0),
      child: TextFormField(
        decoration: InputDecoration(hintText: 'Contraseña'),
        obscureText: true,
      ),
    );
  }

  Widget CreateLoginButton() {
    return Container(
        padding: const EdgeInsets.only(top: 30),
        child: RaisedButton(
          color: Colors.blue,
          child: Text(
            'Entrar',
          ),
          textColor: Colors.white,
          onPressed: () {},
        ));
  }

  Widget CreateAccountLink() {
    return Container(
        child: Text('Crea tu cuenta aquí', textAlign: TextAlign.right),
        padding: EdgeInsets.only(top: 40));
  }

  Widget ResetPassword() {
    return Container(
        child: Text('¿Has olvidado la contraseña?', textAlign: TextAlign.left),
        padding: EdgeInsets.only(bottom: 10));
  }

  Widget Divisor() {
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

  Widget FacebookButton() {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(color: Colors.white),
        child: ListView(
          children: [
            Image.asset(
              'assets/images/smartstock.jpeg',
              width: 300.00,
              height: 240,
            ),
            CreateEmailInput(),
            CreatePasswordInput(),
            CreateLoginButton(),
            CreateAccountLink(),
            ResetPassword(),
            Divisor(),
            FacebookButton()
          ],
        ),
      ),
    );
  }
}
