import 'package:dio/dio.dart';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:rlbasic/models/directions_model.dart';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart' as maps;
// ignore: import_of_legacy_library_into_null_safe
//import 'package:google_maps_webservice/directions.dart';



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
      //enviar a la base de datos las coordenadas
      print(response.data["results"][0]["geometry"]["location"]);
      print(LatLng(response.data["results"][0]["geometry"]["location"]["lat"], response.data["results"][0]["geometry"]["location"]["lng"]).toString());
    } catch (e) {
      return null;
    }
  }
}

class DirectionsRepository {
  static const String _baseUrl =
      'https://maps.googleapis.com/maps/api/directions/json?';

  final Dio _dio;

  DirectionsRepository({Dio? dio}) : _dio = dio ?? Dio();

  Future<Directions?> getDirections({
    @required LatLng? origin,
    @required LatLng? destination,
  }) async {
    final response = await _dio.get(
      _baseUrl,
      queryParameters: {
        'origin': '${origin!.latitude},${origin.longitude}',
        'destination': '${destination!.latitude},${destination.longitude}',
        'key': 'AIzaSyDkLS9gx294LM4w85qDd9Zqutg6s8sN8Og',
      },
    );

    // Check if response is successful
    if (response.statusCode == 200) {
      return Directions.fromMap(response.data);
    }
    return null;
  }
}

/* class DirectionProvider extends ChangeNotifier {
  GoogleMapsDirections directionsApi =
      GoogleMapsDirections(apiKey: "AIzaSyDkLS9gx294LM4w85qDd9Zqutg6s8sN8Og");

  Set<maps.Polyline> _route = Set();

  Set<maps.Polyline> get currentRoute => _route;

  findDirections(maps.LatLng from, maps.LatLng to) async {
    var origin = Location(from.latitude, from.longitude);
    var destination = Location(to.latitude, to.longitude);

    var result = await directionsApi.directionsWithLocation(
      origin,
      destination,
      travelMode: TravelMode.driving,
    );

    Set<maps.Polyline> newRoute = Set();

    if (result.isOkay) {
      var route = result.routes[0];
      var leg = route.legs[0];

      List<maps.LatLng> points = [];

      leg.steps.forEach((step) {
        points.add(maps.LatLng(step.startLocation.lat, step.startLocation.lng));
        points.add(maps.LatLng(step.endLocation.lat, step.endLocation.lng));
      });

      var line = maps.Polyline(
        points: points,
        polylineId: maps.PolylineId("mejor ruta"),
        color: Colors.red,
        width: 4,
      );
      newRoute.add(line);

      print(line);

      _route = newRoute;
      notifyListeners();
    } else {
      print("ERRROR !!! ${result.status}");
    }
  }
} */