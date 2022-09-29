import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../constant.dart';
import 'package:location/location.dart';
class PharmaciesLocationScreen extends StatefulWidget {
  const PharmaciesLocationScreen({Key? key}) : super(key: key);

  @override
  State<PharmaciesLocationScreen> createState() => _PharmaciesLocationScreenState();
}

class _PharmaciesLocationScreenState extends State<PharmaciesLocationScreen> {
  final Completer<GoogleMapController> _controller = Completer();

  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );

  static const CameraPosition _kLake = CameraPosition(
      bearing: 192.8334901395799,
      target: LatLng(37.43296265331129, -122.08832357078792),
      tilt: 59.440717697143555,
      zoom: 19.151926040649414);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
        body: GoogleMap(
        mapType: MapType.hybrid,
        initialCameraPosition: _kGooglePlex,
        onMapCreated: (GoogleMapController controller){
      _controller.complete(controller);
    },
    ),
    floatingActionButton: FloatingActionButton.extended(
    onPressed: _getLocation,
    label: const Text('To the lake!'),
    icon: const Icon(Icons.directions_boat),
    ),
    ));
  }

Future<void> _goToTheLake() async {
  final GoogleMapController controller = await _controller.future;
  controller.animateCamera(CameraUpdate.newCameraPosition(_kLake));
}

Future<void> _getLocation()async{
final data =Location().getLocation();
print(data);
}
}
