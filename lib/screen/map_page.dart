import 'dart:async';
import 'dart:convert';

import 'package:demarche_app/model/Bureau.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:http/http.dart' as http;

class MapPage extends StatefulWidget {
  const MapPage({super.key});

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  final Location _locationController = Location();

  final Completer<GoogleMapController> _mapController =
      Completer<GoogleMapController>();
  late GoogleMapController mapController;
  static const LatLng _pGooglePlex = LatLng(12.627516, -8.015487);
  LatLng? _currentP;
  List<Marker> markers = [];

  void _onMapCreated(GoogleMapController controller) async {
    mapController = controller;

    try {
      List<Bureau> dataBureau = await fetchdata();
      _addMarkers(dataBureau);
    } catch (e) {
      throw Exception("Impossile de charger les data");
    }
  }

  Future<List<Bureau>> fetchdata() async {
    final response =
        await http.get(Uri.parse("http://10.0.2.2:8080/Bureau/read"));

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      print("donner recuperer");
      data.printError();
      return data.map((dataBureau) => Bureau.fromJson(dataBureau)).toList();
    } else {
      throw Exception('Impossile de trouver les données');
    }
  }

  void _addMarkers(List<Bureau> bureaux) {
    setState(() {
      markers = bureaux.map((bureau) {
        return Marker(
          markerId: MarkerId(bureau.idBureau.toString()),
          position: LatLng(
              double.parse(bureau.latitude), double.parse(bureau.longitude)),
          infoWindow: InfoWindow(title: bureau.nom),
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
        );
      }).toList();
    });
  }

  @override
  void initState() {
    // getLocationUpdates();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
        onMapCreated: _onMapCreated,
        initialCameraPosition: CameraPosition(
          target: _pGooglePlex,
          zoom: 11.0,
        ),
        markers: Set.from(markers),
      ),
    );
  }

//  body: _currentP == null
//           ? const Center(
//               child: Text("Chargement..."),
//             )
//           : GoogleMap(
//               onMapCreated: (GoogleMapController controller) =>
//                   _mapController.complete(controller),
//               initialCameraPosition: CameraPosition(
//                 target: _pGooglePlex,
//                 zoom: 13,
//               ),
//               markers: Set<Marker>.from([
//                 Marker(
//                   markerId: const MarkerId("_currentLocation"),
//                   icon: BitmapDescriptor.defaultMarker,
//                   position: _currentP!,
//                 ),
//                 ...markers,
//               ]),
//             ),
  // Future<void> _cameraToPosition(LatLng pos) async {
  //   final GoogleMapController controller = await _mapController.future;
  //   CameraPosition _newCameraPosition = CameraPosition(
  //     target: pos,
  //     zoom: 13,
  //   );

  //   await controller
  //       .animateCamera(CameraUpdate.newCameraPosition(_newCameraPosition));
  // }

  // Future<void> getLocationUpdates() async {
  //   bool serviceEnabled;
  //   PermissionStatus permissionGaranted;

  //   serviceEnabled = await _locationController.serviceEnabled();
  //   if (serviceEnabled) {
  //     serviceEnabled = await _locationController.serviceEnabled();
  //   } else {
  //     return;
  //   }
  //   permissionGaranted = await _locationController.hasPermission();
  //   if (permissionGaranted == PermissionStatus.denied) {
  //     permissionGaranted = await _locationController.requestPermission();
  //     if (permissionGaranted != PermissionStatus.granted) {
  //       return;
  //     }
  //   }

  //   _locationController.onLocationChanged
  //       .listen((LocationData currentLocation) {
  //     if (currentLocation.latitude != null &&
  //         currentLocation.longitude != null) {
  //       setState(() {
  //         _currentP =
  //             LatLng(currentLocation.latitude!, currentLocation.longitude!);
  //         _cameraToPosition(_currentP!);
  //       });
  //     }
  //   });
  // }
}
