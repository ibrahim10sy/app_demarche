// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:demarche_app/model/Admin.dart';

class Bureau {
  final int? idBureau;
  final String nom;
  final String ville;
  final String adresse;
  final String latitude;
  final String longitude;
  final Admin admin;
  Bureau({
    this.idBureau,
    required this.nom,
    required this.ville,
    required this.adresse,
    required this.latitude,
    required this.longitude,
    required this.admin,
  });

  Bureau copyWith({
    int? idBureau,
    String? nom,
    String? ville,
    String? adresse,
    String? latitude,
    String? longitude,
    Admin? admin,
  }) {
    return Bureau(
      idBureau: idBureau ?? this.idBureau,
      nom: nom ?? this.nom,
      ville: ville ?? this.ville,
      adresse: adresse ?? this.adresse,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      admin: admin ?? this.admin,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'idBureau': idBureau,
      'nom': nom,
      'ville': ville,
      'adresse': adresse,
      'latitude': latitude,
      'longitude': longitude,
      'admin': admin.toMap(),
    };
  }

  factory Bureau.fromMap(Map<String, dynamic> map) {
    return Bureau(
      idBureau: map['idBureau'] != null ? map['idBureau'] as int : null,
      nom: map['nom'] as String,
      ville: map['ville'] as String,
      adresse: map['adresse'] as String,
      latitude: map['latitude'] as String,
      longitude: map['longitude'] as String,
      admin: Admin.fromMap(map['admin'] as Map<String, dynamic>),
    );
  }

  factory Bureau.fromJson(Map<String, dynamic> json) {
    return Bureau(
        nom: json['nom'],
        ville: json['ville'],
        adresse: json['adresse'],
        latitude: json['latitude'],
        longitude: json['longitude'],
        admin: json['admin']);
  }
}
