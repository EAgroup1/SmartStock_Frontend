import 'package:flutter/material.dart';
import 'package:rlbasic/my_navigator.dart';

class Mejoras extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ayudanos a mejorar'),
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
                  MyNavigator.goToSearchProducts(context);
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
            ListTile(
                leading: Icon(Icons.account_circle),
                title: Text('Ayudanos a mejorar'),
                onTap: () {
                  MyNavigator.goToMejoras(context);
                }),
          ],
        ),
      ),
      body: MejorasPage(),
    );
  }
}

class MejorasPage extends StatefulWidget {
  @override
  _MejorasPageState createState() => _MejorasPageState();
}

class _MejorasPageState extends State<MejorasPage> {
  @override
  Widget build(BuildContext context) {
    return ListTile(title: Text('de momento funciona'));
  }
}
