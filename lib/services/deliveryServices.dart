import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:rlbasic/models/delivery.dart';
import 'package:rlbasic/providers/deliveryCustomizer.dart';
import './url.dart';

class DeliveryServices {
  Dio dio = new Dio();
  var url = URL+"/delivery/";

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
      final List<Delivery> deliverylist=[];
      return deliverylist;
    }
  }

  deleteUserOfDelivery(id) async  {
    try{
      final resp = await dio.put(url+id,
        data:{"userItem": "deleted"},
        options: Options(contentType: Headers.formUrlEncodedContentType)
      );
      print(resp.data);
    }
    catch (e) {
      print(e);
      return [];
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
      final List<Delivery> deliverylist=[];
      return deliverylist;
    }
  }

  setReadyDelivery(String id) async {
          print(id);

    try {
      return await dio.put(url + 'readydelivery/'+id,
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

  getDeliveriesByChart(String id) async {
    try {
      final resp = await dio.get('$url' + 'getDeliveriesByChart/' + '$id');
      print(resp.data); //resp
      final List<dynamic> deliveryList = resp.data;
      return deliveryList.map((obj) => DeliveryCustomizer.fromJson(obj)).toList();
      // return deliveryList;
    } catch (e) {
      print(e);
      Fluttertoast.showToast(
          msg: 'No hay ningún pedido de este usuario',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 3);
    }
  }

}
