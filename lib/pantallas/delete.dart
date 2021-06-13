import 'package:dio/dio.dart';
import 'package:rlbasic/models/globalData.dart';
import '../my_navigator.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:rlbasic/services/userServices.dart';
import 'package:rlbasic/models/user.dart';
import 'package:rlbasic/services/lotServices.dart';
import 'package:rlbasic/models/lot.dart';
import 'package:rlbasic/services/deliveryServices.dart';
import 'package:rlbasic/models/delivery.dart';

GlobalData globalData = GlobalData.getInstance()!;

class DeletePage extends StatefulWidget {
  @override
  _DeletePageState createState() => _DeletePageState();
}

class _DeletePageState extends State<DeletePage> {
  //final _formKey = GlobalKey<FormState>();

  Dio dioerror = new Dio();

  @override
  Widget build(BuildContext context) {

    divisor() {
      return Container(
          padding: const EdgeInsets.only(top: 5),
          child: Row(children: [
            Expanded(child: Divider(height: 1)),
            Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),),
            Expanded(child: Divider(height: 1))
          ]));
    }
    
    createYesButton(BuildContext context) {
      return Container(
          padding: const EdgeInsets.only(top: 30),
          child: ElevatedButton(
              child: Text(
                'Sí',
              ),
              onPressed: () {
                try {/*
                  try{
                    List<Lot> lots = lotServices().getLotListByUser(globalData.getId());
                    for(var i = 0; i< lots.length; i++){
                      var id = lots[i].id;
                      lotServices().deleteUserOfLot(id);
                    }
                    Fluttertoast.showToast(msg: "Usuario eliminado de lotes");
                    try{
                      List<Delivery> deliveries = DeliveryServices().getDeliveriesUser(globalData.getId());
                      for(var i = 0; i< deliveries.length; i++){
                        var id = deliveries[i].id;
                        DeliveryServices().deleteUserOfDelivery(id);
                      }
                      Fluttertoast.showToast(msg: "Usuario eliminado de entregas");

                    }
                    catch(err){
                      print(err);
                      Fluttertoast.showToast(msg: "No está asignado a ninguna entrega");
                    }
                  }
                  catch(err){
                    print(err);
                    Fluttertoast.showToast(msg: "No está asignado a ningún lote");
                  }
                  */
                  
                  
                  UserServices().eliminateUser(globalData.getId());
                  globalData = new GlobalData();
                  Fluttertoast.showToast(msg: "Hasta luego :(");
                  MyNavigator.goToLogin(context);
                } catch (err) {
                  print(err);
                  Fluttertoast.showToast(
                      msg: err.toString(),
                      toastLength: Toast.LENGTH_SHORT,
                      timeInSecForIosWeb: 6);
                }
              }));
    }
    createNoButton(BuildContext context) {
      return Container(
          padding: const EdgeInsets.only(top: 30),
          child: ElevatedButton(
              child: Text(
                'No',
              ),
              onPressed: () {
                if (globalData.getRole() == "Business"){
                        MyNavigator.goToCompany(context);
                      }else if (globalData.getRole() == "Storage"){
                        MyNavigator.goToUser(context);
                      }else{
                        MyNavigator.goToDeliverer(context);
                      }
              }));
    }







    

    return Material(
        child: Form(
      //key: _formKey,
      child: ListView(
        padding: const EdgeInsets.all(30),
        children: <Widget>[
          Image.asset(
            'assets/images/smartstock.jpeg',
            width: 300.00,
            height: 240,
          ),
          Text("Está seguro de que quiere eliminar su cuenta? Se eliminará para siempre (mucho tiempo!)"),
          divisor(),
          createYesButton(context),
          createNoButton(context),
        ],
      ),
    ));
  }
}
