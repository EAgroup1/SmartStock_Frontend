import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:rlbasic/models/user.dart';

class UserServices {
  Dio dio = new Dio();
  var url = "http://localhost:4000/api/users/";
  late DioExceptions dioExceptions;

  login(email, password) async {
    print(email);
    print(password);
    try {
      return await dio.post(url + 'logIn',
          data: {"email": email, "password": password},
          options: Options(contentType: Headers.formUrlEncodedContentType));
    } catch (e) {
      if (e is DioError) {
        Fluttertoast.showToast(
            msg: 'No existe el email, regístrate',
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 3);
      }
    }
  }

  getUser(String id) async{
    try {
      final resp = await dio.post(url,
        data:{"id":id},
        options: Options(contentType: Headers.formUrlEncodedContentType)      
      );
      print(resp.data);
      final List<dynamic> lotlist = resp.data;
      return lotlist.map((obj) => User.fromJson(obj)).toList();

    } catch (e) {
      print(e);
      return [];
    }
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
        Fluttertoast.showToast(
            msg: 'El email ya existe',
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 3);
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

class DioExceptions implements Exception {
  DioExceptions.fromDioError(DioError dioError) {
    switch (dioError.type) {
      case DioErrorType.cancel:
        message = "Request to API server was cancelled";
        break;
      case DioErrorType.connectTimeout:
        message = "Connection timeout with API server";
        break;
      case DioErrorType.receiveTimeout:
        message = "Receive timeout in connection with API server";
        break;
      case DioErrorType.response:
        message = _handleError(
            dioError.response!.statusCode!, dioError.response!.data);
        break;
      case DioErrorType.sendTimeout:
        message = "Send timeout in connection with API server";
        break;
      default:
        message = "Something went wrong";
        break;
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

}
