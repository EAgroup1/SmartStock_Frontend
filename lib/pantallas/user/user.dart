import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:rlbasic/models/user.dart';
import 'dart:core';
import 'package:rlbasic/my_navigator.dart';

class UserPage extends StatefulWidget {
  late User user;
  UserPage({required this.user});
  @override
  _UserPageState createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  List<Widget> datosUsuario = [];

  getUser() async {
    var url = Uri.parse("http://localhost:4000/logIn");
    var response = await http.get(url);
    debugPrint(response.body);
  }

  @override
  initState() {
    super.initState();
    //getUser();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
      appBar: AppBar(
        title: const Text('¡Bienvenido usuario!'),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
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
                leading: Icon(Icons.add_business_rounded),
                title: Text('Buscar productos'),
                onTap: () {
                  Navigator.of(context).pushNamed("");
                }),
            ListTile(
                leading: Icon(Icons.apartment),
                title: Text('Mis productos almacenados'),
                onTap: () {
                  Navigator.of(context).pushNamed("");
                }),
            ListTile(
                leading: Icon(Icons.motorcycle),
                title: Text('Productos para entregar'),
                onTap: () {
                  MyNavigator.goToUserDeliveryMenu(context);
                }),
            ListTile(
                leading: Icon(Icons.account_circle),
                title: Text('Configuración'),
                onTap: () {
                  MyNavigator.goToConfigUser(context);
                }),
          ],
        ),
      ),
    ));
  }
}
