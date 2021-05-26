import 'package:dio/dio.dart';
import 'package:rlbasic/models/lot.dart';

class lotServices {
  Dio dio = new Dio();
  var url = "http://localhost:4000/api/lots/";

  getLot(String name) async {
    try {
      final resp = await dio.get('$url'+'get/'+'$name');
      print(resp.data);

      final List<dynamic> lotlist = resp.data;
      return lotlist.map((obj) => Lot.fromJson(obj)).toList();

    } catch (e) {
      print(e);
      return [];
    }
  }

  //this function return only lot for one user
  getLotUser(String id) async{
    try {
      final resp = await dio.post(url,
        data:{"id":id},
        options: Options(contentType: Headers.formUrlEncodedContentType)      
      );
      print(resp.data);
      final List<dynamic> lotlist = resp.data;
      return lotlist.map((obj) => Lot.fromJson(obj)).toList();

    } catch (e) {
      print(e);
      return [];
    }
  }

  getAllLots() async {
    try {
      final resp = await dio.get(url);
      final List<dynamic> lotlist = resp.data;
      return lotlist.map((obj) => Lot.fromJson(obj)).toList();
    } catch (e) {
      print(e);
      return [];
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
