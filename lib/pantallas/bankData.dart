import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart' show timeDilation;
import 'package:fluttertoast/fluttertoast.dart';

class BankDataPage extends StatefulWidget {
  @override
  _BankDataPageState createState() => _BankDataPageState();
}

class _BankDataPageState extends State<BankDataPage> {
  var IBAN;
  var role;
  bool _businessChecked = false;
  bool _storageChecked = false;
  bool _delivererChecked = false;
  @override
  Widget build(BuildContext context) {

    selectBusiness(){
        return Center(
          child: CheckboxListTile(
            title: const Text('Rol Empresa'),
            value: _businessChecked,
            onChanged: (bool? value) {
              setState(() { role = "Business"; _businessChecked = value!; });
            },
            secondary: const Icon(Icons.hourglass_empty),
          ),
        );
      }
      selectStorage(){
        return Center(
          child: CheckboxListTile(
            title: const Text('Rol Almacén'),
            value: _storageChecked,
            onChanged: (bool? value) {
              setState(() { role = "Storage"; _storageChecked = value!; });
            },
            secondary: const Icon(Icons.hourglass_empty),
          ),
        );
      }
      selectDeliverer(){
        return Center(
          child: CheckboxListTile(
            title: const Text('Rol Repartidor'),
            value: _delivererChecked,
            onChanged: (bool? value) {
              setState(() { role = "Deliverer"; _delivererChecked = value!; });
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
          IBAN = val;
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
                if (_delivererChecked){
                  sum = sum +1;
                }
                if (_businessChecked){
                  sum = sum +1;
                }
                if (_storageChecked){
                  sum = sum +1;
                }
                if (sum>1){
                  Fluttertoast.showToast(msg: "Solo un rol. Deselecciona hasta solo tener un rol.");
                }
                else if (sum == 0){
                  Fluttertoast.showToast(msg: "Selecciona al menos un rol.");
                }
                else{
                  Fluttertoast.showToast(msg: "Envio falso de momento");
                }
                if (IBAN == null && !_businessChecked){
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
          createBankInput(),
          sendDataButton(context)
        ],
      ),
    ));
  }
}