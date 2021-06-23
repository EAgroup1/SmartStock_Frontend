import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:rlbasic/main.dart';
import 'package:rlbasic/models/message.dart';
import 'package:rlbasic/models/userChat.dart';
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

  Future<List<UserChat>> getUserChat(String id) async {
    try {
      final resp = await dio.get(url + 'chat/' + id,
          options: Options(contentType: Headers.formUrlEncodedContentType));
      print(resp.data['friends']);

      final List<UserChat> friendList;
      friendList = (resp.data['friends'] as List)
          .map((i) => UserChat.fromJson(i))
          .toList();
      return friendList;
    } catch (e) {
      print(e);
      return [];
    }
  }

   getListMessages(String id) async{ //Future<List<Message>>
    try {
      final resp = await dio.get(url + 'chat/' + id,
          options: Options(contentType: Headers.formUrlEncodedContentType));
      print("HOLA AMIGO");
      print(resp.data['messages']);

      final List<Message> messages;
      messages = (resp.data['messages'] as List)
          .map((i) => Message.fromJson(i))
          .toList();
      return messages;
    } catch (e) {
      print(e);
      return [];
    }
  }

  addMessageList(String id, List<Message> messages) async{
    print(messages);
    String encoded = jsonEncode(messages);
    //var data = [];
    String datasent = jsonEncode(messages[0]);
    //List<Map<String,dynamic>> AYUDA = [];
    //AYUDA.add(messages[0].toJson());
    //for(var i = 1; i<messages.length; i++){
      /*var send = messages[i].senderID;
      var receive = messages[i].receiverID;
      var txt = messages[i].text;
      var _data = {
        "senderID": send,
        "text": txt,
        "receiverID": receive
      };
      var _datae = jsonEncode(_data);
      data.add(_datae);*/
      //AYUDA.add(jsonEncode(messages[i]).toJson());
    //}
    encoded = jsonEncode(messages.map((i) => i.toJson()).toList()).toString();

    //String datasent = jsonEncode(messages);
    print("LO QUE MANDAMOS PAL BACKEND");
    print(encoded);
    try {
      final resp = await dio.put(url + id,
          data: {"messages": encoded},
          options: Options(contentType: Headers.formUrlEncodedContentType));
      print(resp.data);
      print("Messages added");
    } catch (e) {
      print(e);
    }
  }

  getNumByRole(String role) async {
    try {
      final resp = await dio.get('$url' + 'getNumByRole/' + '$role');
      print(resp.data);

      final numByRole = int.parse(resp.data);
      return numByRole;
    } catch (e) {
      print(e);
      return [];
    }
  }

  eliminateUser(String id) async {
    try {
      final resp = await dio.delete(url + id,
          data: {"id": id},
          options: Options(contentType: Headers.formUrlEncodedContentType));
      print(resp.data);
    } catch (e) {
      print(e);
      return [];
    }
  }

  deleteFriend(String id, String friends) async {
    try {
      final resp = await dio.put(url + id+"/deletefriend",
        data: {"friend": friends},
        options: Options(contentType: Headers.formUrlEncodedContentType));
      print(resp.data);
    } catch (e) {
      print(e);
      return [];
    }
  }

  putFriend(String id, String friends) async {
    try {
      final resp = await dio.put(url + id+"/putfriend",
        data: {"friend": friends},
        options: Options(contentType: Headers.formUrlEncodedContentType));
      print(resp.data);
    } catch (e) {
      print(e);
      return [];
    }
  }

  getUserByStorageRol() async {
    try {
      final resp = await dio.get('$url' + 'getUsersByRole/' + 'Storage');
      print(resp.data);
      final List<dynamic> userlist = resp.data;
      return userlist.map((obj) => User.fromJson(obj)).toList();
    } catch (e) {
      print(e);
      return [];
    }
  }

  //NUEVA; AUN NO VA
  sendBankRole(String id, String bank, String role, String location) async {
    try {
      final resp = await dio.put(url + id,
          data: {"id": id, "role": role, "bank": bank, "location": location},
          options: Options(contentType: Headers.formUrlEncodedContentType));
      print(resp.data);
    } catch (e) {
      print(e);
      return [];
    }
  }

  sendCoord(id, lat, lng) async {
    try {
      final resp = await dio.put(url + id,
          data: {"id": id, "clat": lat, "clng": lng},
          options: Options(contentType: Headers.formUrlEncodedContentType));
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

  updateUser(String id) async {
    try {
      final resp = await dio.put('$url' + '$id');
      print(resp.data);
      final List<dynamic> user = resp.data;
      return user.map((obj) => User.fromJson(obj)).toList();
    } catch (e) {
      if (e is DioError) {
        Fluttertoast.showToast(
            msg: 'No se puede actualizar',
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 3);
      }
    }
  }

  register(name, email, password, location) async {
    try {
      return await dio.post(url + 'signUp',
          data: {
            "userName": name,
            "email": email,
            "password": password,
            "location": location
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
                msg: _handleError(e.response!.statusCode!, e.response!.data),
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


