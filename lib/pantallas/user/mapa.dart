import 'dart:async';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:rlbasic/models/directions_model.dart';
import 'package:rlbasic/pantallas/user/directions_repository.dart';

class Mapa extends StatefulWidget {
  final LatLng fromPoint = LatLng(-38.956176, -67.920666);
  final LatLng toPoint = LatLng(-38.953724, -67.923921);
  @override
  _MapaState createState() => _MapaState();
}

class _MapaState extends State<Mapa> {
  static final CameraPosition initialLocation = CameraPosition(
    target: LatLng(41.2789, 1.97924),
    zoom: 14.4746,
  );

  GoogleMapController? _controller;
  Marker? marker;
  Circle? circle;
  Location _locationTracker = Location();
  StreamSubscription? _locationSubscription;
  Directions? _info;
  Marker? _origin;
  Marker _destination = Marker(
    markerId: MarkerId("toDestination"),
    position: LatLng(41.2757, 1.98712),
    infoWindow: InfoWindow(title: "Destination"),
  );

  //Directions _info;

  var tmp = Set<Marker>();

  @override
  void dispose() {
    _controller!.dispose();
    super.dispose();
  }

  Future<Uint8List> getMarker() async {
    ByteData byteData =
        await DefaultAssetBundle.of(context).load('assets/images/car_icon.png');
    return byteData.buffer.asUint8List();
  }

  Marker? _createMarkers() {
    _destination = Marker(
      markerId: MarkerId("toDestination"),
      position: LatLng(41.2757, 1.98712),
      infoWindow: InfoWindow(title: "Destination"),
    );
    /*tmp.add(Marker(
      markerId: MarkerId("toDestination"),
      position: LatLng(41.2757, 1.98712),
/*           draggable: false,
          zIndex: 2,
          flat: true,
          anchor: Offset(0.5, 0.5), */
      infoWindow: InfoWindow(title: "Destination"),

      // icon: BitmapDescriptor.fromBytes(imageData)
    ));
     
    tmp.add(
      Marker(
        markerId: MarkerId("toPoint"),
        position: LatLng(41.2757, 1.98712),
        infoWindow: InfoWindow(title: "Roca 123"),
      ),
    ); */
    return _destination;
  }

  void updateMarkerAndCircle(LocationData newLocalData, Uint8List imageData) {
    LatLng latlng = LatLng(newLocalData.latitude!, newLocalData.longitude!);
    this.setState(() {
      _origin=Marker(
          markerId: MarkerId("origin"),
          position: latlng,
          rotation: newLocalData.heading!,
          draggable: false,
          zIndex: 2,
          flat: true,
          anchor: Offset(0.5, 0.5),
          icon: BitmapDescriptor.fromBytes(imageData));
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

      _locationSubscription =
          _locationTracker.onLocationChanged.listen((newLocalData) {
        if (_controller != null) {
          _controller!.animateCamera(CameraUpdate.newCameraPosition(
              new CameraPosition(
                  bearing: 192.8334901395799,
                  target:
                      LatLng(newLocalData.latitude!, newLocalData.longitude!),
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
  Widget build(BuildContext context){
    return new Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: const Text('Google Maps'),
        actions: [
          if (_origin != null)
            TextButton(
              onPressed: () => _controller!.animateCamera(
                CameraUpdate.newCameraPosition(
                  CameraPosition(
                    target: _origin!.position,
                    zoom: 14.5,
                    tilt: 50.0,
                  ),
                ),
              ),
              style: TextButton.styleFrom(
                primary: Colors.white,
                textStyle: const TextStyle(fontWeight: FontWeight.w600),
              ),
              child: const Text('ORIGIN'),
            ),
          if (_destination != null)
            TextButton(
              onPressed: () => _controller!.animateCamera(
                CameraUpdate.newCameraPosition(
                  CameraPosition(
                    target: _destination.position,
                    zoom: 20.5,
                    tilt: 50.0,
                  ),
                ),
              ),
              style: TextButton.styleFrom(
                primary: Colors.white,
                textStyle: const TextStyle(fontWeight: FontWeight.w600),
              ),
              child: const Text('DEST'),
            )
        ],
      ),
      body: Stack(
        alignment: Alignment.center,
        children: [
          GoogleMap(
            mapType: MapType.hybrid,
            zoomControlsEnabled: true,
            initialCameraPosition: initialLocation,
            markers: {
              if(_origin != null) _origin!,
              if(_destination != null) _destination
            },
            circles: Set.of((circle != null) ? [circle!] : []),
            onMapCreated: (GoogleMapController controller) {
              _controller = controller;
            },
            //markers: Set.of((_createMarkers()),
            polylines: {
              if (_info != null)
                Polyline(
                  polylineId: const PolylineId('overview_polyline'),
                  color: Colors.red,
                  width: 5,
                  points: _info!.polylinePoints
                      .map((e) => LatLng(e.latitude, e.longitude))
                      .toList(),
                ),
            },
          //  onLongPress: _addMarker,
          ),
          ButtonBar(
            children: <Widget>[
              FloatingActionButton(
                child: Icon(Icons.location_city),
                onPressed: () {
                  getCurrentLocation();
                }),
              FloatingActionButton(
                child: Icon(Icons.directions),
                onPressed: () {
                  getDirections();
                }),
            ]
          ),
        ]
      ),     

      
      
    );

    
  }

  void getDirections() async{
// Get directions
       final directions = await DirectionsRepository()
          .getDirections(origin: _origin!.position, destination: _destination.position);
      setState(() => _info = directions);
  }
}
