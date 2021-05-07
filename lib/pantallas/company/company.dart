import 'package:flutter/material.dart';
import 'dart:core';

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
        title: const Text('¡Bienvenido tienda!'),
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
              leading: Icon(Icons.business),
              title: Text('Productos'),
             
            ),
            ListTile(
              leading: Icon(Icons.motorcycle),
              title: Text('Enviar productos'),
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