import 'package:flutter/material.dart';
import 'package:rlbasic/models/globalData.dart';
import 'dart:core';
import 'package:rlbasic/my_navigator.dart';

GlobalData globalData = GlobalData.getInstance()!;

class UserPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    //menu lateral
    return MaterialApp(
        home: Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.cyan[600],
        title: Text("Bienvenido, "+globalData.userName, semanticsLabel: "Bienvenido"),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
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
                leading: Icon(Icons.add_business_rounded),
                title: Text('Buscar productos'),
                onTap: () {
                  MyNavigator.goToSearchProducts(context);
                }),
            ListTile(
                leading: Icon(Icons.apartment),
                title: Text('Mis productos almacenados'),
                onTap: () {
                   MyNavigator.goToLotList(context);
                }),
            ListTile(
                leading: Icon(Icons.motorcycle),
                title: Text('Productos para entregar'),
                onTap: () {
                  MyNavigator.goToUserDeliveryMenu(context);
                }),
            ListTile(
                leading: Icon(Icons.message),
                title: Text('Chat'),
                onTap: () {
                  MyNavigator.goToWebChatHomepage(context);
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
