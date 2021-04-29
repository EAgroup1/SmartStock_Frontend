import 'package:flutter/material.dart';

class TermsAndConditionsPage extends StatefulWidget {
  @override
  _TermsAndConditionsPageState createState() => _TermsAndConditionsPageState();
}

class _TermsAndConditionsPageState extends State<TermsAndConditionsPage> {
  @override
  Widget build(BuildContext context) {

     return Scaffold(
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        children: <Widget>[
          Image.asset(
            'assets/images/smartstock.jpeg',
            width: 300.00,
            height: 240,
          ),
          
        ],
      ),
    );
  }

  }