import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
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



Future<void> _getLocation()async{
// final data =Location().getLocation();
}
}
