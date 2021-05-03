import 'package:flutter/material.dart';

class CrearPage extends StatefulWidget {
  @override
  _CrearPageState createState() => _CrearPageState();
  static final nombrePage = 'crear';
}

class _CrearPageState extends State<CrearPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
      title: Text('Registrar Usuario'),
    ));
  }
}
