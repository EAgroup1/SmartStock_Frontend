import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'dart:core';

class EntrarPage extends StatefulWidget {
  @override
  _EntrarPageState createState() => _EntrarPageState();
}

class _EntrarPageState extends State<EntrarPage> {
  List<Widget> datosUsuario = [];

    getUser() async {
      var url = Uri.parse("http://localhost:4000/");
      var response = await http.get(url);
      debugPrint(response.body);
    }

    @override
    initState() {
      super.initState();
      getUser();
    }


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(title: Text('Datos del usuario')),
    );
  }
}
