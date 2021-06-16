import 'package:flutter/material.dart';
import '../../my_navigator.dart';
import 'package:rlbasic/models/globalData.dart';
import 'package:rlbasic/models/lot.dart';
import 'dart:core';
import 'package:rlbasic/services/lotServices.dart';

GlobalData globalData = GlobalData.getInstance()!;
List listOptions = ["listAscPriceSort", "listAscQtySort"];
// String _selectedOption;

class MyProdPageMenu extends StatelessWidget {
  const MyProdPageMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //lateral menu
    return MaterialApp(
        home: Scaffold(
      appBar: AppBar(
        title: Text("Tu lista de Lotes"),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.euro_symbol),
            onPressed: (){
              MyNavigator.goToChartsLotList(context);
            },
          )
        ]
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text(
                'Perfil',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
                leading: Icon(Icons.add_business_rounded),
                title: Text('Buscar productos'),
                onTap: () {
                  MyNavigator.goToSearchProducts(context);
                }),
            ListTile(
                leading: Icon(Icons.apartment),
                title: Text('Mis productos almacenados'),
                onTap: () {
                  //we comment this because this is the list of lots about one user
                  MyNavigator.goToLotList(context);
                }),
            ListTile(
                leading: Icon(Icons.motorcycle),
                title: Text('Productos para entregar'),
                onTap: () {
                  MyNavigator.goToUserDeliveryMenu(context);
                }),
            ListTile(
                leading: Icon(Icons.message),
                title: Text('Chat'),
                onTap: () {
                  MyNavigator.goToWebChatHomepage(context);
                }),
            ListTile(
                leading: Icon(Icons.account_circle),
                title: Text('Configuración'),
                onTap: () {
                  MyNavigator.goToConfigUser(context);
                }),
          ],
        ),
      ),
      body: new Container(
        child: new Column(
          children: [
            //begin one widget
            new Container(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Container(
                  padding: EdgeInsets.only(left:16, right: 16),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey, width: 1),
                    borderRadius: BorderRadius.circular(15)
                  ),
                  // child: DropdownButton(
                  //   hint: Text("Order list by:"),
                  //   dropdownColor: Colors.white,
                  //   icon: Icon(Icons.arrow_drop_down),
                  //   iconSize: 36,
                  //   isExpanded: true,
                  //   underline: SizedBox(),
                  //   style: TextStyle(
                  //     color: Colors.black,
                  //     fontSize: 22
                  //   ),
                  //   value: listOptions,
                  //   onChanged: (newValue) {
                  //     setState(() {
                  //       listOptions = newValue;
                  //     });
                  //   },
                  // ),
                ),
              ),
            ),
            //begin other widget
            new Container(
              child: MyProdPage(),
            ),
          ],
        ),
      ),
    ));
  }
}

//another stateless widget to indicate the behavior of the view
class MyProdPageMenuScreen extends StatelessWidget {
  const MyProdPageMenuScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      //we need sort here
      child: MyProdPage(),
    );
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

  @override
  Widget build(BuildContext context) {
    //created list
    final lotService = new LotServices();
    List<Lot> lots;

    print("entra en el futurebuilder");
    return FutureBuilder(
      future: lotService.getLotListByUser(globalData.getId()),
      builder: (context, AsyncSnapshot snapshot) {
        if (snapshot.hasError) {
          return ListTile(title: Text('Ha habido un error :('));
        }
        if (snapshot.hasData) {
          print("ha pasado por la lista");
          lots = snapshot.data;
          if (lots.isEmpty) {
            print("uno");
            return Center(child: Text("No tienes lotes almacenados ¡Empieza a almacenar!"));
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
      return Center(child: Text("No tienes lotes almacenados ¡Empieza a almacenar!"));
    } else {
      return ListView.builder(
        itemCount: lots.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              showDialog(
                context: context,
                builder: (BuildContext context) => _buildPopupDialog(context, lots[index]),
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
                    subtitle:
                        Text('${lots[index].qty}'),
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


