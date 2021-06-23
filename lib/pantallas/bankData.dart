import 'package:flutter/material.dart';
import 'package:rlbasic/models/_aux.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:rlbasic/services/place_service.dart';
import 'package:rlbasic/services/userServices.dart';
import 'package:rlbasic/pantallas/user/user.dart';
import 'package:uuid/uuid.dart';

import '../my_navigator.dart';

String address = "Paseo de los Naranjos 20B Castelldefels";
PlaceApi _placeApi = PlaceApi.instance;


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

  final _controller = TextEditingController();
  String _streetNumber = '';
  String _street = '';
  String _city = '';
  String _zipCode = '';
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

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

    address() {
      return Column(
        children: <Widget>[
          TextField(
            controller: _controller,
            readOnly: true,
            onTap: () async {
              /* 
                // generate a new token here
                final sessionToken = Uuid().v4();
                final Suggestion? result = await showSearch(
                  context: context,
                
                  delegate: AddressSearch(sessionToken),
                );
                // This will change the text displayed in the TextField
                if (result != null) {
                  final placeDetails = await PlaceApiProvider(sessionToken)
                      .getPlaceDetailFromId(result.placeId);
                  setState(() {
                    _controller.text = result.description;
                    _streetNumber = placeDetails.streetNumber;
                    _street = placeDetails.street;
                    _city = placeDetails.city;
                    _zipCode = placeDetails.zipCode;
                  });
                } */
            },
            // with some styling
            decoration: InputDecoration(
              icon: Container(
                margin: EdgeInsets.only(left: 20),
                width: 10,
                height: 10,
                child: Icon(
                  Icons.home,
                  color: Colors.black,
                ),
              ),
              hintText: "Direccion postal",
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(left: 8.0, top: 16.0),
            ),
          ),
          
            SizedBox(height: 20.0),
            Text('Street Number: $_streetNumber'),
            Text('Street: $_street'),
            Text('City: $_city'),
            Text('ZIP Code: $_zipCode'),
        ],
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
                }
                if (address == "Paseo de los Naranjos 20B Castelldefels") {
                  Fluttertoast.showToast(msg: "Añade una dirección");
                } else if (sum == 0) {
                  Fluttertoast.showToast(msg: "Selecciona al menos un rol.");
                } else {
                  _placeApi.location(address).then((value) {});
                  UserServices()
                      .sendBankRole(globalData.getId(), bank, role, address)
                      .then((val) {}); //NO FUNCIONA AUN
                  //Fluttertoast.showToast(msg: "Envio falso de momento");
                  globalData.location = address;
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
              hintText: address,
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
