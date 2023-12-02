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
  // List<Marker> markers = [];
  final Location _locationController = Location();

  final Completer<GoogleMapController> _mapController =
      Completer<GoogleMapController>();

  final LatLng _center = const LatLng(12.6392, -8.0029);
  // final LatLng _position = const LatLng(12.6290579, -8.071855);
  LatLng? _currentP;
  // void _onMapCreated(GoogleMapController controller) async {
  //   mapController = controller;

  //   try {
  //     List<Bureau> dataBureau = await fetchdata();
  //     _addMarkers(dataBureau);
  //   } catch (e) {
  //     throw Exception("Impossile de charger les data");
  //   }
  // }

  // Future<List<Bureau>> fetchdata() async {
  //   final response =
  //       await http.get(Uri.parse("http://10.0.2.2:8080/Bureau/read"));

  //   if (response.statusCode == 200) {
  //     final List<dynamic> data = json.decode(response.body);
  //     print("donner recuperer");
  //     data.printInfo();
  //     return data.map((dataBureau) => Bureau.fromJson(dataBureau)).toList();
  //   } else {
  //     throw Exception('Impossile de trouver les données');
  //   }
  // }

  // void _addMarkers(List<Bureau> bureaux) {
  //   setState(() {
  //     markers = bureaux.map((bureau) {
  //       return Marker(
  //         markerId: MarkerId(bureau.idBureau.toString()),
  //         position: LatLng(
  //             double.parse(bureau.latitude), double.parse(bureau.longitude)),
  //         infoWindow: InfoWindow(title: bureau.nom),
  //         icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
  //       );
  //     }).toList();
  //   });
  // }

  @override
  void initState() {
    super.initState();
    getLocationUpdates();
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
                initialCameraPosition: CameraPosition(target: _center),
                markers: {
                    Marker(
                        markerId: const MarkerId("my_position"),
                        icon: BitmapDescriptor.defaultMarker,
                        position: _currentP!),
                  }));
  }

  Future<void> _cameraToPosition(LatLng pos) async {
    final GoogleMapController controller = await _mapController.future;
    CameraPosition newCameraPosition = CameraPosition(target: pos, zoom: 13);
    await controller
        .animateCamera(CameraUpdate.newCameraPosition(newCameraPosition));
  }

  Future<void> getLocationUpdates() async {
    bool serviceEnabled;

    PermissionStatus permissonsGaranted;

    serviceEnabled = await _locationController.serviceEnabled();
    if (serviceEnabled) {
      serviceEnabled = await _locationController.serviceEnabled();
    } else {
      return;
    }
    permissonsGaranted = await _locationController.hasPermission();
    if (permissonsGaranted == PermissionStatus.denied) {
      permissonsGaranted = await _locationController.requestPermission();
      if (permissonsGaranted != PermissionStatus.granted) {
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
