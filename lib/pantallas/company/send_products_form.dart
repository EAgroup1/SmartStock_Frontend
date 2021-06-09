import 'package:flutter/material.dart';
import 'package:rlbasic/models/globalData.dart';
import 'package:rlbasic/models/lot.dart';
import 'package:rlbasic/my_navigator.dart';
import 'package:rlbasic/pantallas/login.dart';
import 'package:rlbasic/pantallas/user/listStoredProducts.dart';
import 'dart:core';
import 'package:rlbasic/services/lotServices.dart';

class SendProductsForm extends StatefulWidget {
  const SendProductsForm({Key? key}) : super(key: key);

  @override
  _SendProductsFormState createState() => _SendProductsFormState();
}

class _SendProductsFormState extends State<SendProductsForm> {
  var address, day;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    createAddressInput() {
      return TextFormField(
        decoration: InputDecoration(hintText: 'Dirección de entrega'),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Por favor, introduce un nombre';
          }
        },
        onChanged: (val) {
          print(val);
          address = val;
        },
      );
    }

    createDayInput() {
      return TextFormField(
        decoration: InputDecoration(hintText: 'Dia de entrega'),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Por favor, introduce un nombre';
          }
        },
        onChanged: (val) {
          print(val);
          day = val;
        },
      );
    }

    createEnterButton(BuildContext context) {
      return Container(
          padding: const EdgeInsets.only(top: 30),
          child: ElevatedButton(
              child: Text(
                'Ordenar envio',
              ),
              onPressed: () {}));
    }

      createCancelButton(BuildContext context) {
      return Container(
          padding: const EdgeInsets.only(top: 30),
          child: ElevatedButton(
              child: Text(
                'Cancelar',
              ),
              onPressed: () {}));
    }
    return Material(
        child: Form(
      key: _formKey,
      child: ListView(
        padding: const EdgeInsets.all(30),
        children: <Widget>[
          Image.asset(
            'assets/images/smartstock.jpeg',
            width: 300.00,
            height: 240,
          ),
          createAddressInput(),
          createDayInput(),
          createEnterButton(context),
          createCancelButton(context)
        ],
      ),
    ));
  }
}
