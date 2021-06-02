import 'package:flutter/material.dart';
import 'package:rlbasic/my_navigator.dart';
import 'package:rlbasic/pantallas/company/config_company.dart';
import 'package:rlbasic/services/userServices.dart';
//initially, NOT required

class ChangeEmailPage extends StatefulWidget {
  const ChangeEmailPage({Key? key}) : super(key: key);

  @override
  _ChangeEmailPageState createState() => _ChangeEmailPageState();
}

class _ChangeEmailPageState extends State<ChangeEmailPage> {
  UserServices user = new UserServices();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cambiar email',
      home: Scaffold(
        //on these initial screens there aren't appBar
        // appBar: AppBar(
        //   title: Text('Material App Bar'),
        // ),
        body: SizedBox(
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              //be careful with the size of the top image
              Image.asset(
                'assets/images/logoSmartStock.jpeg',
                width: 300.00,
                height: 240,
              ),
              TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Nuevo email',
                ),
              ),
              TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Confirma el email',
                ),
              ),

              //After that we show the floatingButton (not this type!!) ---> in progress
              TextButton(
                onPressed: () {
                  user.updateUser(globalData.id);
                  MyNavigator.goToConfigUser(context);
                },
                child: Text("Login"),
              )
            ],
          ),
        ),
      ),
    );
  }
}
