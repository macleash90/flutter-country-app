import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:async';

import 'package:flutter/material.dart';

class CountryMap extends StatefulWidget {
//  final Map country;
  static const routeName = '/country-map';
//  static final CameraPosition _kGooglePlex = ;
  static final CameraPosition _kLake = CameraPosition(
      bearing: 192.8334901395799,
      target: LatLng(37.43296265331129, -122.08832357078792),
      tilt: 59.440717697143555,
      zoom: 6);

//  CountryMap(this.country);

  @override
  _CountryMapState createState() => _CountryMapState();
}

class _CountryMapState extends State<CountryMap> {
  Completer<GoogleMapController> _controller = Completer();

  @override
  Widget build(BuildContext context) {
    final Map country = ModalRoute.of(context).settings.arguments;
    print(country);
    return Scaffold(
      appBar: AppBar(
        title: Text('Map: ' + country['name']),
        backgroundColor: Colors.pink,
      ),
      body: GoogleMap(
//        mapType: MapType.satellite,
        initialCameraPosition: CameraPosition(
          target: LatLng(country['latlng'][0], country['latlng'][1]),
          zoom: 6,
        ),
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
      ),
//      floatingActionButton: FloatingActionButton.extended(
//        onPressed: _goToTheLake,
//        label: Text('To the lake!'),
//        icon: Icon(Icons.directions_boat),
//      ),
    );
  }

//  Future<void> _goToTheLake() async {
//    final GoogleMapController controller = await _controller.future;
//    controller.animateCamera(CameraUpdate.newCameraPosition(CountryMap._kLake));
//  }
}
