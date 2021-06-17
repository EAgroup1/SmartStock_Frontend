import 'package:flutter/material.dart';
import 'package:rlbasic/models/_aux.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:rlbasic/pantallas/place_service.dart';
import 'package:rlbasic/services/userServices.dart';
import 'package:rlbasic/pantallas/user/user.dart';
import 'package:uuid/uuid.dart';

import '../my_navigator.dart';

String address = "Paseo de los Naranjos 20B Castelldefels";

class BankDataPage extends StatefulWidget {
  @override
  _BankDataPageState createState() => _BankDataPageState();
}

class _BankDataPageState extends State<BankDataPage> {
  var bank;
  var role;
  bool _businessChecked = false;
  bool _storageChecked = false;
  bool _delivererChecked = false;

  //nuevo codigo util
  final _destinationController = TextEditingController();
  PlaceApi _placeApi = PlaceApi.instance;
  bool buscando = false;
  List<Place> _predictions = [];

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _destinationController.dispose();
    super.dispose();
  }

  _inputOnChanged(String query) {
    if (query.trim().length > 2) {
      setState(() {
        buscando = true;
      });
      _search(query);
    } else {
      if (buscando || _predictions.length > 0) {
        setState(() {
          buscando = false;
          _predictions = [];
        });
      }
    }
  }

  _search(String query) {
    _placeApi
        .searchPredictions(query)
        .asStream()
        .listen((List<Place>? predictions) {
      if (Icons.batch_prediction_sharp != null) {
        setState(() {
          buscando = false;
          _predictions = predictions ?? [];
          print('Resultados: ${predictions!.length}');
        });
      }
    });
  }

  //

  final _controller = TextEditingController();
  String _streetNumber = '';
  String _street = '';
  String _city = '';
  String _zipCode = '';
/*   @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  } */

  @override
  Widget build(BuildContext context) {
    selectBusiness() {
      return Center(
        child: CheckboxListTile(
          title: const Text('Rol Empresa'),
          value: _businessChecked,
          onChanged: (bool? value) {
            setState(() {
              role = "Business";
              _businessChecked = value!;
            });
          },
          secondary: const Icon(Icons.hourglass_empty),
        ),
      );
    }

    selectStorage() {
      return Center(
        child: CheckboxListTile(
          title: const Text('Rol Almacén'),
          value: _storageChecked,
          onChanged: (bool? value) {
            setState(() {
              role = "Storage";
              _storageChecked = value!;
            });
          },
          secondary: const Icon(Icons.hourglass_empty),
        ),
      );
    }

    selectDeliverer() {
      return Center(
        child: CheckboxListTile(
          title: const Text('Rol Repartidor'),
          value: _delivererChecked,
          onChanged: (bool? value) {
            setState(() {
              role = "Deliverer";
              _delivererChecked = value!;
            });
          },
          secondary: const Icon(Icons.hourglass_empty),
        ),
      );
    }

    createBankInput() {
      return TextFormField(
        decoration: InputDecoration(hintText: 'IBAN'),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Pon tus datos bancarios';
          }
        },
        onChanged: (val) {
          bank = val;
        },
      );
    }

    sendDataButton(BuildContext context) {
      return Container(
          padding: const EdgeInsets.only(top: 30),
          child: ElevatedButton(
              child: Text(
                'Confirmar datos',
              ),
              onPressed: () {
                var sum = 0;
                if (_delivererChecked) {
                  sum = sum + 1;
                }
                if (_businessChecked) {
                  sum = sum + 1;
                }
                if (_storageChecked) {
                  sum = sum + 1;
                }
                if (sum > 1) {
                  Fluttertoast.showToast(
                      msg:
                          "Solo un rol. Deselecciona hasta solo tener un rol.");
                } else if (sum == 0) {
                  Fluttertoast.showToast(msg: "Selecciona al menos un rol.");
                } else {
                  UserServices()
                      .sendBankRole(globalData.getId(), bank, role)
                      .then((val) {}); //NO FUNCIONA AUN
                  //Fluttertoast.showToast(msg: "Envio falso de momento");
                  if (_delivererChecked) {
                    MyNavigator.goToDeliverer(context);
                  } else if (_businessChecked) {
                    MyNavigator.goToCompany(context);
                  } else if (_storageChecked) {
                    MyNavigator.goToUser(context);
                  }
                }
                if (bank == null && !_businessChecked) {
                  Fluttertoast.showToast(msg: "Introduce tu IBAN");
                }
              }));
    }

    return Material(
        child: Form(
            child: Center(
      child: ListView(
        //   padding: EdgeInsets.symmetric(horizontal: 30.0),
        //crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Image.asset(
            'assets/images/smartstock.jpeg',
            width: 300.00,
            height: 240,
          ),
          SizedBox(height: 16),
          selectBusiness(),
          SizedBox(height: 16),
          selectStorage(),
          SizedBox(height: 16),
          selectDeliverer(),
          SizedBox(height: 16),
          Row(children: [
            Icon(
              Icons.location_on,
              size: 18,
              color: Colors.black,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Container(
                height: 35.0,
                width: MediaQuery.of(context).size.width / 1.4,
                alignment: Alignment.center,
                padding: EdgeInsets.only(left: 10.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5.0),
                  color: Colors.grey[100],
                ),
                child: TextField(
                    readOnly: true,
                    decoration: InputDecoration.collapsed(
                      hintText: address,
                    ),
                    onTap: () async {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Address()));
                    }),
              ),
            ),
          ]),

          //address(),
          SizedBox(height: 16),
          createBankInput(),
          SizedBox(height: 16),
          sendDataButton(context)
        ],
      ),
    )));
  }
}

class AddressInput extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final void Function(String) onChanged;

  const AddressInput({
    required this.controller,
    required this.hintText,
    required this.onChanged,
  });
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Container(
            height: 35.0,
            width: MediaQuery.of(context).size.width / 1.4,
            alignment: Alignment.center,
            padding: EdgeInsets.only(left: 10.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5.0),
              color: Colors.grey[100],
            ),
            child: TextField(
              controller: controller,
              onChanged: onChanged,
              decoration: InputDecoration.collapsed(
                hintText: hintText,
              ),
            ),
          ),
        )
      ],
    );
  }
}

class Address extends StatefulWidget {
  @override
  _AddressState createState() => _AddressState();
}

class _AddressState extends State<Address> {
  final _destinationController = TextEditingController();
  PlaceApi _placeApi = PlaceApi.instance;
  bool buscando = false;
  List<Place> _predictions = [];

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _destinationController.dispose();
    super.dispose();
  }

  _inputOnChanged(String query) {
    if (query.trim().length > 2) {
      setState(() {
        buscando = true;
      });
      _search(query);
    } else {
      if (buscando || _predictions.length > 0) {
        setState(() {
          buscando = false;
          _predictions = [];
        });
      }
    }
  }

  _search(String query) {
    _placeApi
        .searchPredictions(query)
        .asStream()
        .listen((List<Place>? predictions) {
      // ignore: unnecessary_null_comparison
      if (Icons.batch_prediction_sharp != null) {
        setState(() {
          buscando = false;
          _predictions = predictions ?? [];
          print('Resultados: ${predictions?.length}');
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Introduzca su direccion",
          style: TextStyle(
              fontSize: 15.0, color: Colors.black, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.white,
        leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: Colors.black,
            ),
            onPressed: () {}),
        bottom: PreferredSize(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
            child: AddressInput(
              controller: _destinationController,
              hintText: " Ej: Paseo de los Naranjos 20C",
              onChanged: this._inputOnChanged,
            ),
          ),
          preferredSize: Size.fromHeight(70),
        ),
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        child: Column(
          children: [
            buscando
                ? Expanded(
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  )
                : Expanded(
                    child: ListView.builder(
                        itemCount: _predictions.length,
                        itemBuilder: (_, i) {
                          final Place item = _predictions[i];
                          return GestureDetector(
                              onTap: () {
                                setState(() {
                                  address = item.description;
                                  _placeApi.location(address).then((value) {
                                    print(value!.latitude.toString());
                                  });
                                });
                                Navigator.pop(context);
                              },
                              child: ListTile(
                                title: Text(item.description),
                                leading: Icon(Icons.location_on),
                              ));
                        }))
          ],
        ),
      ),
    );
  }
}
