import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../services/lotServices.dart';
//import '../../services/userServices.dart';
import '../../my_navigator.dart';
import 'package:rlbasic/models/globalData.dart';
import 'package:rlbasic/models/lot.dart';
import 'dart:core';
import 'package:rlbasic/services/lotServices.dart';

//we define a fake list ---> commented
//List <String> lots = ["zapatillas", "gorra", "camisa", "polo"];

//Scaffold Class
class ListProdPage extends StatelessWidget {
  //we'll see required or nullable
  ListProdPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'My Products',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: new MyProdPage(title: 'My Lot List'),
    );
  }
}

class MyProdPage extends StatefulWidget {
  MyProdPage({Key? key, required this.title}) : super(key: key);

  //variable title
  final String title;

  @override
  _MyProdPageState createState() => _MyProdPageState();
}

class _MyProdPageState extends State<MyProdPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: new Text(widget.title),
      ),
      body: Container (
      ),
    );
  }
}


