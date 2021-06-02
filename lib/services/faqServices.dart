import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:rlbasic/main.dart';
import 'package:rlbasic/my_navigator.dart';
import 'package:rlbasic/models/faq.dart';


class FaqServices {
  Dio dio = new Dio();
  var url = "http://localhost:4000/api/faq/";
  late DioExceptions dioExceptions;

  Future<List<Faq>> _fetchFaqs() async {
    final resp = await dio.get(url);

    if (resp.statusCode == 200) {
      List jsonResponse = json.decode(resp.data);
      return jsonResponse.map((job) => new Faq.fromJson(job)).toList();
    } else {
      throw Exception('Failed to load jobs from API');
    }
  }
  getAllFaqs() async {
    try {
      final resp = await dio.get(url);
      print(resp.data);
      final List<dynamic> faqlist = resp.data;
      return faqlist.map((obj) => Faq.fromJson(obj)).toList();

    } catch (e) {
      print(e);
      AlertDialog(
         title: Text('Error'),
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              Text('Error al coger los usuarios'),
            ],
          ),
        ),
      );
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

}
