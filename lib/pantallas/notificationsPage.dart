import 'package:flutter/material.dart';
import '../../my_navigator.dart';
import 'package:rlbasic/models/globalData.dart';
import 'package:rlbasic/models/lot.dart';
import 'dart:core';
import 'package:rlbasic/services/lotServices.dart';

GlobalData globalData = GlobalData.getInstance()!;

class MyPushPageMenu extends StatefulWidget {
  MyPushPageMenu({Key? key}) : super(key: key);

  @override
  _MyPushPageMenuState createState() => _MyPushPageMenuState();
}

class _MyPushPageMenuState extends State<MyPushPageMenu> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
          appBar: AppBar(title: Text("Mis Notificaciones")),
          body: MyPushPage(),
    ));
  }
}


class MyPushPage extends StatefulWidget {
  MyPushPage({Key? key}) : super(key: key);

  @override
  _MyPushPageState createState() => _MyPushPageState();
}

class _MyPushPageState extends State<MyPushPage> {
  late var notifications = <Notification>[];
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //created list
    List<Lot> lots;
    final lotService = new LotServices();

    print("entra en el futurebuilder");
    return FutureBuilder(
      future: lotService.getLotListByUser(globalData.getId()),
      builder: (context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          print("ha pasado por la lista");
          lots = snapshot.data;
          if (lots.isNotEmpty) {
            return _buildList(lots);
          } else {
            return Center(
                child: Text(
              'No existe ningún lote almacenado de este usuario',
            ));
          }
        }

        else if (snapshot.hasError) {
          return ListTile(title: Text('Ha habido un error :('));
        }
         else {
          return Center(child: CircularProgressIndicator(strokeWidth: 4));
        }
      },
    );
  }

  Widget _buildList(List<dynamic> lots) {
     
      return ListView.builder(
        itemCount: lots.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              showDialog(
                context: context,
                builder: (BuildContext context) =>
                    _buildPopupDialog(context, lots[index]),
              ).then((result) {
                print(result);
              });
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

  Widget _buildPopupDialog(BuildContext context, Lot lot) {
    final bool value;
    final Function onChange;

    return new AlertDialog(
      title: const Text('Info del lote almacenado'),
      content: new SingleChildScrollView(
        child: ListBody(
          children: <Widget>[
            Text("Nombre del lote: " + lot.name),
            Text("Cantidad: " + lot.qty),
            Text("Precio/unidad: " + lot.price),
            Text("Compañía: " + lot.businessItem.userName)
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