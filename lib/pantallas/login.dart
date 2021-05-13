import 'package:rlbasic/models/_aux.dart';
import 'package:rlbasic/models/user.dart';
import 'package:rlbasic/pantallas/splashScreen.dart';
import 'package:rlbasic/services/deliveryServices.dart';
import '../my_navigator.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:rlbasic/pantallas/user/user.dart';
import 'package:rlbasic/services/userServices.dart';
import 'user/user.dart';
import 'splashScreen.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  //final _formKey = GlobalKey<FormState>();
  var email, password;
  bool _isLoading = false;
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  var splashScreen = SplashScreen();

  @override
  Widget build(BuildContext context) {
    createEmailInput() {
      return TextFormField(
        decoration: InputDecoration(hintText: 'Email'),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Por favor, introduce un email';
          }
        },
        onChanged: (val) {
          email = val;
        },
      );
    }

    createPasswordInput() {
      return TextFormField(
        decoration: InputDecoration(hintText: 'Contraseña'),
        controller: _passController,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Por favor, introduce una contraseña';
          }
        },
        obscureText: true,
        onChanged: (val) {
          password = val;
        },
      );
    }

    createLoginButton(BuildContext context) {
      return Container(
          padding: const EdgeInsets.only(top: 30),
          child: ElevatedButton(
              child: Text(
                'Entrar',
              ),
              onPressed: () {
                try {
                  if (_formKey.currentState!.validate()) {
                    UserServices().login(email, password).then((val) {
                      print(val.data);
                      print(val.statusCode);
                      if (val.statusCode == 200) {
                        Aux aux = new Aux(
                            val.data['_id'],
                            val.data['token'],
                            val.data['userName']);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => UserPage(aux: aux)),
                        );
                        //MyNavigator.goToUser(context);
                        Fluttertoast.showToast(
                            msg: 'Logged successfully',
                            toastLength: Toast.LENGTH_SHORT,
                            timeInSecForIosWeb: 6);
                      } else if (val.statusCode == 401) {
                        Fluttertoast.showToast(
                            msg: 'Email o contraseña incorrectos',
                            toastLength: Toast.LENGTH_SHORT,
                            timeInSecForIosWeb: 6);
                      } else {
                        Fluttertoast.showToast(
                            msg: val.status,
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

    createLinks() {
      return ButtonBar(
        children: <Widget>[
          Container(
            padding: const EdgeInsets.all(16.0),
            child: TextButton(
              child: Text('¿Has olvidado la contraseña?'),
              onPressed: () {
             //   DeliveryServices().getdeliveriesUser("609c29591c34f216f043c43d");
          //      UserServices().login(email, password)
               // MyNavigator.goToTerms(context);
              },
            ),
          ),
          Container(
            padding: const EdgeInsets.all(16.0),
            child: TextButton(
              child: Text('Registrarse'),
              onPressed: () {
                MyNavigator.goToRegister(context);
              },
            ),
          )
        ],
      );
    }

    divisor() {
      return Container(
          padding: const EdgeInsets.only(top: 5),
          child: Row(children: [
            Expanded(child: Divider(height: 1)),
            Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Text('ó')),
            Expanded(child: Divider(height: 1))
          ]));
    }

    facebookButton() {
      return Container(
          padding: const EdgeInsets.only(top: 32),
          child: RaisedButton(
            textColor: Colors.white,
            color: Colors.blue,
            child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              Icon(FontAwesomeIcons.facebookSquare),
              Padding(
                padding: const EdgeInsets.only(left: 32),
                child: Text('Entrar con Facebook', textAlign: TextAlign.center),
              )
            ]),
            onPressed: () {},
          ));
    }

    googleButton() {
      return Container(
          padding: const EdgeInsets.only(top: 32),
          child: RaisedButton(
            textColor: Colors.white,
            color: Colors.blue,
            child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              Icon(FontAwesomeIcons.google),
              Padding(
                padding: const EdgeInsets.only(left: 32),
                child: Text('Entrar con Google', textAlign: TextAlign.center),
              )
            ]),
            onPressed: () {},
          ));
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
          createEmailInput(),
          createPasswordInput(),
          createLoginButton(context),
          createLinks(),
          divisor(),
          facebookButton(),
          googleButton()
        ],
      ),
    ));
  }
}
