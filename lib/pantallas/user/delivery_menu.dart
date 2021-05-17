import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rlbasic/models/delivery.dart';
import 'package:rlbasic/models/globalData.dart';
import 'package:rlbasic/models/lot.dart';
import 'package:rlbasic/my_navigator.dart';
import 'package:rlbasic/services/deliveryServices.dart';

GlobalData globalData = GlobalData.getInstance()!;

class DeliveryMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
      body: DeliveryMenuScreen(),
    );
  }
}

class DeliveryMenuScreen extends StatelessWidget {
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
              Center(child: GetReady()),
              Center(child: PickUp()),
            ],
          ),
        ),
      ),
    );
  }
}

class GetReady extends StatelessWidget {
  //CAMBIAR A LISTA DE LOTES
  late var deliveries = <Delivery>[];
  final deliveryService = new DeliveryServices();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: deliveryService.getDeliveriesUser(globalData.getId()),
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
                  _buildPopupDialog(context, deliveries[index].lot),
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
  //CAMBIAR A LISTA DE LOTES
  // ignore: deprecated_member_use
  late var deliveries = <Delivery>[];
  final deliveryService = new DeliveryServices();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: deliveryService.getReadyDeliveries(globalData.getId()),
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        if (snapshot.hasError) {
          return ListTile(
              title: Text('Se ha producido un error :('));
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
                  _buildPopupDialog(context, deliveries[index].lot),
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

Widget _buildPopupDialog(BuildContext context, Lot lot) {
  final bool value;
  final Function onChange;

  return new AlertDialog(
    title: const Text('TO BE READY'),
    content: new Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text('Items to add:'),
        ListTile(
          leading: Icon(Icons.add_circle_outline),
          title: Text(lot.name),
          subtitle: Text(lot.info),
          trailing: Text(lot.qty.toString()),
        )
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(globalData.userName, semanticsLabel: "Bienvenido"),
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
