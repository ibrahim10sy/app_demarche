import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class PageMap extends StatefulWidget {
  const PageMap({super.key});

  @override
  State<PageMap> createState() => _PageMapState();
}

class _PageMapState extends State<PageMap> {
  final Completer<GoogleMapController> _controller = Completer();
  static const CameraPosition _kGoogle = CameraPosition(
    target: LatLng(12.6304268, -8.0282487),
    zoom: 14.4746,
  );

  //////liste des marckers
  final List<Marker> _markers = <Marker>[
    const Marker(
        markerId: MarkerId('1'),
        position: LatLng(12.6430677, -8.0337624),
        infoWindow: InfoWindow(title: "My position"))
  ];

  ////methode pour recuperer la position de user
  Future<Position> getUserCurrentPosition() async {
    await Geolocator.requestPermission()
        .then((value) {})
        .onError((error, stackTrace) async {
      await Geolocator.requestPermission();
      print("Error$error");
    });
    return await Geolocator.getCurrentPosition();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF0F9D58),
        // on below line we have given title of app
        title: const Text("GFG"),
      ),
      body: Container(
        child: SafeArea(
            child: GoogleMap(
          initialCameraPosition: _kGoogle,
          markers: Set<Marker>.of(_markers),
          mapType: MapType.normal,
          myLocationEnabled: true,
          compassEnabled: true,
          onMapCreated: (GoogleMapController controller) {
            _controller.complete(controller);
          },
        )),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          getUserCurrentPosition().then((value) async {
            print("${value.latitude} ${value.longitude}");

            _markers.add(Marker(
              markerId: const MarkerId("2"),
              position: LatLng(value.latitude, value.longitude),
              infoWindow: const InfoWindow(
                title: 'My Current Location',
              ),
            ));
            // specified current users location
            CameraPosition cameraPosition = CameraPosition(
              target: LatLng(value.latitude, value.longitude),
              zoom: 14,
            );

            final GoogleMapController controller = await _controller.future;
            controller
                .animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
            setState(() {});
          });
        },
        child: const Icon(Icons.local_activity),
      ),
    );
  }
}
