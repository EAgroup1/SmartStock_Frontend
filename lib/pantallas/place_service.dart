import 'package:dio/dio.dart';
import 'dart:io';

import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Place {
  final String placeId, description;

  Place({required this.placeId, required this.description});
  static Place fromJson(Map<String, dynamic> json) {
    return Place(
      placeId: json['place_id'],
      description: json['description'],
    );
  }
}

class PlaceApi {
  PlaceApi._internal();
  static PlaceApi get instance => PlaceApi._internal();
  final Dio _dio = Dio();

  static final String androidKey = 'AIzaSyDkLS9gx294LM4w85qDd9Zqutg6s8sN8Og';
  static final String iosKey = 'AIzaSyDkLS9gx294LM4w85qDd9Zqutg6s8sN8Og';
  final apiKey = Platform.isAndroid ? androidKey : iosKey;

  Future<List<Place>?> searchPredictions(String input) async {
    try {
      final response = await this._dio.get(
        'https://maps.googleapis.com/maps/api/place/autocomplete/json',
        queryParameters: {
          "input": input,
          "key": apiKey,
          "types": "address",
          "language": "es-Es",
          "components": "country:es",
        },
      );
      print(response.data);
      final List<Place> places = (response.data['predictions'] as List)
          .map((item) => Place.fromJson(item))
          .toList();
      return places;
    } catch (e) {
      return null;
    }
  }

  Future<LatLng?> location(String address) async {
    try {
      final response = await this._dio.get(
        'https://maps.googleapis.com/maps/api/geocode/json',
        queryParameters: {
          "address": address,
          "key": apiKey,
        },
      );
      print(response.data["results"][0]["geometry"]["location"]);
      print(LatLng(response.data["results"][0]["geometry"]["location"]["lat"], response.data["results"][0]["geometry"]["location"]["lng"]).toString());
    } catch (e) {
      return null;
    }
  }
}
