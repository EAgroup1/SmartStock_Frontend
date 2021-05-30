import 'package:flutter/material.dart';
import 'package:rlbasic/models/globalData.dart';
import 'package:rlbasic/models/lot.dart';
import 'package:rlbasic/my_navigator.dart';
import 'package:rlbasic/pantallas/login.dart';
import 'package:rlbasic/pantallas/user/listStoredProducts.dart';
import 'dart:core';
import 'package:rlbasic/services/lotServices.dart';

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

  // final String searchFieldLabel;
  // final List<Lot> historialot;

  // _SearchProductsPageState(this.searchFieldLabel, this.historialot);

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
          //search._showLots(lots)
        ],
      ),
      body: search.buildSuggestions(context),
      // body: Center(
      //   child: Column(
      //   mainAxisAlignment: MainAxisAlignment.center,
      //   children: [
      //     if (lotSeleccionado != null) Text(lotSeleccionado!.name),
      // MaterialButton(
      //     child: Text('Buscar productos',
      //         style: TextStyle(color: Colors.white)),
      //     shape: StadiumBorder(),
      //     elevation: 0,
      //     splashColor: Colors.transparent,
      //     color: Colors.blue,
      //     onPressed: () async {
      // final lote = showSearch(
      //             context: context,
      //             delegate: DataSearch('Buscar...', historial));

      // setState(() {
      //   this.lotSeleccionado = lote!;
      //   this.historial.insert(0, lote);
      // });
      //     ]})
      //   )),
      // );
    );
  }
}

class DataSearch extends SearchDelegate<Lot?> {
  /*  final cosas = ["Item", "Quantity"];
  final cosas2 = ["Zapatos", "20"]; */

  //DataSearch(this.searchFieldLabel, this.historialot);
  late List<Lot?> lot;

  @override
  List<Widget> buildActions(BuildContext context) {
    // TODO: implement buildActions
    //actions for appbar
    //
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
        });
  }

  @override
  Widget buildResults(BuildContext context) {
    // TODO: implement buildResults
    //show some result based on the selction
    final lotservices = new lotServices();
    print(query);
    if (query.trim().length == 0) {
      return ListTile(title: Text('Introduce un producto para filtrar'));
    }

    return FutureBuilder(
      future: lotservices.getLot(query),
      builder: (context, AsyncSnapshot snapshot) {
        lot = snapshot.data;
        if (lot.isNotEmpty) {
          return _showLots(snapshot.data);
        }
        if (lot.isEmpty) {
          return ListTile(
              title: Text('No hay nada que coincida con lo que has escrito'));
        } else {
          return Center(child: CircularProgressIndicator(strokeWidth: 4));
        }
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // TODO: implement buildSuggestions
    //show when someone searches for something
    final allLots = new lotServices();
    return FutureBuilder(
      future: allLots.getAllLotsSorted(),
      builder: (context, AsyncSnapshot snapshot) {
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
                barrierDismissible: false,
                //CAMBIAR POR LOTE
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
                    subtitle: Text('Informacion: ${lots[i].info}'),
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
  //print(globalData.id);
  final bool value;
  final Function onChange;
  final addUserIntoLot = new lotServices();
  return new AlertDialog(
    title: const Text('Información detallada del producto'),
    content: new SingleChildScrollView(
      // mainAxisSize: MainAxisSize.min,
      // crossAxisAlignment: CrossAxisAlignment.start,
      child: ListBody(
        children: <Widget>[
          Text("Nombre del producto: " + lot.name),
          Text("Descripción: " + lot.info),
          Text("Cantidad: " + lot.qty.toString()),
          Text("Precio/unidad: " + lot.price.toString() + "€"),
          Text("Cantidad minima: " + lot.minimumQty.toString()),
          Text("Empresa: " + lot.businessItem.userName)
          // Text("Compañia: " + .info),
          //trailing: Text("Cantidad: " + lot.qty.toString()),
        ],
      ),
    ),
    actions: <Widget>[
      Text("Do you want to store this in your warehouse?"),
      new FlatButton(
        onPressed: () {
          
        addUserIntoLot.addNewLotToUser(lot.id, globalData.id);
        Navigator.of(context).pop('Accept');
        MyNavigator.goToSearchProducts(context);
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