import 'dart:async';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:rlbasic/models/directions_model.dart';
import 'package:rlbasic/pantallas/company/config_company.dart';
import 'package:rlbasic/services/deliveryServices.dart';
import 'package:rlbasic/services/place_service.dart';
import 'package:rlbasic/services/userServices.dart';

class Mapa extends StatefulWidget {
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
  Marker? init;
  bool start = false;

  //cambiar marcador por el de almacen
  Marker _destination = Marker(
    markerId: MarkerId("toDestination"),
    position: globalData.coordenadas,
    infoWindow: InfoWindow(title: "Destination"),
  );

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

  void updateMarkerAndCircle(LocationData newLocalData, Uint8List imageData) {
    LatLng latlng = LatLng(newLocalData.latitude!, newLocalData.longitude!);
    this.setState(() {
      _origin = Marker(
          markerId: MarkerId("origin"),
          position: latlng,
          rotation: newLocalData.heading!,
          draggable: false,
          zIndex: 2,
          flat: true,
          anchor: Offset(0.5, 0.5),
          icon: BitmapDescriptor.fromBytes(imageData));
      if (init == null) {
        init = _origin;
      }
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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: const Text('Google Maps'),
        actions: [
          if (_destination != null)
            TextButton(
              onPressed: () {
                //enviar notificacion tipo: el repartidor vendra a recoger el paquete en totalduration
                DeliveryServices().setTime(
                    "id",
                    DateTime.now().toString() +
                        ' mas ' +
                        _info!.totalDuration.toString());
                print(DateTime.now().toString() +
                    ' mas ' +
                    _info!.totalDuration.toString());
                setState(() => start = true);
              },
              style: TextButton.styleFrom(
                primary: Colors.white,
                textStyle: const TextStyle(fontWeight: FontWeight.w600),
              ),
              child: const Text('Start'),
            )
        ],
      ),
      body: Stack(alignment: Alignment.bottomCenter, children: [
        GoogleMap(
          myLocationButtonEnabled: false,
          mapType: MapType.hybrid,
          zoomControlsEnabled: true,
          initialCameraPosition: initialLocation,
          markers: {
            if (_origin != null) _origin!,
            if (_destination != null) _destination
          },
          circles: Set.of((circle != null) ? [circle!] : []),
          onMapCreated: (GoogleMapController controller) {
            _controller = controller;
          },
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
        ),
        if (_info != null && start == false)
          Positioned(
            top: 20.0,
            child: Container(
              padding: const EdgeInsets.symmetric(
                vertical: 6.0,
                horizontal: 12.0,
              ),
              decoration: BoxDecoration(
                color: Colors.cyan[400],
                borderRadius: BorderRadius.circular(20.0),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black26,
                    offset: Offset(0, 2),
                    blurRadius: 6.0,
                  )
                ],
              ),
              child: Text(
                '${_info!.totalDistance}, ${_info!.totalDuration}',
                style: const TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        if (_info != null && start == true)
          Positioned(
            top: 20.0,
            child: Container(
              padding: const EdgeInsets.symmetric(
                vertical: 6.0,
                horizontal: 12.0,
              ),
              decoration: BoxDecoration(
                color: Colors.greenAccent,
                borderRadius: BorderRadius.circular(20.0),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black26,
                    offset: Offset(0, 2),
                    blurRadius: 6.0,
                  )
                ],
              ),
              child: Text(
                'Llegará a su destino en ${_info!.totalDuration}',
                style: const TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ButtonBar(children: <Widget>[
              FloatingActionButton(
                  heroTag: "btn1",
                  child: Icon(Icons.attribution),
                  onPressed: () {
                    getCurrentLocation();
                  }),
              FloatingActionButton(
                  heroTag: "btn2",
                  child: Icon(Icons.directions),
                  onPressed: () {
                    getDirections();
                  }),
            ]),
          ],
        ),
      ]),
    );
  }

  void getDirections() async {
    if (_origin == null) getCurrentLocation();
// Get directions
    final directions = await DirectionsRepository().getDirections(
        origin: init!.position, destination: _destination.position);
    setState(() => _info = directions);
    _controller!.animateCamera(
      CameraUpdate.newCameraPosition(initialLocation),
    );
  }
}
