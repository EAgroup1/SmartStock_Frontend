import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
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

class GetReady extends StatefulWidget {
  @override
  _GetReadyState createState() => _GetReadyState();
}

class _GetReadyState extends State<GetReady> {
  //CAMBIAR A LISTA DE LOTES
  late var deliveries = <Delivery>[];
  @override
  void initState() {
    super.initState();
  }

  final deliveryService = new DeliveryServices();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: deliveryService.getDeliveriesUser(globalData.getId()),
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        if (snapshot.hasError) {
          return ListTile(title: Text('Ha habido un error :('));
        }
        if (snapshot.hasData) {
          this.deliveries = snapshot.data;
          if (deliveries.isEmpty) {
            return Center(
                child: Text(
                    "Aquí se añadiran todos los paquetes que debes ir preparando para que lo pasen a recoger"));
          } else
            return buildList(context);
        } else {
          return Center(child: CircularProgressIndicator(strokeWidth: 4));
        }
      },
    );
  }

  Widget buildList(BuildContext context) {
    if (deliveries.isEmpty) {
      return Center(
          child: Text(
              "Aquí se añadiran todos los paquetes que debes ir preparando para que lo pasen a recoger"));
    } else {
      return ListView.builder(
        itemCount: deliveries.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              showDialog(
                context: context,
                builder: (BuildContext context) => _buildPopupDialog(context,
                    deliveries[index].lot, deliveries[index].id, index),
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

  Widget _buildPopupDialog(BuildContext context, Lot lot, String id, int num) {
    final bool value;
    final Function onChange;

    return new AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      title: const Text('TO BE READY'),
      content: new Column(
        mainAxisSize: MainAxisSize.min,
        //  crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text('Items to add:'),
          ListTile(
            leading: Icon(Icons.add_circle_outline),
            title: Text(lot.name),
            subtitle: Text(lot.info),
            trailing: Text(lot.qty.toString()),
          ),
          Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                FlatButton(
                    child: Text('Cancel'),
                    shape: StadiumBorder(),
                    color: Colors.green,
                    textColor: Colors.white,
                    onPressed: () {
                      Navigator.of(context).pop();
                    }),
                FlatButton(
                    child: Text('Is Ready'),
                    shape: StadiumBorder(),
                    color: Colors.blueAccent,
                    textColor: Colors.white,
                    onPressed: () {
                      print(id);
                      DeliveryServices().setReadyDelivery(id).then((val) {
                        if (val.statusCode == 200) {
                          print('de momento todo ok');
                          Navigator.of(context).pop();
                          MyNavigator.goToUserDeliveryMenu(context);
                          build(context);
                        } else {
                          print('Algo ha ido mal, pruebalo mas tarde...');
                        }
                      });
                    }),
              ])
        ],
      ),
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
          return ListTile(title: Text('Se ha producido un error :('));
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

  Widget buildList(BuildContext context) {
    if (deliveries.isEmpty) {
      return Center(
          child: Text(
              "Aquí apareceran los paquetes que ya has preparado ya han de ser recogidos por un repartidor"));
    } else {
      return ListView.builder(
        itemCount: deliveries.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              showDialog(
                context: context,
                //CAMBIAR POR LOTE
                builder: (BuildContext context) =>
                    _buildPopupDialog(context, deliveries[index].time),
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

  Widget _buildPopupDialog(BuildContext context, String time) {
    late String info;
    if (time == "")
      info = "Aun no se ha determinado hora de recogida";
    else
      info = time;
    return new AlertDialog(
        title: Text('Tu pedido sera recogido a las'),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        content: Text(info),
        actions: [
          FlatButton(
              child: Text('okey'),
              shape: StadiumBorder(),
              color: Colors.green,
              textColor: Colors.white,
              onPressed: () {
                Navigator.of(context).pop();
              }),
        ]);
  }
}
