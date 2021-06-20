import 'package:flutter/material.dart';
import 'dart:core';
import '../../my_navigator.dart';
import 'package:rlbasic/models/globalData.dart';
import 'package:rlbasic/services/userServices.dart';
import './user.dart';

GlobalData globalData = GlobalData.getInstance()!;

class ConfigUserPage extends StatefulWidget {
  @override
  _ConfigUserPageState createState() => _ConfigUserPageState();
}

class _ConfigUserPageState extends State<ConfigUserPage> {
  Widget stack() {
    return Scaffold(
        appBar: AppBar(
          title: Text('Settings'),
          centerTitle: true,
          backgroundColor: Colors.blue,
          elevation: 0.0,
        ),
        body: 
        Container(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Stack(
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
            )));
  }

  void popup(BuildContext context) {
    var alert = AlertDialog(
      title: const Text('Cerrar sesión'),
      content: new SingleChildScrollView(
        child: ListBody(
          children: <Widget>[
            Text("¿Estas seguro?"),
          ],
        ),
      ),
      actions: <Widget>[
        FlatButton(
          onPressed: () {
            globalData.setInstance();
            MyNavigator.goToLogin(context);
          },
          textColor: Theme.of(context).primaryColor,
          child: const Text('Aceptar'),
        ),
        FlatButton(
          onPressed: () {
            Navigator.of(context).pop('Cancelar');
          },
          textColor: Theme.of(context).primaryColor,
          child: const Text('Cancelar'),
        )
      ],
    );
    showDialog(context: context, builder: (BuildContext context) => alert);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text('Settings'),
          centerTitle: true,
          backgroundColor: Colors.blue,
          elevation: 0.0,
        ),
      body: ListView(children: <Widget>[
        Flexible(child: Container(
          color: Colors.cyan[50],
          padding: EdgeInsets.all(10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
            CircleAvatar(
                    backgroundImage: AssetImage('assets/images/smartstock.jpeg'),
                    radius: 40,
                    ),
            SizedBox(width: 4,),
            
             Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,                        
              children: [
              Text(globalData.userName,style: const TextStyle(
                  fontSize: 25.0,
                  color: Colors.black87,
                ),),
                Text(globalData.email,style: const TextStyle(
                      fontSize: 15.0,
                      color: Colors.grey,
                    ),),
                  Text(globalData.location,style: const TextStyle(
                      color: Colors.grey,
                    ), overflow: TextOverflow.ellipsis ,
                    softWrap: true,
                    maxLines: 2,
                    ),
              
            ],),

          ],),),
      ),
      Divider(thickness: 4,color: Colors.cyan,),
       
        ListTile(
          leading: Icon(Icons.security),
          title: Text('Cambia la contraseña'),
          onTap: () {
            MyNavigator.goToForgotPassword(context);
          }),
          Divider(indent: 16, endIndent: 16,),
        ListTile(
          leading: Icon(Icons.info),
          title: Text('FAQ'),
          onTap: () {
            Navigator.of(context).pushNamed("");
          }),
        Divider(indent: 16, endIndent: 16,),
        ListTile(
          leading: Icon(Icons.info),
          title: Text('Políticas de privacidad'),
          onTap: () {
            Navigator.of(context).pushNamed("");
          }),
        Divider(indent: 16, endIndent: 16,),
        ListTile(
          leading: Icon(Icons.info),
          title: Text('Soporte'),
          onTap: () {
            Navigator.of(context).pushNamed("");
          }),
        Divider(indent: 16, endIndent: 16,),
        ListTile(
          leading: Icon(Icons.info),
          title: Text('Términos y Condiciones'),
          onTap: () {
            MyNavigator.goToTerms(context);
          }),
        Divider(indent: 16, endIndent: 16,),
        ListTile(
          leading: Icon(Icons.account_balance),
          title: Text('Cuenta bancaria'),
          onTap: () {
            Navigator.of(context).pushNamed("");
          }),
        Divider(indent: 16, endIndent: 16,),
        ListTile(
          leading: Icon(Icons.arrow_circle_down_rounded),
          title: Text('Cerrar sesión'),
          onTap: () {
            popup(context);
          })
      ]));
  }
}
