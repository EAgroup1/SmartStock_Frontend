import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:rlbasic/my_navigator.dart';

GoogleSignIn _googleSignIn = GoogleSignIn(
  scopes: [
    'email',
    'profile',
  ],
);
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


  //NUEVA; AUN NO VA
  sendBankRole(String id, String bank, String role) async{
    try{
      final resp = await dio.put(url+id,
        data:{"id": id, "role": role, "bank":bank},
        options: Options(contentType: Headers.formUrlEncodedContentType)
      );
      print(resp.data);
    }
    catch (e) {
      print(e);
      return [];
    }

  }

  Future<void> loginGoogle() async {
    try {
      await _googleSignIn.signIn();
      print(_googleSignIn.currentUser!.email);
      print(_googleSignIn.currentUser!.displayName);
      print(_googleSignIn.currentUser!.photoUrl);
      try {
        await dio.post(url + 'logInGoogle',
            data: {"email": _googleSignIn.currentUser!.email, "userName": _googleSignIn.currentUser!.displayName, "avatar": _googleSignIn.currentUser!.photoUrl},
            options: Options(contentType: Headers.formUrlEncodedContentType));
        MyNavigator.goTo
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
