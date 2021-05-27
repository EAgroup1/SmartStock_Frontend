import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../services/lotServices.dart';
//import '../../services/userServices.dart';
import '../../my_navigator.dart';
import 'package:rlbasic/models/globalData.dart';
import 'package:rlbasic/models/lot.dart';
import 'dart:core';
import 'package:rlbasic/services/lotServices.dart';

GlobalData globalData = GlobalData.getInstance()!;

//we define a fake list ---> commented
//List <String> lots = ["zapatillas", "gorra", "camisa", "polo"];

// //Scaffold Class
// class ListProdPage extends StatelessWidget {
//   //we'll see required or nullable
//   ListProdPage({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return new MaterialApp(
//       title: 'My Products',
//       theme: new ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: new MyProdPage(title: 'My Lot List'),
//     );
//   }
// }

class MyProdPage extends StatefulWidget {
  MyProdPage({Key? key}) : super(key: key);

  @override
  _MyProdPageState createState() => _MyProdPageState();
}

class _MyProdPageState extends State<MyProdPage> {

  //we use these variables
  Lot? selectedLot;

  List<Lot> lotHistory = [];

  //DataSearch search = new DataSearch();

  late var lots = <Lot>[];

  GlobalData globalData = GlobalData.getInstance()!;

  //widgets

  //show list of products jona
  Widget _showLots(List<dynamic> lots) {
    return ListView.builder(
      itemCount: lots.length,
      itemBuilder: (context, i) {
        return GestureDetector(
            onTap: () {
              showDialog(
                context: context,
                builder: (BuildContext context) =>
                    _buildPopupDialog(context, lots[i]),
              );
            },
            child: Card(
                clipBehavior: Clip.antiAlias,
                child: Column(children: [
                  ListTile(
                    leading: Icon(Icons.arrow_right),
                    title: Text('${lots[i].name}'),
                    subtitle: Text('Informacion: ${lots[i].info}'),
                  )
                ])));
      },
    );
  }  


  //pop-up jona
  Widget _buildPopupDialog(BuildContext context, Lot lot) {
    final bool value;
    final Function onChange;

    return new AlertDialog(
      title: const Text('Información del lote'),
      content: new SingleChildScrollView(
        child: ListBody(
          children: <Widget>[
            Text("Nombre del lote: " + lot.name),
            Text("Cantidad: " + lot.qty.toString()),
            Text("Precio/unidad: " + lot.price.toString()),
            Text("Compañia: " + lot.businessItem.toString())
          ],
        ),
      ),
      actions: <Widget>[
        new FlatButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          textColor: Theme.of(context).primaryColor,
          child: const Text('Cerrar'),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    //implement two widgets that we have created
    //first we put the top structure
    return MaterialApp(
      title: 'List stored products',
      home: Scaffold(
        appBar: AppBar(
          title: Text('My store products'),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.euro_symbol),
              onPressed: (){
                MyNavigator.goToChartsLotList(context);
              }
            ),
            _showLots(lots),
            _buildPopupDialog(context, selectedLot!),
          ]
        )
      )
    );
  }
}


