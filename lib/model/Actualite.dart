// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:demarche_app/model/Admin.dart';

class Actualite {
  final int idActualite;
  final String libelle;
  final String? image;
  final String description;
  final String dateDebut;
  final String dateFin;
  final Admin admin;

  
  Actualite({
    required this.idActualite,
    required this.libelle,
    this.image,
    required this.description,
    required this.dateDebut,
    required this.dateFin,
    required this.admin,
  });

  

  Actualite copyWith({
    int? idActualite,
    String? libelle,
    String? image,
    String? description,
    String? dateDebut,
    String? dateFin,
    Admin? admin,
  }) {
    return Actualite(
      idActualite: idActualite ?? this.idActualite,
      libelle: libelle ?? this.libelle,
      image: image ?? this.image,
      description: description ?? this.description,
      dateDebut: dateDebut ?? this.dateDebut,
      dateFin: dateFin ?? this.dateFin,
      admin: admin ?? this.admin,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'idActualite': idActualite,
      'libelle': libelle,
      'image': image,
      'description': description,
      'dateDebut': dateDebut,
      'dateFin': dateFin,
      'admin': admin.toMap(),
    };
  }

  factory Actualite.fromMap(Map<String, dynamic> map) {
    return Actualite(
      idActualite: map['idActualite'] as int,
      libelle: map['libelle'] as String,
      image: map['image'] != null ? map['image'] as String : null,
      description: map['description'] as String,
      dateDebut: map['dateDebut'] as String,
      dateFin: map['dateFin'] as String,
      admin: Admin.fromMap(map['admin'] as Map<String,dynamic>),
    );
  }

  String toJson() => json.encode(toMap());

  factory Actualite.fromJson(String source) => Actualite.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Actualite(idActualite: $idActualite, libelle: $libelle, image: $image, description: $description, dateDebut: $dateDebut, dateFin: $dateFin, admin: $admin)';
  }

  @override
  bool operator ==(covariant Actualite other) {
    if (identical(this, other)) return true;
  
    return 
      other.idActualite == idActualite &&
      other.libelle == libelle &&
      other.image == image &&
      other.description == description &&
      other.dateDebut == dateDebut &&
      other.dateFin == dateFin &&
      other.admin == admin;
  }

  @override
  int get hashCode {
    return idActualite.hashCode ^
      libelle.hashCode ^
      image.hashCode ^
      description.hashCode ^
      dateDebut.hashCode ^
      dateFin.hashCode ^
      admin.hashCode;
  }
}
