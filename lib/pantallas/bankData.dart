import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart' show timeDilation;
import 'package:fluttertoast/fluttertoast.dart';

class BankDataPage extends StatefulWidget {
  @override
  _BankDataPageState createState() => _BankDataPageState();
}

class _BankDataPageState extends State<BankDataPage> {
  var IBAN;
  
  @override
  Widget build(BuildContext context) {

    selectBusiness(){
        return Center(
          child: CheckboxListTile(
            title: const Text('Rol Empresa'),
            value: timeDilation != 1.0,
            onChanged: (bool? value) {
              setState(() { timeDilation = value! ? 2.0 : 1.0; });
            },
            secondary: const Icon(Icons.hourglass_empty),
          ),
        );
      }
      selectStorage(){
        return Center(
          child: CheckboxListTile(
            title: const Text('Rol Almacén'),
            value: timeDilation != 1.0,
            onChanged: (bool? value) {
              setState(() { timeDilation = value! ? 2.0 : 1.0; });
            },
            secondary: const Icon(Icons.hourglass_empty),
          ),
        );
      }
      selectDeliverer(){
        return Center(
          child: CheckboxListTile(
            title: const Text('Rol Repartidor'),
            value: timeDilation != 1.0,
            onChanged: (bool? value) {
              setState(() { timeDilation = value! ? 2.0 : 1.0; });
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
                Fluttertoast.showToast(msg:"Envio falso de momento");
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