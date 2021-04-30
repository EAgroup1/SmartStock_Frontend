import 'package:dio/dio.dart';
import 'package:fluttertoast/fluttertoast.dart';

class UserServices {
  Dio dio = new Dio();
  var url = "http://localhost:4000/api/users/";

  login(email, password) async {
    try {
      return await dio.post(url+'logIn',
          data: {"email": email, "password": password},
          options: Options(contentType: Headers.formUrlEncodedContentType));
    } on DioError catch (e) {
      Fluttertoast.showToast(
          msg: e.response?.data['msg'],
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1);
    }
  }

  register(name, email, password) async {
    try {
      return await dio.post(url+'signUp',
          data: {
            "username": name,
            "email": email,
            "password": password,
            "role": 1
          },
          options: Options(contentType: Headers.formUrlEncodedContentType));
    } on DioError catch (e) {
      Fluttertoast.showToast(
          msg: e.response?.data['msg'],
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1);
    }
  }
}
