import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:rlbasic/models/delivery.dart';
import 'package:rlbasic/models/lot.dart';
import 'package:rlbasic/models/user.dart';

class DeliveryServices {
  Dio dio = new Dio();
  //var url = "http://localhost:3000/api/delivery/";
  var url = "http://10.0.2.2:3000/api/delivery/";

  getDeliveriesUser(String id) async {
    try {
      final resp = await dio.get(url + id + '/deliveries/',
          options: Options(contentType: Headers.formUrlEncodedContentType));
      print(resp.data);

      final List<Delivery> deliverylist;
      deliverylist =
          (resp.data as List).map((i) => Delivery.fromJson(i)).toList();

      return deliverylist;
    } catch (e) {
      print(e);
      if (e is DioError) {
        Fluttertoast.showToast(
            msg: 'vacio',
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 3);
      }
      final List<Delivery> deliverylist = [];
      return deliverylist;
    }
  }

  getReadyDeliveries(String id) async {
    try {
      final resp = await dio.get(url + id + '/readydeliveries/',
          options: Options(contentType: Headers.formUrlEncodedContentType));
      print(resp.data);

      final List<Delivery> deliverylist;
      deliverylist =
          (resp.data as List).map((i) => Delivery.fromJson(i)).toList();

      return deliverylist;
    } catch (e) {
      print(e);
      if (e is DioError) {
        Fluttertoast.showToast(
            msg: 'vacio',
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 3);
      }
      final List<Delivery> deliverylist = [];
      return deliverylist;
    }
  }

  setReadyDelivery(String id) async {
    print(id);

    try {
      return await dio.put(url + 'readydelivery/' + id,
          options: Options(contentType: Headers.formUrlEncodedContentType));
    } catch (e) {
      if (e is DioError) {
        print(e);
        Fluttertoast.showToast(
            msg: 'Ha habido un error',
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 3);
      }
    }
  }

  getNotAssigned() async {
    try {
      final resp = await dio.get(url + 'deliverer/notAssigned',
          options: Options(contentType: Headers.formUrlEncodedContentType));
      print(resp.data);

      final List<Delivery> deliverylist;
      deliverylist =
          (resp.data as List).map((i) => Delivery.fromJson(i)).toList();

      return deliverylist;
    } catch (e) {
      print(e);
      if (e is DioError) {
        Fluttertoast.showToast(
            msg: 'vacio',
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 3);
      }
      final List<Delivery> deliverylist = [];
      return deliverylist;
    }
  }

  getAssigned(String id) async {
    try {
      final resp = await dio.get(url + id + '/isAssigned',
          options: Options(contentType: Headers.formUrlEncodedContentType));
      print(resp.data);

      final List<Delivery> deliverylist;
      deliverylist =
          (resp.data as List).map((i) => Delivery.fromJson(i)).toList();

      return deliverylist;
    } catch (e) {
      print(e);
      if (e is DioError) {
        Fluttertoast.showToast(
            msg: 'vacio',
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 3);
      }
      final List<Delivery> deliverylist = [];
      return deliverylist;
    }
  }

  setAssigned(String id, String user) async {
    try {
      return await dio.put(url + 'assigned/' + id,
          data: {"id": user},
          options: Options(contentType: Headers.formUrlEncodedContentType));
    } catch (e) {
      if (e is DioError) {
        print(e);
        Fluttertoast.showToast(
            msg: 'Ha habido un error',
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 3);
      }
    }
  }


  setIsPicked(String id) async {
    try {
      return await dio.put(url + 'picked/' + id,
          options: Options(contentType: Headers.formUrlEncodedContentType));
    } catch (e) {
      if (e is DioError) {
        print(e);
        Fluttertoast.showToast(
            msg: 'Ha habido un error',
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 3);
      }
    }
  }

  setIsDelivered(String id) async {
    try {
      return await dio.put(url + 'delivered/' + id,
          options: Options(contentType: Headers.formUrlEncodedContentType));
    } catch (e) {
      if (e is DioError) {
        print(e);
        Fluttertoast.showToast(
            msg: 'Ha habido un error',
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 3);
      }
    }
  }

 setTime(id, tiempo) async{
    try {
      return await dio.put(url + 'time/' + id,
          data: {"time": tiempo},
          options: Options(contentType: Headers.formUrlEncodedContentType));
    } catch (e) {
      if (e is DioError) {
        print(e);
        Fluttertoast.showToast(
            msg: 'Ha habido un error',
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 3);
      }
    }

  }

  createDelivery(String lot, String userItem) async {
    print(lot);
    print(userItem);
    try {
      return await dio.post(url,
      data: {
            "lotItem": lot,
            "userItem": userItem
      },
          options: Options(contentType: Headers.formUrlEncodedContentType));
    } catch (e) {
      if (e is DioError) {
        print(e);
        Fluttertoast.showToast(
            msg: 'Ha habido un error creando el delivery',
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 3);
      }
    }
  }

addNewDeliveryToUser(String id, String userID) async {
    print('id: ' + id);
    print('id userItem: ' + userID);
    try {
      final resp = await dio.put('$url' + '$id',
          data: {"userItem": userID},
          options: Options(contentType: Headers.formUrlEncodedContentType));
      print(resp.statusCode);
      print(resp.data);
    } catch (e) {
      Fluttertoast.showToast(
          msg: 'No se ha podido añadir este lote al usuario',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 3);
    }
  }
 
}
