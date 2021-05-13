import 'package:flutter/cupertino.dart';
import 'package:rlbasic/models/_aux.dart';
import 'package:flutter/material.dart';
import 'package:rlbasic/models/delivery.dart';
import 'package:rlbasic/my_navigator.dart';
import 'package:rlbasic/services/deliveryServices.dart';

class DeliveryMenu extends StatelessWidget {
  final String id;
  DeliveryMenu({required this.id});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home:Scaffold(
        appBar: AppBar(
        title: Text('My Stored Products'),
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
                  Navigator.of(context).pushNamed("");
                }),
            ListTile(
                leading: Icon(Icons.motorcycle),
                title: Text('Productos para entregar'),
                onTap: () {
                  Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => DeliveryMenu(id: id)),
                        );
                 // MyNavigator.goToUserDeliveryMenu(context);
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
        body:DeliveryMenuScreen(id: id),
    ),
    );
    
  }
}

class DeliveryMenuScreen extends StatelessWidget {
  final String id;
  DeliveryMenuScreen({required this.id});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            bottom: TabBar(
              indicatorColor: Colors.white,
              tabs: [
                Tab(text: 'GET READY', icon: Icon(Icons.alarm_add)),
                Tab(text: 'PRODUCT TO PICK UP', icon: Icon(Icons.alarm_on)),
              ],
            ),
          ),
          body: TabBarView(
            children: [
              Center(child: GetReady(id: id)),
              Center(child: PickUp(id: id)),
            ],
          ),
        ),
      ),
    );
  }
}

class GetReady extends StatelessWidget {
  final String id;
  GetReady({required this.id});
  //CAMBIAR A LISTA DE LOTES
  late var deliveries = <Delivery>[];
  final deliveryService = new DeliveryServices();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: deliveryService.getDeliveriesUser(id),
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        if (snapshot.hasError) {
          return ListTile(
              title: Text('No hay nada que coincida con lo que has escrito'));
        }
        if (snapshot.hasData) {
          this.deliveries = snapshot.data;
          return buildList(context);
        } else {
          return Center(child: CircularProgressIndicator(strokeWidth: 4));
        }
      },
    );
  }

  @override
  Widget buildList(BuildContext context) {
    return ListView.builder(
      itemCount: deliveries.length,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            showDialog(
              context: context,
              //CAMBIAR POR LOTE
              builder: (BuildContext context) =>
                  _buildPopupDialog(context, deliveries[index]),
            );
          },
          child: Card(
            clipBehavior: Clip.antiAlias,
            child: Column(
              children: [
                ListTile(
                  leading: Icon(Icons.arrow_right),
                  title: Text('${deliveries[index].businessItem.userName}'),
                  subtitle:
                      Text('Pick up day: ${deliveries[index].deliveryDate}'),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}

class PickUp extends StatelessWidget {
  final String id;
  PickUp({required this.id});
  //CAMBIAR A LISTA DE LOTES
  // ignore: deprecated_member_use
  late var deliveries = <Delivery>[];
  final deliveryService = new DeliveryServices();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: deliveryService.getDeliveriesUser(id),
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        if (snapshot.hasError) {
          return ListTile(
              title: Text('No hay nada que coincida con lo que has escrito'));
        }
        if (snapshot.hasData) {
          this.deliveries = snapshot.data;
          return buildList(context);
        } else {
          return Center(child: CircularProgressIndicator(strokeWidth: 4));
        }
      },
    );
  }

  @override
  Widget buildList(BuildContext context) {
    return ListView.builder(
      itemCount: deliveries.length,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            showDialog(
              context: context,
              //CAMBIAR POR LOTE
              builder: (BuildContext context) =>
                  _buildPopupDialog(context, deliveries[index]),
            );
          },
          child: Card(
            clipBehavior: Clip.antiAlias,
            child: Column(
              children: [
                ListTile(
                  leading: Icon(Icons.av_timer),
                  title: Text('${deliveries[index].businessItem.userName}'),
                  subtitle:
                      Text('Pick up day: ${deliveries[index].deliveryDate}'),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}

Widget _buildPopupDialog(BuildContext context, Delivery delivery) {
  final bool value;
  final Function onChange;

  return new AlertDialog(
    title: const Text('TO BE READY'),
    content: new Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text('Items to add:'),
        /*  CheckboxListTile(
          title: Text('nombre de items'),
          secondary: Text('numero de items'),
          value: value,
          onChanged: (bool? newValue) {
            onChanged(newValue);
          },
        ) */
      ],
    ),
    actions: <Widget>[
      new FlatButton(
        onPressed: () {
          Navigator.of(context).pop();
        },
        textColor: Theme.of(context).primaryColor,
        child: const Text('Close'),
      ),
    ],
  );
}

class Menu extends StatelessWidget {
  final Aux aux = new Aux("id", "token", "userName");
  //final Aux aux;
  // DeliveryMenu({required this.aux});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(aux.userName, semanticsLabel: "Bienvenido"),
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
                  Navigator.of(context).pushNamed("");
                }),
            ListTile(
                leading: Icon(Icons.motorcycle),
                title: Text('Productos para entregar'),
                onTap: () {
                  MyNavigator.goToUserDeliveryMenu(context);
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
    );
  }
}
