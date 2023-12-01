import 'dart:async';
import 'dart:convert';

import 'package:demarche_app/model/Bureau.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
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
  late GoogleMapController mapController;
  static const LatLng _pBamako = LatLng(12.6430677, -8.0337624);
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
      data.printInfo();
      return data.map((dataBureau) => Bureau.fromMap(dataBureau)).toList();
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
    return Scaffold();
  }
}
