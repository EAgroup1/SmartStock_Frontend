import 'dart:async';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class Mapa extends StatefulWidget {
  final LatLng fromPoint = LatLng(-38.956176, -67.920666);
  final LatLng toPoint = LatLng(-38.953724, -67.923921);
  @override
  _MapaState createState() => _MapaState();
}

class _MapaState extends State<Mapa> {
GoogleMapController? _controller;
Marker? marker;
Circle? circle;
Location _locationTracker = Location();
StreamSubscription? _locationSubscription;

var tmp = Set<Marker>();

  static final CameraPosition initialLocation = CameraPosition(
    target: LatLng(41.2789, 1.97924),
    zoom: 14.4746,
  );

  Future<Uint8List> getMarker() async {
    ByteData byteData = await DefaultAssetBundle.of(context).load('assets/images/car_icon.png');
    return byteData.buffer.asUint8List();
  }
    Set<Marker> _createMarkers() {
    tmp.add(
      Marker(
          markerId: MarkerId("toDestination"),
          position: LatLng(41.2757, 1.98712),          
/*           draggable: false,
          zIndex: 2,
          flat: true,
          anchor: Offset(0.5, 0.5), */
          infoWindow: InfoWindow(title: "Destination"),

         // icon: BitmapDescriptor.fromBytes(imageData)
          )
    );/* 
    tmp.add(
      Marker(
        markerId: MarkerId("toPoint"),
        position: LatLng(41.2757, 1.98712),
        infoWindow: InfoWindow(title: "Roca 123"),
      ),
    ); */
    return tmp;
  }
    void updateMarkerAndCircle(LocationData newLocalData, Uint8List imageData) {
    LatLng latlng = LatLng(newLocalData.latitude!, newLocalData.longitude!);
    this.setState(() {
      tmp.add( Marker(
          markerId: MarkerId("home"),
          position: latlng,
          rotation: newLocalData.heading!,
          draggable: false,
          zIndex: 2,
          flat: true,
          anchor: Offset(0.5, 0.5),
          icon: BitmapDescriptor.fromBytes(imageData)
          ));
      circle = Circle(
          circleId: CircleId("car"),
          radius: newLocalData.accuracy!,
          zIndex: 1,
          strokeColor: Colors.blue,
          center: latlng,
          fillColor: Colors.blue.withAlpha(70));
    });
  }

    void getCurrentLocation() async {
    try {

      Uint8List imageData = await getMarker();
      Location location = new Location();

      bool _serviceEnabled;
      PermissionStatus _permissionGranted;
      LocationData _locationData;

      _serviceEnabled = await location.serviceEnabled();
      if (!_serviceEnabled) {
        _serviceEnabled = await location.requestService();
        if (!_serviceEnabled) {
          return;
        }
      }

      _permissionGranted = await location.hasPermission();
      if (_permissionGranted == PermissionStatus.denied) {
        _permissionGranted = await location.requestPermission();
        if (_permissionGranted != PermissionStatus.granted) {
          return;
        }
      }


      _locationData = await _locationTracker.getLocation();

      updateMarkerAndCircle(_locationData, imageData);

      if (_locationSubscription != null) {
        _locationSubscription?.cancel();
      }


      _locationSubscription = _locationTracker.onLocationChanged.listen((newLocalData) {
        if (_controller != null) {
          _controller!.animateCamera(CameraUpdate.newCameraPosition(new CameraPosition(
              bearing: 192.8334901395799,
              target: LatLng(newLocalData.latitude!, newLocalData.longitude!),
              tilt: 0,
              zoom: 18.00)));
          updateMarkerAndCircle(newLocalData, imageData);
        }
      });

    } on PlatformException catch (e) {
      if (e.code == 'PERMISSION_DENIED') {
        debugPrint("Permission Denied");
      }
    }
  }

  @override
  void dispose() {
    if (_locationSubscription != null) {
      _locationSubscription!.cancel();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: GoogleMap(
        mapType: MapType.hybrid,
        initialCameraPosition: initialLocation,        
        //markers: Set.of((marker != null) ? [marker!] : []),
        circles: Set.of((circle != null) ? [circle!] : []),
        onMapCreated: (GoogleMapController controller) {
          _controller = controller;
        },
        markers: _createMarkers(),
      ),
      floatingActionButton: FloatingActionButton(        
        child: Icon(Icons.directions),
        onPressed: () {
            getCurrentLocation();
          }),
      
    );
  }


}