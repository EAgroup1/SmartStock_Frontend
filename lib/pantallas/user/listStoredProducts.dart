import 'package:flutter/material.dart';
import '../../my_navigator.dart';
import 'package:rlbasic/models/globalData.dart';
import 'package:rlbasic/models/lot.dart';
import 'dart:core';
import 'package:rlbasic/services/lotServices.dart';

GlobalData globalDataa = GlobalData.getInstance()!;

class MyProdPageMenu extends StatelessWidget {
  const MyProdPageMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //lateral menu
    return MaterialApp(
        home: Scaffold(
      appBar: AppBar(title: Text("Tu lista de Lotes"), actions: <Widget>[
        IconButton(
          icon: Icon(Icons.euro_symbol),
          onPressed: () {
            MyNavigator.goToChartsLotList(context);
          },
        )
      ]),
      body: MyProdPage(),
    ));
  }
}

class MyProdPage extends StatefulWidget {
  MyProdPage({Key? key}) : super(key: key);

  @override
  _MyProdPageState createState() => _MyProdPageState();
}

class _MyProdPageState extends State<MyProdPage> {
  late var lots = <Lot>[];
  @override
  void initState() {
    super.initState();
  }

  final lotService = new lotServices();

  @override
  Widget build(BuildContext context) {
    //created list
    List<Lot> lots;

    print("entra en el futurebuilder");
    return FutureBuilder(
      future: lotService.getLotListByUser(globalDataa.getId()),
      builder: (context, AsyncSnapshot snapshot) {
        if (snapshot.hasError) {
          return ListTile(title: Text('Ha habido un error :('));
        }
        if (snapshot.hasData) {
          print("ha pasado por la lista");
          lots = snapshot.data;
          if (lots.isEmpty) {
            print("uno");
            return Center(
                child:
                    Text("No tienes lotes almacenados ¡Empieza a almacenar!"));
          } else
            return buildList(context);
        } else {
          return Center(child: CircularProgressIndicator(strokeWidth: 4));
        }
      },
    );
  }

  Widget buildList(BuildContext context) {
    if (lots.isEmpty) {
      print("tres");
      return Center(
          child: Text("No tienes lotes almacenados ¡Empieza a almacenar!"));
    } else {
      return ListView.builder(
        itemCount: lots.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              showDialog(
                context: context,
                builder: (BuildContext context) =>
                    _buildPopupDialog(context, lots[index]),
              );
            },
            child: Card(
              clipBehavior: Clip.antiAlias,
              child: Column(
                children: [
                  ListTile(
                    //move_to_inbox(lots in house) or inbox or al_inbox(command)
                    leading: Icon(Icons.inbox),
                    title: Text('${lots[index].name}'),
                    subtitle: Text('${lots[index].qty}'),
                  )
                ],
              ),
            ),
          );
        },
      );
    }
  }

  Widget _buildPopupDialog(BuildContext context, Lot lot) {
    final bool value;
    final Function onChange;

    return new AlertDialog(
      title: const Text('Info del lote almacenado'),
      content: new SingleChildScrollView(
        child: ListBody(
          children: <Widget>[
            Text("Nombre del lote: " + lot.name),
            Text("Cantidad: " + lot.qty.toString()),
            Text("Precio/unidad: " + lot.price.toString()),
            Text("Compañía: " + lot.businessItem.userName.toString())
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
}
