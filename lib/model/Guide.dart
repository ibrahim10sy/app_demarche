// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:demarche_app/model/Admin.dart';

class Guide {
  final int? idGuide;
  final String? image;
  final String? audio;
  final String libelle;
  final String description;
  final Admin  admin;
  Guide({
    this.idGuide,
    this.image,
    this.audio,
    required this.libelle,
    required this.description,
    required this.admin,
  });

  Guide copyWith({
    int? idGuide,
    String? image,
    String? audio,
    String? libelle,
    String? description,
    Admin? admin,
  }) {
    return Guide(
      idGuide: idGuide ?? this.idGuide,
      image: image ?? this.image,
      audio: audio ?? this.audio,
      libelle: libelle ?? this.libelle,
      description: description ?? this.description,
      admin: admin ?? this.admin,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'idGuide': idGuide,
      'image': image,
      'audio': audio,
      'libelle': libelle,
      'description': description,
      'admin': admin.toMap(),
    };
  }

  factory Guide.fromMap(Map<String, dynamic> map) {
    return Guide(
      idGuide: map['idGuide'] != null ? map['idGuide'] as int : null,
      image: map['image'] != null ? map['image'] as String : null,
      audio: map['audio'] != null ? map['audio'] as String : null,
      libelle: map['libelle'] as String,
      description: map['description'] as String,
      admin: Admin.fromMap(map['admin'] as Map<String,dynamic>),
    );
  }

  String toJson() => json.encode(toMap());

  factory Guide.fromJson(String source) => Guide.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Guide(idGuide: $idGuide, image: $image, audio: $audio, libelle: $libelle, description: $description, admin: $admin)';
  }

  @override
  bool operator ==(covariant Guide other) {
    if (identical(this, other)) return true;
  
    return 
      other.idGuide == idGuide &&
      other.image == image &&
      other.audio == audio &&
      other.libelle == libelle &&
      other.description == description &&
      other.admin == admin;
  }

  @override
  int get hashCode {
    return idGuide.hashCode ^
      image.hashCode ^
      audio.hashCode ^
      libelle.hashCode ^
      description.hashCode ^
      admin.hashCode;
  }
}
