import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:rlbasic/main.dart';
import 'package:rlbasic/my_navigator.dart';
import 'package:rlbasic/models/user.dart';
import './url.dart';
//import 'package:flutter/services.dart' show rootBundle;
import 'dart:convert';
import 'dart:async' show Future;


GoogleSignIn _googleSignIn = GoogleSignIn(
  scopes: [
    'email',
    'profile',
  ],
);


class UserServices {
  Dio dio = new Dio();
  var url = URL + "/users/";
  /* late DioExceptions dioExceptions; */

  login(email, password) async {
    print(email);
    print(password);
    print("PRINT DESDE USERSERVICES LOGIN Y SE ENVIA EN CLARO PASSWORD");
    try {
      return await dio.post(url + 'logIn',
          data: {"email": email, "password": password},
          options: Options(contentType: Headers.formUrlEncodedContentType));
    } catch (e) {
      if (e is DioError) {
        Fluttertoast.showToast(
            msg: 'No estás registrado o la contraseña es incorrecta',
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 3);
      }
    }
  }

  //we need a forgotPass & resetPass function
  forgotPass(email) async {
    print(email);
    try {
      return await dio.put(url + 'forgotPassword',
          data: {"email": email},
          options: Options(contentType: Headers.formUrlEncodedContentType));
    } catch (e) {
      if (e is DioError) {
        Fluttertoast.showToast(
            msg: 'Este usuario no existe',
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 3);
      }
    }
  }

  //resetPass
  resetPass(resetLink, newPass, confNewPass) async {
    try {
      return await dio.put(url + 'resetPassword',
          data: {
            "resetLink": resetLink,
            "newPass": newPass,
            "confNewPass": confNewPass,
          },
          options: Options(contentType: Headers.formUrlEncodedContentType));
    } catch (e) {
      if (e is DioError) {
        Fluttertoast.showToast(
            msg: 'Las contraseñas no coinciden vuelva a intentarlo',
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 3);
      }
    }
  }

  getUserChat(String id) async {
    try {
      final resp = await dio.get(url+'/chat/'+id,
        options: Options(contentType: Headers.formUrlEncodedContentType)
      );
      //Map<String, dynamic> map = jsonDecode(resp.toString());
      User user = new User.fromJson(resp.data); 
      return user;
    } catch (e) {
      print(e);
      return [];
    }
  }
  User getaUser(String id){
    User resulting = new User('','','','','',[],'');
    
    getUserChat(id) //el "then no va bien porque envia el vacio pero el whenComplete no funciona"
    .then((result) {
      var userName = result.userName;
      var email = result.email;
      var bank = result.bank;
      var _id = result.id;
      var role = result.role;
      var friends = result.friends;
      var resetLink = result.resetLink;
      resulting = new User(_id,userName,email,bank,role,friends,resetLink);
      print("Then");
    });
    /*.whenComplete((result) {
      var userName = result.userName;
      var email = result.email;
      var bank = result.bank;
      var _id = result.id;
      var role = result.role;
      var friends = result.friends;
      resulting = new User(_id,userName,email,bank,role,friends);
      print("Compelte");
      print(resulting);
    });*/
    return resulting;
    
  }

  getNumByRole(String role) async {
    try {
      final resp = await dio.get('$url'+'getNumByRole/'+'$role');
      print(resp.data);

      final numByRole = int.parse(resp.data);
      return numByRole;

    } catch (e) {
      print(e);
      return [];
    }
  }

  eliminateUser(String id) async{
    try{
      final resp = await dio.delete(url+id,
        data:{"id": id},
        options: Options(contentType: Headers.formUrlEncodedContentType)
      );
      print(resp.data);
    }
    catch (e) {
      print(e);
      return [];
    }
  }

  sendBankRole(String id, String bank, String role) async{
    try{
      final resp = await dio.put(url+id,
        data:{"id": id, "role": role, "bank":bank},
        options: Options(contentType: Headers.formUrlEncodedContentType)
      );
      print(resp.data);
    } catch (e) {
      print(e);
      return [];
    }
  }

  Future<Response> loginGoogle() async {
    try {
      await _googleSignIn.signIn();
      try {
        final user = await dio.post(url + 'logInGoogle',
            data: {
              "email": _googleSignIn.currentUser!.email,
              "userName": _googleSignIn.currentUser!.displayName,
              "password": _googleSignIn.currentUser!.id,
              "avatar": _googleSignIn.currentUser!.photoUrl
            },
            options: Options(contentType: Headers.formUrlEncodedContentType));
        print(user);
        return user;
      } on DioError catch (e) {
        Fluttertoast.showToast(
            msg: e.response?.data['msg'],
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1);
      }
    } catch (error) {
      print(error);
    }
    throw (error) {
      print(error);
    };
  }

  register(name, email, password) async {
    try {
      return await dio.post(url + 'signUp',
          data: {
            "userName": name,
            "email": email,
            "password": password,
          },
          options: Options(contentType: Headers.formUrlEncodedContentType));
    } catch (e) {
      if (e is DioError) {
        switch (e.type) {
          case DioErrorType.cancel:
            Fluttertoast.showToast(
            msg: "Cancelada la respuesta de la API",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1);
            break;
          case DioErrorType.connectTimeout:
            Fluttertoast.showToast(
            msg: "Conexión con la API expirada",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1);
            break;
          case DioErrorType.receiveTimeout:
           Fluttertoast.showToast(
            msg: "Tiempo expirado al conectar con el servidor API",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1);
            break;
          case DioErrorType.response:
           Fluttertoast.showToast(
            msg: _handleError(
                e.response!.statusCode!, e.response!.data),
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1);
            break;
          case DioErrorType.sendTimeout:
            Fluttertoast.showToast(
            msg: "URL Timeout",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1);
            break;
          default:
            Fluttertoast.showToast(
            msg: "Algo ha ido mal",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1);
            break;
        }
      }

      // if (e.response!.statusCode == 409) {
      //   Fluttertoast.showToast(
      //     msg: e.response!.statusMessage!,
      //     toastLength: Toast.LENGTH_SHORT,
      //     gravity: ToastGravity.BOTTOM,
      //     timeInSecForIosWeb: 1);
      // }
    }
  }
}

  String message = '';

  String _handleError(int statusCode, dynamic error) {
    switch (statusCode) {
      case 400:
        return 'Bad request';
      case 404:
        return error["message"];
      case 500:
        return 'Internal server error';
      default:
        return 'Oops something went wrong';
    }
  }

  @override
  String toString() => message;

  // getAllUsers() async {
  //   try {
  //     final resp = await dio.get(url);
  //     print(resp.data);
  //     final List<dynamic> userlist = resp.data;
  //     return userlist.map((obj) => User.fromJson(obj)).toList();

  //   } catch (e) {
  //     print(e);
  //     AlertDialog(
  //        title: Text('Error'),
  //       content: SingleChildScrollView(
  //         child: ListBody(
  //           children: <Widget>[
  //             Text('Error al coger los usuarios'),
  //           ],
  //         ),
  //       ),
  //     );
  //   }
  // }


