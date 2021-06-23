import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:rlbasic/models/delivery.dart';
import 'package:rlbasic/models/globalData.dart';
import 'package:rlbasic/models/lot.dart';
import 'package:rlbasic/services/deliveryServices.dart';
import 'package:rlbasic/services/lotServices.dart';

class SendProductsPage extends StatefulWidget {
  @override
  _SendProductsPageState createState() => _SendProductsPageState();
}

class _SendProductsPageState extends State<SendProductsPage> {
  Lot? lotSeleccionado;

  List<Lot> historial = [];

  late var lots = <Lot>[];

  GlobalData globalData = GlobalData.getInstance()!;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey,
        title: Text('Envio de productos'),
      ),
      body: _lottosend(lots),
    );
  }

  Widget _lottosend(List<dynamic> lots) {
    // TODO: implement buildSuggestions
    //show when someone searches for something
    final allLots = new LotServices();
    return FutureBuilder(
      future: allLots.getLotListByBusinessInProgressStored(globalData.id),
      builder: (_, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          return _showLots(snapshot.data);
        } else {
          return Center(child: CircularProgressIndicator(strokeWidth: 4));
        }
      },
    );
  }

  Widget _showLots(List<dynamic> lots) {
    return ListView.builder(
      itemCount: lots.length,
      itemBuilder: (context, i) {
        return GestureDetector(
            onTap: () {
              showDialog(
                context: context,
                //CAMBIAR POR LOTE
                builder: (BuildContext context) =>
                    _buildPopupDialog(context, lots[i]),
              );
            },
            child: Card(
                clipBehavior: Clip.antiAlias,
                child: Column(children: [
                  ListTile(
                    leading: Icon(
                      Icons.query_builder,
                      semanticLabel: 'Stored in progress',
                      color: Colors.orange,
                      size: 40.0,
                    ),
                    title: Text('${lots[i].name}',
                        style: new TextStyle(
                            fontFamily: 'Roboto',
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87)),
                    subtitle: RichText(
                      textAlign: TextAlign.start,
                      text: TextSpan(children: <TextSpan>[
                        /* TextSpan(
                                  text: "Lot stored:\n",
                                  style: TextStyle(
                                    color: Colors.black87,
                                    fontWeight: FontWeight.bold, 
                                    fontFamily: 'AbrilFatface')), */
                        /* TextSpan(
                                  text: "User: ${lots[i].userItem.userName.toUpperCase()}\n",
                                  style: TextStyle(
                                  color: Colors.black87,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Roboto')), */
                        TextSpan(
                            text: "In progress",
                            style: TextStyle(
                                color: Colors.redAccent[700],
                                fontSize: 10.0,
                                /*  decoration: TextDecoration.underline,
                                  decorationColor: Colors.deepOrange[700], */
                                fontWeight: FontWeight.bold,
                                fontFamily: 'AbrilFatface')),
                      ]),
                      /*  Text('Lot stored in progress for: ${lots[i].userItem.userName}', 
                        style: new TextStyle(
                        fontFamily: 'AbrilFatface',
                        fontSize: 14.0,
                        fontWeight: FontWeight.bold, 
                        color: Colors.yellowAccent)
                        ),  */
                    ),
                  ),
                ])));
      },
    );
  }

  Widget _buildPopupDialog(BuildContext context, Lot lot) {
    final bool value;
    final Function onChange;
    final DeliveryServices a = new DeliveryServices();

    return new AlertDialog(
      title: const Text('Información detallada del envio'),
      content: new SingleChildScrollView(
        // mainAxisSize: MainAxisSize.min,
        // crossAxisAlignment: CrossAxisAlignment.start,
        child: ListBody(
          children: <Widget>[
            Text("Recogido: " + lot.picked.toString()),
            Text("Entregado: " + lot.delivered.toString()),
            // Text("Compañia: " + .info),
            //trailing: Text("Cantidad: " + lot.qty.toString()),
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
