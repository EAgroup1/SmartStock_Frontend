import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'dart:core';

class ConfigDelivererPage extends StatefulWidget {
  @override
  _ConfigDelivererPageState createState() => _ConfigDelivererPageState();
}

class _ConfigDelivererPageState extends State<ConfigDelivererPage> {
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