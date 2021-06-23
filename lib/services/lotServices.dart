import 'package:dio/dio.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:rlbasic/main.dart';
import 'package:rlbasic/models/lot.dart';
import 'package:rlbasic/providers/lotCustomizer.dart';
import './url.dart';

class LotServices {
  Dio dio = new Dio();
  var url = URL + "/lots/";

  postLot(name, dimensions, weight, qty, minimumQty, price, isFragile,
      String businessItem) async {
    print(name);
    print(dimensions);
    print(weight);
    print(qty);
    print(minimumQty);
    print(price);
    print(isFragile);
    print(businessItem);

    try {
      return await dio.post(url,
          data: {
            "name": name,
            "dimensions": dimensions,
            "weight": weight,
            "qty": qty,
            "price": price,
            "minimumQty": minimumQty,
            "isFragile": isFragile,
            "businessItem": businessItem,
          },
          options: Options(contentType: Headers.formUrlEncodedContentType));
    } catch (e) {
      if (e is DioError) {
        Fluttertoast.showToast(
            msg: 'No se ha podido añadir',
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 3);
      }
    }
  }

  deleteUserOfLot(id) async {
    try {
      final resp = await dio.put(url + id,
          data: {"userItem": "deleted"},
          options: Options(contentType: Headers.formUrlEncodedContentType));
      print(resp.data);
    } catch (e) {
      print(e);
      return [];
    }
  }

   updateLot(String id) async {
    try {
      final resp = await dio.put('$url' + '$id');
      print(resp.data);
      final List<dynamic> lot = resp.data;
      return lot.map((obj) => Lot.fromJson(obj)).toList();
    } catch (e) {
      if (e is DioError) {
        Fluttertoast.showToast(
            msg: 'No se puede actualizar',
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 3);
      }
    }
  }

  getLotsSameName(String name) async {
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
  // getLotUser(String id) async {
  //   try {
  //     final resp = await dio.post(url,
  //         data: {"id": id},
  //         options: Options(contentType: Headers.formUrlEncodedContentType));
  //     print(resp.data);
  //     final List<dynamic> lotlist = resp.data;
  //     return lotlist.map((obj) => Lot.fromJson(obj)).toList();
  //   } catch (e) {
  //     Fluttertoast.showToast(
  //         msg: 'No hay ningún lote de este usuario',
  //         toastLength: Toast.LENGTH_SHORT,
  //         gravity: ToastGravity.BOTTOM,
  //         timeInSecForIosWeb: 3);
  //   }
  // }

  getAllLotsSorted() async {
    try {
      final resp = await dio.get(url);
      print(resp);
      final List<dynamic> lotlist = resp.data;
      return lotlist.map((obj) => Lot.fromJson(obj)).toList();
    } catch (e) {
      Fluttertoast.showToast(
          msg: 'Error',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 3);
    }
  }

  //   addNewLotToCompany(String businessItem) async {
  //   print(businessItem + 'id businessItem');
  //   try {
  //     final resp = await dio.post('$url' + '$id',
  //         data: {"businessItem": businessItem},
  //         options: Options(contentType: Headers.formUrlEncodedContentType));
  //     print(resp.statusCode);
  //     print(resp.data);
  //   } catch (e) {
  //     Fluttertoast.showToast(
  //         msg: 'No se ha podido añadir este lote a la compañia',
  //         toastLength: Toast.LENGTH_SHORT,
  //         gravity: ToastGravity.BOTTOM,
  //         timeInSecForIosWeb: 3);
  //   }
  // }

  addNewLotToUser(String id, String userID) async {
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

  //Lot List of one user trough id
  getLotListByUser(String id) async {
    try {
      final resp = await dio.get('$url' + 'getByUser/' + '$id');
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


  getSortLotsByAscPrice(String id) async {
    try {
      final resp = await dio.get('$url' + 'getSortLotsByAscPrice/' + '$id');
      print(resp.data);
      final List<dynamic> lotList = resp.data;
      return lotList.map((obj) => Lot.fromJson(obj)).toList();
    } catch (e) {
      print(e);
      Fluttertoast.showToast(
          msg: 'No hay ningún lote de este usuario',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 3);
    }
  }

  getSortLotsByAscQty(String id) async {
    try {
      final resp = await dio.get('$url' + 'getSortLotsByAscQty/' + '$id');
      print(resp.data);
      final List<dynamic> lotList = resp.data;
      return lotList.map((obj) => Lot.fromJson(obj)).toList();
    } catch (e) {
      print(e);
      Fluttertoast.showToast(
          msg: 'No hay ningún lote de este usuario',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 3);
    }
  }

  getLotsByChart(String id) async {
    try {
      final resp = await dio.get('$url' + 'getLotsByChart/' + '$id');
      print(resp.data);
      final List<dynamic> lotList = resp.data; //resp
      return lotList.map((obj) => LotCustomizer.fromJson(obj)).toList();
      // return lotList;
    } catch (e) {
      print(e);
      Fluttertoast.showToast(
          msg: 'No hay ningún lote de este usuario',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 3);
    }
  }

  getLotListByBusiness(String id) async {
    try {
      final resp = await dio.get('$url' + 'getByBusiness/' + '$id');
      final List<dynamic> lotlist = resp.data;
      return lotlist.map((obj) => Lot.fromJson(obj)).toList();
    } catch (e) {
      Fluttertoast.showToast(
          msg: 'No hay ningún lote de esta compañia',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 3);
    }
  }

    getLotListByBusinessInProgressStored(String id) async {
    try {
      final resp = await dio.get('$url' + '/getByBusinessStoredWithUserID/' + '$id');
      final List<dynamic> lotlist = resp.data;
      return lotlist.map((obj) => Lot.fromJson(obj)).toList();
    } catch (e) {
      Fluttertoast.showToast(
          msg: 'No se ha almacenado aun ningun lote',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 3);
    }
  }

    getLotListByBusinessInProgressStoredTrue(String id) async {
    try {
      final resp = await dio.get('$url' + '/getByBusinessStoredTrueWithUserID/' + '$id');
      final List<dynamic> lotlist = resp.data;
      return lotlist.map((obj) => Lot.fromJson(obj)).toList();
    } catch (e) {
      Fluttertoast.showToast(
          msg: 'No se ha almacenado aun ningun lote',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 3);
    }
  }

    getLotListByUserStoredTrue(String id) async {
    try {
      final resp = await dio.get('$url' + '/getByUserStoredTrueWithUserID/' + '$id');
      final List<dynamic> lotlist = resp.data;
      return lotlist.map((obj) => Lot.fromJson(obj)).toList();
    } catch (e) {
      Fluttertoast.showToast(
          msg: 'No se ha almacenado aun ningun lote',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 3);
    }
  }


  //Crear funcion nueva para mostrar en searchProducts, Lotes en los que aun ningún user ha apretado aceptar ni se ha creado ningun delivery. Si es necesario, crear una nueva variable.

  //getLotListWithoutDeliveryCreated

}
