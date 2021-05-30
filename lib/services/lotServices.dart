import 'package:dio/dio.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:rlbasic/models/lot.dart';

class lotServices {
  Dio dio = new Dio();
  var url = "http://localhost:4000/api/lots/";

  getLot(String name) async {
    try {
      final resp = await dio.get('$url' + 'get/' + '$name');
      print(resp.data);

      final List<dynamic> lotlist = resp.data;
      return lotlist.map((obj) => Lot.fromJson(obj)).toList();
    } catch (e) {
        Fluttertoast.showToast(
            msg: 'El lote no está',
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 3);
    }
  }
    getLotUser(String id) async {
      try {
        final resp = await dio.post(url,
            data: {"id": id},
            options: Options(contentType: Headers.formUrlEncodedContentType));
        print(resp.data);
        final List<dynamic> lotlist = resp.data;
        return lotlist.map((obj) => Lot.fromJson(obj)).toList();
      } catch (e) {
        Fluttertoast.showToast(
            msg: 'No hay ningún lote de este usuario',
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 3);
      }
    }

    getAllLotsSorted() async {
      try {
        final resp = await dio.get(url);
        print(resp);
        final List<dynamic> lotlist = resp.data;
        return lotlist.map((obj) => Lot.fromJson(obj)).toList();
      } catch (e) {
        Fluttertoast.showToast(
            msg: 'El email ya existe',
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 3);
      }
    }

    addNewLotToUser(String id, String userID) async {
      print(id + 'id LOTE');
      print(userID + 'id userItem');
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
  

  //Lot List of one user trough id
  getLotListByUser(String id) async {
    try {
      final resp = await dio.get('$url'+'getByUser/'+'$id');
      final List<dynamic> lotlist = resp.data;
      return lotlist.map((obj) => Lot.fromJson(obj)).toList();
    } catch (e) {
      print(e);
      return [];
    }
  }
}
