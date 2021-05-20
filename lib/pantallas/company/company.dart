import 'package:flutter/material.dart';
import 'dart:core';

import '../../my_navigator.dart';

class CompanyPage extends StatefulWidget {
  @override
  _CompanyPageState createState() => _CompanyPageState();
}

class _CompanyPageState extends State<CompanyPage> {
  @override
  Widget build(BuildContext context) {
     return MaterialApp(
        home: Scaffold(
      appBar: AppBar(
        title: Text('¡Bienvenido tienda!'),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children:  <Widget>[
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
              leading: Icon(Icons.business),
              title: Text('Productos'),
             
            ),
            ListTile(
              leading: Icon(Icons.motorcycle),
              title: Text('Enviar productos'),
              onTap: () {
                  MyNavigator.goToSendProducts(context);
                }),

            ListTile(
              leading: Icon(Icons.settings),
              title: Text('Configuración'),
              onTap: () {
                  MyNavigator.goToConfigCompany(context);
                }),
          ],
        ),
      ),
    ));
  }
}