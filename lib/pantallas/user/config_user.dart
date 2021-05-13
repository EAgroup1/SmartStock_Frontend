import 'package:flutter/material.dart';
import 'dart:core';
import 'package:rlbasic/services/userServices.dart';
import './user.dart';

class ConfigUserPage extends StatefulWidget {
  @override
  _ConfigUserPageState createState() => _ConfigUserPageState();
}

class _ConfigUserPageState extends State<ConfigUserPage> {
  Widget stack() {
   return Stack(
      alignment: Alignment.topLeft,
      children: [
       CircleAvatar(
          backgroundImage: AssetImage('assets/images/smartstock.jpeg'),
          radius: 100,
        ),
        Container(
          decoration: BoxDecoration(
            color: Colors.black45,
          ),
          child: Text(
            'SmartStockUser',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView(
      children: <Widget>[
        stack(),
        ListTile(
            leading: Icon(Icons.house),
            title: Text('Nombre'),
            onTap: () {
              Navigator.of(context).pushNamed("");
            }),
        ListTile(
            leading: Icon(Icons.email),
            title: Text('E-mail'),
            onTap: () {
              Navigator.of(context).pushNamed("");
            }),
        ListTile(
            leading: Icon(Icons.home_repair_service),
            title: Text('Dirección'),
            onTap: () {
              Navigator.of(context).pushNamed("");
            }),
        ListTile(
            leading: Icon(Icons.security),
            title: Text('Cambia la contraseña'),
            onTap: () {
              Navigator.of(context).pushNamed("");
            }),
        ListTile(
            leading: Icon(Icons.info),
            title: Text('FAQ'),
            onTap: () {
              Navigator.of(context).pushNamed("");
            }),
        ListTile(
            leading: Icon(Icons.info),
            title: Text('Políticas de privacidad'),
            onTap: () {
              Navigator.of(context).pushNamed("");
            }),
        ListTile(
            leading: Icon(Icons.info),
            title: Text('Soporte'),
            onTap: () {
              Navigator.of(context).pushNamed("");
            }),
        ListTile(
            leading: Icon(Icons.info),
            title: Text('Términos y Condiciones'),
            onTap: () {
              Navigator.of(context).pushNamed("");
            }),
        ListTile(
            leading: Icon(Icons.account_balance),
            title: Text('Cuenta bancaria'),
            onTap: () {
              Navigator.of(context).pushNamed("");
            })
      ],
    ));
  }
}
