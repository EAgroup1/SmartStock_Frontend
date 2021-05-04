import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'dart:core';

class DelivererPage extends StatefulWidget {
  @override
  _DelivererPageState createState() => _DelivererPageState();
}

class _DelivererPageState extends State<DelivererPage> {
  @override
  Widget build(BuildContext context) {
     return MaterialApp(
        home: Scaffold(
      appBar: AppBar(
        title: const Text('¡Bienvenido Transportista!'),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: const <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text(
                'Perfil',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.motorcycle),
              title: Text('Entregas'),
             
            ),
            ListTile(
              leading: Icon(Icons.settings),
              title: Text('Configuración'),
            )
          ],
        ),
      ),
    ));
  }
}