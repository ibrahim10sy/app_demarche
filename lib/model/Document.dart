import 'dart:convert';

import 'package:demarche_app/model/Admin.dart';
import 'package:demarche_app/model/Bureau.dart';
import 'package:demarche_app/model/Guide.dart';

class Document {
  final int? idDocument;
  final String? image;
  final String? audio;
  final String? fichier;
  final String nom;
  final String description;
  final Guide guide;
  final Admin admin;
  final Bureau bureau;
  Document({
    this.idDocument,
    this.image,
    this.audio,
    this.fichier,
    required this.nom,
    required this.description,
    required this.guide,
    required this.admin,
    required this.bureau,
  });

  Document copyWith({
    int? idDocument,
    String? image,
    String? audio,
    String? fichier,
    String? nom,
    String? description,
    Guide? guide,
    Admin? admin,
    Bureau? bureau,
  }) {
    return Document(
      idDocument: idDocument ?? this.idDocument,
      image: image ?? this.image,
      audio: audio ?? this.audio,
      fichier: fichier ?? this.fichier,
      nom: nom ?? this.nom,
      description: description ?? this.description,
      guide: guide ?? this.guide,
      admin: admin ?? this.admin,
      bureau: bureau ?? this.bureau,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'idDocument': idDocument,
      'image': image,
      'audio': audio,
      'fichier': fichier,
      'nom': nom,
      'description': description,
      'guide': guide.toMap(),
      'admin': admin.toMap(),
      'bureau': bureau.toMap(),
    };
  }

  factory Document.fromMap(Map<String, dynamic> map) {
    return Document(
      idDocument: map['idDocument'] != null ? map['idDocument'] as int : null,
      image: map['image'] != null ? map['image'] as String : null,
      audio: map['audio'] != null ? map['audio'] as String : null,
      fichier: map['fichier'] != null ? map['fichier'] as String : null,
      nom: map['nom'] as String,
      description: map['description'] as String,
      guide: Guide.fromMap(map['guide'] as Map<String,dynamic>),
      admin: Admin.fromMap(map['admin'] as Map<String,dynamic>),
      bureau: Bureau.fromMap(map['bureau'] as Map<String,dynamic>),
    );
  }

  String toJson() => json.encode(toMap());

  factory Document.fromJson(String source) => Document.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Document(idDocument: $idDocument, image: $image, audio: $audio, fichier: $fichier, nom: $nom, description: $description, guide: $guide, admin: $admin, bureau: $bureau)';
  }

  @override
  bool operator ==(covariant Document other) {
    if (identical(this, other)) return true;
  
    return 
      other.idDocument == idDocument &&
      other.image == image &&
      other.audio == audio &&
      other.fichier == fichier &&
      other.nom == nom &&
      other.description == description &&
      other.guide == guide &&
      other.admin == admin &&
      other.bureau == bureau;
  }

  @override
  int get hashCode {
    return idDocument.hashCode ^
      image.hashCode ^
      audio.hashCode ^
      fichier.hashCode ^
      nom.hashCode ^
      description.hashCode ^
      guide.hashCode ^
      admin.hashCode ^
      bureau.hashCode;
  }
}
