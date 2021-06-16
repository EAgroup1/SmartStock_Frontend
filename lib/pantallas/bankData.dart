import 'package:flutter/material.dart';
import 'package:rlbasic/models/_aux.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:rlbasic/services/place_service.dart';
import 'package:rlbasic/services/userServices.dart';
import 'package:rlbasic/pantallas/user/user.dart';
import 'package:uuid/uuid.dart';

import '../my_navigator.dart';

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
                } else if (sum == 0) {
                  Fluttertoast.showToast(msg: "Selecciona al menos un rol.");
                } else {
                  globalData.setRole(role);
                  UserServices().sendBankRole(globalData.getId(), bank, role).then((val){}); //NO FUNCIONA AUN
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
      child: Column(
        //   padding: EdgeInsets.symmetric(horizontal: 30.0),
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Image.asset(
            'assets/images/smartstock.jpeg',
            width: 300.00,
            height: 240,
          ),
          selectBusiness(),
          selectStorage(),
          selectDeliverer(),
          //address(),
          createBankInput(),
          sendDataButton(context)
        ],
      ),
    ));
  }
}

class AddressSearch extends SearchDelegate<Suggestion?> {
  AddressSearch(this.sessionToken) {
    apiClient = PlaceApiProvider(sessionToken);
  }

    final sessionToken;
  late PlaceApiProvider apiClient;

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        tooltip: 'Clear',
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      tooltip: 'Back',
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        this.close(context, null);
      });
  }

  @override
  Widget buildResults(BuildContext context) {
    return Container();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return FutureBuilder(
      // We will put the api call here
      future: query == ""
          ? null
          : apiClient.fetchSuggestions(
              query, Localizations.localeOf(context).languageCode),
      builder: (context, snapshot) => query == ''
          ? Container(
              padding: EdgeInsets.all(16.0),
              child: Text('Enter your address'),
            )
          : snapshot.hasData
              ? ListView.builder(
                  itemBuilder: (context, index) => ListTile(
                    /* title:Text((snapshot.data[index] as Suggestion).description),
                    onTap: () {
                      close(context, snapshot.data[index] as Suggestion);
                    }, */
                  ),
                //  itemCount: snapshot.data.length,
                )
              : Container(child: Text('Loading...')),
    );
  }
}