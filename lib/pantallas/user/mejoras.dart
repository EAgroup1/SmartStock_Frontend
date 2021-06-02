import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:rlbasic/models/globalData.dart';
import 'package:rlbasic/my_navigator.dart';
import 'package:rlbasic/services/userServices.dart';

GlobalData globalData = GlobalData.getInstance()!;

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
  var mejoras;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Material(
        child: Form(
            key: _formKey,
            child: ListView(
              padding: EdgeInsets.all(30),
              children: <Widget>[
                ListTile(title: Text('Nos encanta')),
                TextFormField(
                  decoration: InputDecoration(
                      filled: true, hintText: 'Nombre completo'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor, introduce una sugerecia antes de enviar algo';
                    }
                  },
                  onChanged: (val) {
                    mejoras = val;
                  },
                ),
                Container(
                  padding: const EdgeInsets.only(top: 30),
                  child: ElevatedButton(
                    child: Text(
                      'Enviar',
                    ),
                    onPressed: () {
                      try {
                        if (_formKey.currentState!.validate()) {
                          UserServices()
                              .mejoras(globalData.getId(), mejoras)
                              .then((val) {
                            print(val.statusCode);
                            if (val.statusCode == 200) {
                              Fluttertoast.showToast(
                                  msg:
                                      'Tu sugerencia ha sido enviada. ¡Muchas gracias!',
                                  toastLength: Toast.LENGTH_SHORT,
                                  timeInSecForIosWeb: 10);
                              _buildPopupDialog(context);
                            } else {
                              Fluttertoast.showToast(
                                  msg: val.status,
                                  toastLength: Toast.LENGTH_SHORT,
                                  timeInSecForIosWeb: 6);
                            }
                          });
                        }
                      } catch (err) {
                        print(err);
                        Fluttertoast.showToast(
                            msg: err.toString(),
                            toastLength: Toast.LENGTH_SHORT,
                            timeInSecForIosWeb: 6);
                      }
                    },
                  ),
                )
              ],
            )));
  }

  Widget _buildPopupDialog(BuildContext context) {
    return new AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      content: new Column(
        mainAxisSize: MainAxisSize.min,
        //  crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text('Quieres añadir una nueva sugerencia?'),
          Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                FlatButton(
                    child: Text('Añadir nueva sugerencia'),
                    shape: StadiumBorder(),
                    color: Colors.green,
                    textColor: Colors.white,
                    onPressed: () {
                      Navigator.of(context).pop();
                    }),
                FlatButton(
                    child: Text('No añadir mas sugerencias'),
                    shape: StadiumBorder(),
                    color: Colors.blueAccent,
                    textColor: Colors.white,
                    onPressed: () {
                      Navigator.of(context).pop();
                      MyNavigator.goToUser(context);
                      build(context);
                    }),
              ])
        ],
      ),
    );
  }
}
