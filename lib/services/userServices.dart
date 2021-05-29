import 'package:dio/dio.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:rlbasic/my_navigator.dart';

GoogleSignIn _googleSignIn = GoogleSignIn(
  scopes: [
    'email',
    'profile',
  ],
);

class UserServices {
  Dio dio = new Dio();
  var url = "http://localhost:4000/api/users/";

  login(email, password) async {
    print(email);
    print(password);
    try {
      return await dio.post(url + 'logIn',
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

    } on DioError catch (e) {
      Fluttertoast.showToast(
          msg: e.response?.data['msg'],
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1);
    }
  }
}
