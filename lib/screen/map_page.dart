import 'dart:async';

import 'package:demarche_app/model/Bureau.dart';
import 'package:demarche_app/service/bureauService.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class MapPage extends StatefulWidget {
  const MapPage({Key? key}) : super(key: key);

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  final Location _locationController = Location();
  final Completer<GoogleMapController> _mapController =
      Completer<GoogleMapController>();
  final LatLng _center = const LatLng(12.65906, -7.98552);
  late Future<List<Bureau>> _bureauListe;
  var bureauService = BureauService();

  Future<List<Bureau>> getBureau() async {
    return bureauService.fetchbureau();
  }

  @override
  void initState() {
    super.initState();
    _bureauListe = getBureau();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: FutureBuilder<List<Bureau>>(
            future: _bureauListe,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: Text("Chargement..."),
                );
              } else if (snapshot.hasError) {
                return Center(child: Text('Erreur : ${snapshot.error}'));
              } else {
                return GoogleMap(
                  onMapCreated: (GoogleMapController controller) =>
                      _mapController.complete(controller),
                  initialCameraPosition:
                      CameraPosition(target: _center, zoom: 13),
                  markers: Set.from(snapshot.data!.map((bureauLocation) =>
                      Marker(
                          markerId:
                              MarkerId(bureauLocation.idBureau.toString()),
                          position: LatLng(
                              double.parse(bureauLocation.latitude),
                              double.parse(bureauLocation.longitude)),
                          infoWindow: InfoWindow(title: bureauLocation.nom)))),
                );
              }
            }));
  }
}



// GoogleMap(
//           onMapCreated: (GoogleMapController controller) =>
//               _mapController.complete(controller),
//           initialCameraPosition: CameraPosition(target: _center, zoom: 13),
//           markers: {
//             Marker(
//                 markerId: const MarkerId("Ma position"),
//                 position: _center,
//                 infoWindow: const InfoWindow(
//                   title: "position",
//                 ))
//           }),