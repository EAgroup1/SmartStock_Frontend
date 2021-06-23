import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:rlbasic/models/delivery.dart';
import 'package:rlbasic/models/globalData.dart';
import 'package:rlbasic/models/lot.dart';
import 'package:rlbasic/models/user.dart';
import 'package:rlbasic/my_navigator.dart';
import 'package:rlbasic/pantallas/deliverer/mapa.dart';
//import 'package:rlbasic/pantallas/user/salaryStoredProducts.dart';
import 'package:rlbasic/services/deliveryServices.dart';
import 'package:rlbasic/services/lotServices.dart';
import 'package:rlbasic/models/lot.dart';
import 'package:rlbasic/services/place_service.dart';
import 'package:rlbasic/services/userServices.dart';

import '../login.dart';

class OrderProducts2Page extends StatefulWidget {
  const OrderProducts2Page({Key? key}) : super(key: key);

  @override
  _OrderProducts2PageState createState() => _OrderProducts2PageState();
}

class _OrderProducts2PageState extends State<OrderProducts2Page> {
  DeliveryServices delivery = new DeliveryServices();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.grey,
          title: Text('Enviar productos'),
        ),
        body: buildSuggestions2(context));
  }

  Widget buildSuggestions2(BuildContext context) {
    LotServices lots = new LotServices();
    return FutureBuilder(
      future: lots.getLotListByUser(globalData.getUserItem()),
      builder: (context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          return _showUsersProducts(snapshot.data);
        } else {
          return Center(child: CircularProgressIndicator(strokeWidth: 4));
        }
      },
    );
  }

  Widget _showUsersProducts(List<dynamic> lots) {
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
                    leading: Icon(Icons.arrow_right),
                    title: Text('${lots[i].name}'),
                    subtitle: Text('Id: ${lots[i].id}'),
                  )
                ])));
      },
    );
  }

  Widget _buildPopupDialog(BuildContext context, Lot lot) {
    final bool value;

    final Function onChange;
    return new AlertDialog(
      title: const Text('Información detallada del producto'),
      content: new SingleChildScrollView(
        // mainAxisSize: MainAxisSize.min,
        // crossAxisAlignment: CrossAxisAlignment.start,
        child: ListBody(
          children: <Widget>[
            Text("Nombre del producto: " + lot.name),
            Text("Dimension: " + lot.dimensions),
            Text("Peso: " + lot.weight),
            Text("Cantidad: " + lot.qty.toString()),
            Text("Cantidad mínima: " + lot.minimumQty.toString()),
            Text("Precio/unidad: " + lot.price.toString()),
            Text("Frágil: " + lot.isFragile.toString()),
            // Text("Compañia: " + .info),
            //trailing: Text("Cantidad: " + lot.qty.toString()),
          ],
        ),
      ),
      actions: <Widget>[
        Text("¿Pedir producto?"),
        new FlatButton(
          onPressed: () {
            delivery.createDelivery(lot.id, globalData.id).then((val) {
              //delivery.setCasa(val.data['_id']);
              //globalData.setUserItem(val.data['userItem']);
            });
            MyNavigator.goToOrderProducts2(context);
          },
          textColor: Theme.of(context).primaryColor,
          child: const Text('Enviar'),
        ),
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
