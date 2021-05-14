import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:rlbasic/models/_aux.dart';
import 'package:rlbasic/models/lot.dart';
import 'package:rlbasic/models/user.dart';
import 'dart:core';
import 'package:rlbasic/my_navigator.dart';
import 'package:rlbasic/services/lotServices.dart';
import 'package:flutter_svg/svg.dart';

class SearchProductsPage extends StatefulWidget {
  @override
  _SearchProductsPageState createState() => _SearchProductsPageState();
}

class _SearchProductsPageState extends State<SearchProductsPage> {

  Lot? lotSeleccionado;

  List<Lot> historial = [];


  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (lotSeleccionado != null) Text(lotSeleccionado!.name),
          MaterialButton(
              child: Text('Buscar productos',
                  style: TextStyle(color: Colors.white)),
              shape: StadiumBorder(),
              elevation: 0,
              splashColor: Colors.transparent,
              color: Colors.blue,
              onPressed: () async {
                final lote = await showSearch(
                    context: context,
                    delegate: DataSearch('Buscar...', historial));

                setState(() {
                  this.lotSeleccionado = lote!;
                  this.historial.insert(0, lote);
                });
              })
        ],
      )),
    );
  }
}

class DataSearch extends SearchDelegate<Lot?> {
  /*  final cosas = ["Item", "Quantity"];
  final cosas2 = ["Zapatos", "20"]; */
  final String searchFieldLabel;
  final List<Lot> historialot;

  DataSearch(this.searchFieldLabel, this.historialot);

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
        });
  }

  @override
  Widget buildResults(BuildContext context) {
    // TODO: implement buildResults
    //show some result based on the selction
    print(query);

    if (query.trim().length == 0) {
      return Text('Has clickado enter y no has introducido texto. Para volver a ver los productos haz click derecho');
    }
    final lotservices = new lotServices();
    
    return FutureBuilder(
      future: lotservices.getLot(query),
      builder: (_, AsyncSnapshot snapshot) {
        if (snapshot.hasError) {
          return ListTile(
              title: Text('No hay nada que coincida con lo que has escrito'));
        }
        if (snapshot.hasData) {
          return _showLots(snapshot.data);
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
      future: allLots.getAllLots(),
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
        var lote = lots[i];

        return ListTile(
          title: Text(lote.name, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
          subtitle: Text(lote.info.toString()),
          trailing: Icon(Icons.keyboard_arrow_right),
          onTap: () {
            this.close(context, lote);
          },
          dense: true,
          selected: false,
          enabled: true,
        );
      },
    );
  }
}
