import 'package:dio/dio.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:rlbasic/models/notification.dart';
import './url.dart';

class NotificationServices {
  Dio dio = new Dio();
  var url = URL + "/notifications/";

  //functions

  //get a notification with a bearer token
  getLotListByUser(String id) async {
    try {
      final resp = await dio.post('$url' + 'me');
      final List<dynamic> notificationList = resp.data;
      return notificationList.map((obj) => Notification.fromJson(obj)).toList();
    } catch (e) {
      Fluttertoast.showToast(
          msg: 'No hay ningún lote de este usuario',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 3);
    }
  }

  //delete a notification with a bearer token
  deleteUserOfLot(id) async {
    try {
      final resp = await dio.post('$url' + 'del');
      print(resp.data);
    } catch (e) {
      print(e);
      return [];
    }
  }

  //push a notification to other user with a bearer token ---> link with this

}