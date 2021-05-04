import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'dart:core';

class ConfigCompanyPage extends StatefulWidget {
  @override
  _ConfigCompanyPageState createState() => _ConfigCompanyPageState();
}

class _ConfigCompanyPageState extends State<ConfigCompanyPage> {
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
            'SmartStockCompany',
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
            title: Text('Nombre de la tienda'),
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
            })
      ],
    ));
  }
}