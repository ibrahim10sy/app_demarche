import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class MapPage extends StatefulWidget {
  const MapPage({super.key});

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  final Location _locationController = Location();

  final Completer<GoogleMapController> _mapController =
      Completer<GoogleMapController>();
  static const LatLng _pGooglePlex = LatLng(12.65906, -7.98552);
  static const LatLng _pApplePark = LatLng(37.3346, -122.0090);
  LatLng? _currentP;

  @override
  void initState() {
    getLocationUpdates();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: _currentP == null
            ? const Center(
                child: Text("Loading"),
              )
            : GoogleMap(
                onMapCreated: ((GoogleMapController controller) =>
                    _mapController.complete(controller)),
                initialCameraPosition: CameraPosition(
                  target: _pGooglePlex,
                  zoom: 13,
                ),
                markers: {
                  Marker(
                      markerId: const MarkerId("_currentLocation"),
                      icon: BitmapDescriptor.defaultMarker,
                      position: _currentP!),
                  const Marker(
                      markerId: MarkerId("sourceLocation"),
                      icon: BitmapDescriptor.defaultMarker,
                      position: _pGooglePlex),
                  const Marker(
                      markerId: MarkerId("_destinationLocation"),
                      icon: BitmapDescriptor.defaultMarker,
                      position: _pApplePark),
                },
              ));
  }

  Future<void> _cameraToPosition(LatLng pos) async {
    final GoogleMapController controller = await _mapController.future;
    CameraPosition _newCameraPosition = CameraPosition(
      target: pos,
      zoom: 13,
    );

    await controller
        .animateCamera(CameraUpdate.newCameraPosition(_newCameraPosition));
  }

  Future<void> getLocationUpdates() async {
    bool serviceEnabled;
    PermissionStatus permissionGaranted;

    serviceEnabled = await _locationController.serviceEnabled();
    if (serviceEnabled) {
      serviceEnabled = await _locationController.serviceEnabled();
    } else {
      return;
    }
    permissionGaranted = await _locationController.hasPermission();
    if (permissionGaranted == PermissionStatus.denied) {
      permissionGaranted = await _locationController.requestPermission();
      if (permissionGaranted != PermissionStatus.granted) {
        return;
      }
    }

    _locationController.onLocationChanged
        .listen((LocationData currentLocation) {
      if (currentLocation.latitude != null &&
          currentLocation.longitude != null) {
        setState(() {
          _currentP =
              LatLng(currentLocation.latitude!, currentLocation.longitude!);
          _cameraToPosition(_currentP!);
        });
      }
    });
  }
}
