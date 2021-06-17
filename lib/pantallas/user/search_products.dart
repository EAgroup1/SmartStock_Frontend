import 'package:flutter/material.dart';
import 'package:rlbasic/models/globalData.dart';
import 'package:rlbasic/models/lot.dart';
import 'package:rlbasic/my_navigator.dart';
import 'package:rlbasic/pantallas/login.dart';
import 'package:rlbasic/pantallas/user/listStoredProducts.dart';
import 'dart:core';
import 'package:rlbasic/services/lotServices.dart';
import 'package:rlbasic/services/deliveryServices.dart';

class SearchProductsPage extends StatefulWidget {
  @override
  _SearchProductsPageState createState() => _SearchProductsPageState();
}

class _SearchProductsPageState extends State<SearchProductsPage> {
  Lot? lotSeleccionado;
  List<Lot> historial = [];
  DataSearch search = new DataSearch();
  late var lots = <Lot>[];
  GlobalData globalData = GlobalData.getInstance()!;

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Buscar productos'),
        actions: <Widget>[
          IconButton(
              onPressed: () {
                showSearch(context: context, delegate: DataSearch());
              },
              icon: Icon(Icons.search)),
        ],
      ),
      body: search.buildSuggestions(context),
    );
  }
}

class DataSearch extends SearchDelegate<Lot?> {
  late List<Lot?> lot;
  @override
  List<Widget> buildActions(BuildContext context) {
    // TODO: implement buildActions
    //actions for appbar
    return [
      IconButton(
          icon: Icon(Icons.clear),
          onPressed: () {
            this.query = '';
          })
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    // TODO: implement buildLeading
    //leading icon on the left of the appbar
    return IconButton(
        icon: AnimatedIcon(
            icon: AnimatedIcons.menu_arrow, progress: transitionAnimation),
        onPressed: () {
          this.close(context, null);
          MyNavigator.goToSearchProducts(context);
        });
  }

  @override
  Widget buildResults(BuildContext context) {
    // TODO: implement buildResults
    //show some result based on the selction
    final lotservices = new lotServices();
    List<Lot> lot;
    if (query.trim().length == 0) {
      return Center(
          child: Text(
        'Introduce un producto para filtrar',
      ));
    } else {
      return FutureBuilder(
          future: lotservices.getAllLotsSorted(),
          builder: (context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              lot = snapshot.data;
              List<Lot?> results = lot
                  .where((element) =>
                      element.name.toLowerCase() == query.toLowerCase())
                  .toList();
              if (results.isNotEmpty) {
                return _showLots(results);
              } else {
                return Center(
                    child: Text(
                  'No existe ningún lote con este nombre',
                ));
              }
            } else {
              return Center(child: CircularProgressIndicator(strokeWidth: 4));
            }
          });
    }
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // TODO: implement buildSuggestions
    //show when someone searches for something
    final allLots = new lotServices();
    List<Lot> lot;
    return FutureBuilder(
      future: allLots.getAllLotsSorted(),
      builder: (context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          lot = snapshot.data;
          List<Lot?> suggestions = query.isEmpty
              ? lot
              : lot
                  .where((element) =>
                      element.name.toLowerCase().contains(query.toLowerCase()))
                  .toList();

          print(suggestions);
          return _showLots(suggestions);
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
                barrierDismissible: false,
                builder: (BuildContext context) =>
                    _buildPopupDialog(context, lots[i]),
              ).then((result) {
                print(result);
              });
            },
            child: Card(
                clipBehavior: Clip.antiAlias,
                child: Column(children: [
                  ListTile(
                    leading: Icon(Icons.arrow_right),
                    title: Text('${lots[i].name}'),
                    subtitle: Text('Cantidad: ${lots[i].qty}'),
                    // title: Text(
                    //   lote.name,
                    //   style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    // ),
                    // subtitle: Text(lote.info.toString()),
                    // trailing: Icon(Icons.keyboard_arrow_right),
                    // onTap: () {
                    //   this.close(context, lote);
                    // },
                    // dense: true,
                    // selected: false,
                    // enabled: true,
                  )
                ])));
      },
    );
  }

  Widget _buildPopupDialog(BuildContext context, Lot lot) {
    final addUserIntoLot = new lotServices();
    final delivery = new DeliveryServices();
    return new AlertDialog(
      title: const Text('Información detallada del producto'),
      content: new SingleChildScrollView(
        child: ListBody(
          children: <Widget>[
            Text("Nombre del producto: " + lot.name),
            Text("Descripción: " + lot.info),
            Text("Cantidad: " + lot.qty.toString()),
            Text("Precio/unidad: " + lot.price.toString() + "€"),
            Text("Cantidad minima: " + lot.minimumQty.toString()),
            Text("Empresa: " + lot.businessItem.userName)
          ],
        ),
      ),
      actions: <Widget>[
        Text("¿Quieres guardarlo en tu casa?"),
        new FlatButton(
          onPressed: () {
            Navigator.of(context).pop('Accept');
            addUserIntoLot.addNewLotToUser(lot.id, globalData.id);
            final delivery = new DeliveryServices();
            delivery.createDelivery(lot.id, globalData.id);
            MyNavigator.goToSearchProducts(context);
            delivery.createDelivery(lot, globalData.id);
          },
          textColor: Theme.of(context).primaryColor,
          child: const Text('Accept'),
        ),
        new FlatButton(
          onPressed: () {
            Navigator.of(context).pop('Cancel');
          },
          textColor: Theme.of(context).primaryColor,
          child: const Text('Cancel'),
        ),
      ],
    );
  }
}
