import 'package:flutter/material.dart';
import 'package:rlbasic/models/globalData.dart';
import 'package:rlbasic/models/lot.dart';
import 'package:rlbasic/my_navigator.dart';
import 'package:rlbasic/pantallas/login.dart';
import 'package:rlbasic/pantallas/user/listStoredProducts.dart';
import 'dart:core';
import 'package:rlbasic/services/lotServices.dart';


class SearchMyStorageProductsPage extends StatefulWidget {
  @override
  _SearchMyStorageProductsPageState createState() => _SearchMyStorageProductsPageState();
}

class _SearchMyStorageProductsPageState extends State<SearchMyStorageProductsPage> {

  DataSearch search = new DataSearch();

  GlobalData globalData = GlobalData.getInstance()!;
  
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Stored Products' + globalData.userName),
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
    //show some result based on the selection
    return Container();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // TODO: implement buildSuggestions
    //show when someone searches for something
    final allLotsByBusiness = new LotServices();
    List<Lot> lot;

    return FutureBuilder(
      future: allLotsByBusiness.getLotListByBusiness(GlobalData.getInstance()!.getId()),
      builder: (context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          lot = snapshot.data;
          List<Lot?> suggestions = query.isEmpty 
                 ? lot  
                 : lot
               .where((element) =>
                  element.name.toLowerCase().contains(query.toLowerCase()))
                  .toList(); 
              // &&
              // element.name.toLowerCase().startsWith(query.toLowerCase()))
                     
          print(suggestions);
          return _showLots(suggestions);
        } else {
          return Center(child: CircularProgressIndicator(strokeWidth: 4));
        }
      },
    );

      // itemBuilder: (context, index) => ListTile(
      //   onTap: () {
      //     close(context, suggestions[index]);
      //   },
      //   leading: Icon(IconData(57627, fontFamily: 'MaterialIcons')),
      //   title: RichText(
      //     text: TextSpan(
      //         text: suggestions[index].substring(0, query.length),
      //         style: TextStyle(
      //             color: Colors.black,
      //             fontWeight: FontWeight.bold,
      //             fontSize: 17),
      //         children: [
      //           TextSpan(
      //               text: suggestions[index].substring(query.length),
      //               style: TextStyle(color: Colors.grey))
      //         ]),
      //   ),
      // ),
      //   itemCount: suggestions.length,
      // );
  }
}

  Widget _showLots(List<dynamic> lots) {
    return ListView.builder(
      itemBuilder: (context, i) {
        return GestureDetector(
            onTap: () {
              showDialog(
                context: context,
                builder: (BuildContext context) =>
                    _buildPopupDialog(context, lots[i]),
              ).then((result) {
                print(result);
              });
            },
            child: Card(
                clipBehavior: Clip.antiAlias,
                child: Column(
                  children: [
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
      itemCount: lots.length,
    );
  }

  Widget _buildPopupDialog(BuildContext context, Lot lot) {
    
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
            //Text("User: " + lot.userItem.userName),
            
          ],
        ),
      ),
      
    );
  }

