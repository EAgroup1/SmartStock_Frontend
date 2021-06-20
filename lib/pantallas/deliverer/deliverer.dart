import 'package:flutter/material.dart';
import 'package:rlbasic/pantallas/deliverer/config_deliverer.dart';
import 'dart:core';

import '../../my_navigator.dart';

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
        title: Text('¡Bienvenido Transportista '+ globalData.getUserName()+'!'),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children:  <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.cyan[400],
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
              onTap: () {
                  MyNavigator.goToDeliverPage(context);
                }),
            ListTile(
                leading: Icon(Icons.message),
                title: Text('Chat'),
                onTap: () {
                  MyNavigator.goToWebChatHomepage(context);
                }),
            ListTile(
              leading: Icon(Icons.settings),
              title: Text('Configuración'),
              onTap: () {
                  MyNavigator.goToConfigDeliverer(context);
                }
            ),
          ],
        ),
      ),
    ));
  }
}