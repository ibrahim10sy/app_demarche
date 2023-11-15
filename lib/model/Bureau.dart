// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

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
      admin: Admin.fromMap(map['admin'] as Map<String,dynamic>),
    );
  }

  String toJson() => json.encode(toMap());

  factory Bureau.fromJson(String source) => Bureau.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Bureau(idBureau: $idBureau, nom: $nom, ville: $ville, adresse: $adresse, latitude: $latitude, longitude: $longitude, admin: $admin)';
  }

  @override
  bool operator ==(covariant Bureau other) {
    if (identical(this, other)) return true;
  
    return 
      other.idBureau == idBureau &&
      other.nom == nom &&
      other.ville == ville &&
      other.adresse == adresse &&
      other.latitude == latitude &&
      other.longitude == longitude &&
      other.admin == admin;
  }

  @override
  int get hashCode {
    return idBureau.hashCode ^
      nom.hashCode ^
      ville.hashCode ^
      adresse.hashCode ^
      latitude.hashCode ^
      longitude.hashCode ^
      admin.hashCode;
  }
}
