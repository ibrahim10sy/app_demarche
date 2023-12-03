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
  LatLng? _currentP;

  Future<List<Bureau>> getBureau() async {
    return bureauService.fetchbureau();
  }

  //Methodde pour recuperer la position de l'utilisateur

  Future<void> _getUserLocation() async {
    try {
      var userLocation = await _locationController.getLocation();
      setState(() {
        _currentP = LatLng(userLocation.latitude!, userLocation.longitude!);
      });
    } catch (e) {
      print(
          "Erreur lors de la recuperation de la position de l'utilisateur : $e");
    }
  }

  @override
  void initState() {
    super.initState();
    _bureauListe = getBureau();
    _getUserLocation();
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
                  markers: {
                    if (_currentP != null)
                      Marker(
                        markerId: const MarkerId("userLocation"),
                        position: _currentP!,
                        infoWindow: const InfoWindow(title: "Votre position"),
                      ),
                    ...snapshot.data!.map(
                      (bureauLocation) => Marker(
                        markerId: MarkerId(bureauLocation.idBureau.toString()),
                        position: LatLng(
                          double.parse(bureauLocation.latitude),
                          double.parse(bureauLocation.longitude),
                        ),
                        infoWindow: InfoWindow(title: bureauLocation.nom),
                      ),
                    )
                  },
                );
              }
            }));
  }
}
