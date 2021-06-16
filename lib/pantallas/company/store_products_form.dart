import 'dart:convert';
import 'dart:html';

import 'package:dio/dio.dart';
import 'package:flutter/services.dart';
import 'package:rlbasic/models/globalData.dart';
import 'package:rlbasic/models/lot.dart';
import 'package:rlbasic/models/user.dart';
import 'package:rlbasic/pantallas/splashScreen.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:rlbasic/services/lotServices.dart';
import 'package:rlbasic/services/userServices.dart';

import '../../my_navigator.dart';

GlobalData globalData = GlobalData.getInstance()!;

class StoreProductsForm extends StatefulWidget {
  @override
  _StoreProductsFormState createState() => _StoreProductsFormState();
}

class _StoreProductsFormState extends State<StoreProductsForm> {
  var name, id, dimensions, info, weight, qty, minimumQty, price, businessItem;

  bool isFragile = false;
  bool _isLoading = false;
  TextEditingController _nameController = TextEditingController();
  TextEditingController _dimensionsController = TextEditingController();
  TextEditingController _weightController = TextEditingController();
  TextEditingController _qtyController = TextEditingController();
  TextEditingController _priceController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final addCompanyIntoLot = new LotServices();
  var splashScreen = SplashScreen();
  Dio dioerror = new Dio();

  @override
  Widget build(BuildContext context) {
    createNameInput() {
      return TextFormField(
        decoration: InputDecoration(hintText: 'Nombre'),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Por favor, introduce un nombre';
          }
        },
        onChanged: (val) {
          print(val);
          name = val;
        },
      );
    }

    createDimensionsInput() {
      return TextFormField(
        decoration: InputDecoration(hintText: 'Dimensiones'),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Por favor, introduce las dimensiones del producto';
          }
        },
        onChanged: (val) {
          dimensions = val;
        },
      );
    }

    createPriceInput() {
      return TextFormField(
        decoration: InputDecoration(hintText: 'Precio'),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Por favor, introduce el precio';
          }
        },
        onChanged: (val) {
          price = val;
        },
      );
    }

    createWeightInput() {
      return TextFormField(
        decoration: InputDecoration(hintText: 'Peso'),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Por favor, introduce el peso';
          }
        },
        onChanged: (val) {
          print(val);
          weight = val;
        },
      );
    }

    createQuantityInput() {
      return TextFormField(
        decoration: InputDecoration(hintText: 'Cantidad'),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Por favor, introduce una cantidad';
          }
        },
        onChanged: (val) {
          qty = val;
        },
      );
    }

    createMinQuantityInput() {
      return TextFormField(
        decoration: InputDecoration(hintText: 'Cantidad mínima'),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Por favor, introduce una cantidad';
          }
        },
        onChanged: (val) {
          minimumQty = val;
        },
      );
    }

    createisFragileInput() {
      return SwitchListTile(
        title: const Text('¿Frágil?'),
        value: isFragile,
        onChanged: (value) {
          setState(() {
            isFragile = value;
            print(isFragile);
          });
        },
        activeTrackColor: Colors.yellow,
        activeColor: Colors.orangeAccent,
      );
    }

    createEnterButton(BuildContext context) {
      return Container(
          padding: const EdgeInsets.only(top: 30),
          child: ElevatedButton(
              child: Text(
                'Crear',
              ),
              onPressed: () {
                try {
                  if (_formKey.currentState!.validate()) {
                    LotServices()
                        .postLot(name, dimensions, weight, qty, minimumQty,
                            price, isFragile, globalData.id)
                        .then((val) {
                      print(val.data);
                      print(val.statusCode);
                      if (val.statusCode == 200) {
                        globalData.setName(name);
                        globalData.setDimensions(dimensions);
                        globalData.setWeight(weight);
                        globalData.setQuantity(qty);
                        globalData.setMinQuantity(minimumQty);
                        globalData.setPrice(price);
                        globalData.setisFragile(isFragile);
                        Fluttertoast.showToast(
                            msg: 'Creado correctamente',
                            toastLength: Toast.LENGTH_SHORT,
                            timeInSecForIosWeb: 6);
                        MyNavigator.goToStoreProducts(context);
                      } else if (val.statusCode == 401) {
                        Fluttertoast.showToast(
                            msg: 'Error',
                            toastLength: Toast.LENGTH_SHORT,
                            timeInSecForIosWeb: 6);
                      } else {
                        Fluttertoast.showToast(
                            msg: 'Algo no va bien',
                            toastLength: Toast.LENGTH_SHORT,
                            timeInSecForIosWeb: 6);
                      }
                    });
                  }
                } catch (err) {
                  print(err);
                  Fluttertoast.showToast(
                      msg: err.toString(),
                      toastLength: Toast.LENGTH_SHORT,
                      timeInSecForIosWeb: 6);
                }
              }));
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
          createNameInput(),
          createDimensionsInput(),
          createWeightInput(),
          createQuantityInput(),
          createMinQuantityInput(),
          createPriceInput(),
          createisFragileInput(),
          createEnterButton(context)
        ],
      ),
    ));
  }
}
