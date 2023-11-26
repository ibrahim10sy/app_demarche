import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapPage extends StatefulWidget {
  const MapPage({super.key});

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  static const LatLng _pGooglePlex = LatLng(12.65906, -7.98552);
  static const LatLng _pApplePark = LatLng(37.3346, -122.0090);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        body: GoogleMap(
      initialCameraPosition: CameraPosition(
        target: _pGooglePlex,
        zoom: 13,
      ),
      markers: {
        // Marker(
        //     markerId: MarkerId("_currentLocation"),
        //     icon: BitmapDescriptor.defaultMarker,
        //     position: _pGooglePlex)
      },
    )
    );
  }
}
