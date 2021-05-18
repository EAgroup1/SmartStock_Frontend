import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:rlbasic/models/delivery.dart';

class DeliveryServices {
  Dio dio = new Dio();
  var url = "http://localhost:4000/api/delivery/";

  getDeliveriesUser(String id) async {
    try {
      final resp = await dio.post(url + id + '/deliveries/',
          data: {"id": id},
          options: Options(contentType: Headers.formUrlEncodedContentType));
      print(resp.data);

      final List<Delivery> deliverylist;
      deliverylist =
          (resp.data as List).map((i) => Delivery.fromJson(i)).toList();

      return deliverylist;
      /*  =
          resp.data.map((obj) => Delivery.fromJson(obj)).toList();
      print(deliverylist[0].id); */
      // return deliverylist.map((obj) => Delivery.fromJson(obj)).toList();
    } catch (e) {
      print(e);
      return [];
    }
  }

  getReadyDeliveries(String id) async {
    try {
      final resp = await dio.post(url + id + '/readydeliveries/',
          data: {"id": id},
          options: Options(contentType: Headers.formUrlEncodedContentType));
      print(resp.data);

      final List<Delivery> deliverylist;
      deliverylist =
          (resp.data as List).map((i) => Delivery.fromJson(i)).toList();

      return deliverylist;
      /*  =
          resp.data.map((obj) => Delivery.fromJson(obj)).toList();
      print(deliverylist[0].id); */
      // return deliverylist.map((obj) => Delivery.fromJson(obj)).toList();
    } catch (e) {
      print(e);
      return [];
    }
  }

  setReadyDelivery(String id) async {
    try {
      return await dio.post(url + 'readydelivery',
          data: {"id": id},
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
}
