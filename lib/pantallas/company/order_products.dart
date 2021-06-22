import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:rlbasic/models/delivery.dart';
import 'package:rlbasic/models/globalData.dart';
import 'package:rlbasic/models/lot.dart';
import 'package:rlbasic/my_navigator.dart';
import 'package:rlbasic/pantallas/deliverer/mapa.dart';
import 'package:rlbasic/pantallas/user/salaryStoredProducts.dart';
import 'package:rlbasic/services/deliveryServices.dart';
import 'package:rlbasic/services/lotServices.dart';
import 'package:rlbasic/services/place_service.dart';
import 'package:rlbasic/services/userServices.dart';

class OrderProductsPage extends StatefulWidget {
  const OrderProductsPage({Key? key}) : super(key: key);

  @override
  _OrderProductsPageState createState() => _OrderProductsPageState();
}

class _OrderProductsPageState extends State<OrderProductsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.grey,
          title: Text('Enviar productos'),
        ),
        body: buildSuggestions(context));
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // TODO: implement buildSuggestions
    //show when someone searches for something
    final users = new UserServices();
    return FutureBuilder(
      future: users.getUserByStorageRol(),
      builder: (context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          return _showUsers(snapshot.data);
        } else {
          return Center(child: CircularProgressIndicator(strokeWidth: 4));
        }
      },
    );
  }

  Widget _showUsers(List<dynamic> users) {
    lotServices lts = new lotServices();
    return ListView.builder(
      itemCount: users.length,
      itemBuilder: (context, i) {
        return GestureDetector(
            onTap: () {
              globalData.setUserItem(users[i].id);
              MyNavigator.goToOrderProducts2(context);
            },
            child: Card(
                clipBehavior: Clip.antiAlias,
                child: Column(children: [
                  ListTile(
                    leading: Icon(Icons.arrow_right),
                    title: Text('${users[i].userName}'),
                    subtitle: Text('Ubicación: ${users[i].location}'),
                  )
                ])));
      },
    );
  }
}
