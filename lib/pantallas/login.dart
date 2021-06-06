import 'package:dio/dio.dart';
import 'package:rlbasic/models/globalData.dart';
import 'package:rlbasic/models/user.dart';
import 'package:rlbasic/pantallas/splashScreen.dart';
import 'package:rlbasic/pantallas/user/mapa.dart';
import '../my_navigator.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:rlbasic/services/userServices.dart';
import 'user/user.dart';
import 'splashScreen.dart';

GlobalData globalData = GlobalData.getInstance()!;

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
  User user = User('', '', '', '', '');
  Dio dioerror = new Dio();

  @override
  Widget build(BuildContext context) {
    createEmailInput() {
      return TextFormField(
        decoration: InputDecoration(hintText: 'Email'),
        controller: TextEditingController(text: user.email),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Por favor, introduce un email';
          } else if (RegExp(
                  r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
              .hasMatch(value)) {
            return null;
          } else {
            return 'Introduce un correo válido';
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
                        globalData.setId(val.data['_id']);
                        globalData.setToken(val.data['token']);
                        globalData.setUserName(val.data['userName']);
                        globalData.setEMail(email);
                        globalData.setRole(val.data['role']); //Para que mire rol
                        Fluttertoast.showToast(
                            msg: 'Logged successfully',
                            toastLength: Toast.LENGTH_SHORT,
                            timeInSecForIosWeb: 6);

                        if (globalData.getRole() == "Business"){
                          MyNavigator.goToCompany(context);
                        }else if (globalData.getRole() == "Storage"){
                                                    MyNavigator.goToUser(context);

                        }else{
                                                    MyNavigator.goToDeliverer(context);

                        }
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
                MyNavigator.goToForgotPassword(context);
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
          ),
          ElevatedButton(
              child: Text(
                'Entrar',
              ),
              onPressed: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => Mapa()));
              })
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
            onPressed: () {
              try {
                  UserServices().loginGoogle().then((val) {
                    if (val.statusCode == 200) {
                      print(val.data);
                      print(val.data['_id']);
                      print(val.data['userName']);
                      print(val.data['email']);
                      print(val.data['role']);
                      globalData.setId(val.data['_id']);
                      globalData.setUserName(val.data['userName']);
                      globalData.setEMail(val.data['email']);
                      if (val.data['role'] == null) {
                        MyNavigator.goToBankData(context);
                      }else if (val.data['role'] == "Business"){
                        MyNavigator.goToCompany(context);
                      }else if (val.data['role'] == "Storage"){
                      MyNavigator.goToCompany(context);
                    }else{
                      MyNavigator.goToUser(context);
                    }

                    } else if (val.statusCode == 401) {
                      Fluttertoast.showToast(
                          msg: 'Email o contraseña incorrectos',
                          toastLength: Toast.LENGTH_SHORT,
                          timeInSecForIosWeb: 6);
                    } else {
                      Fluttertoast.showToast(
                          msg: "Error",
                          toastLength: Toast.LENGTH_SHORT,
                          timeInSecForIosWeb: 6);
                    }
                  });
              } catch (err) {
                print(err);
                Fluttertoast.showToast(
                    msg: err.toString(),
                    toastLength: Toast.LENGTH_SHORT,
                    timeInSecForIosWeb: 6);
              }
            }
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
