import 'package:flutter/material.dart';
import 'package:rlbasic/models/globalData.dart';
import 'package:rlbasic/models/lot.dart';
import 'package:rlbasic/my_navigator.dart';
import 'package:rlbasic/services/lotServices.dart';

class StoreProductsPage extends StatefulWidget {
  @override
  _StoreProductsPageState createState() => _StoreProductsPageState();
}


class _StoreProductsPageState extends State<StoreProductsPage> {
  Lot? lotSeleccionado;
  List<Lot> historial = [];

  late var lots = <Lot>[];
  final addCompanyIntoLot = new lotServices();

  GlobalData globalData = GlobalData.getInstance()!;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Añadir productos'),
      ),
      body: _showLots(lots),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            MyNavigator.goToStoreProductsAdd(context);
          },
          child: const Icon(Icons.add)),
    );
  }

  // Widget _lotsadded(List<dynamic> lots) {
  //   // TODO: implement buildSuggestions
  //   //show when someone searches for something
  //   final allLots = new lotServices();
  //   return FutureBuilder(
  //     future: allLots.getAllLotsSorted(),
  //     builder: (_, AsyncSnapshot snapshot) {
  //       if (snapshot.hasData) {
  //         return _showLots(snapshot.data);
  //       } else {
  //         return Center(child: CircularProgressIndicator(strokeWidth: 4));
  //       }
  //     },
  //   );
  // }

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
                    leading: Icon(Icons.arrow_right),
                    title: Text('${lots[i].name}'),
                    subtitle: Text('Id del producto: ${lots[i].id}'),
                  )
                ])));
      },
    );
  }

  Widget _buildPopupDialog(BuildContext context, Lot lot) {
    final bool value;
    final Function onChange;

    return new AlertDialog(
      title: const Text('Información detallada del envio'),
      content: new SingleChildScrollView(
        // mainAxisSize: MainAxisSize.min,
        // crossAxisAlignment: CrossAxisAlignment.start,
        child: ListBody(
          children: <Widget>[
            Text("Nombre del producto: " + lot.name),
            Text("Dimension: " + lot.dimensions),
            Text("Peso: " + lot.weight),
            Text("Cantidad: " + lot.qty.toString()),
            Text("Cantidad mínima" + lot.minimumQty.toString()),
            Text("Precio/unidad: " + lot.price.toString()),
            Text("Frágil: " + lot.isFragile.toString())
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
