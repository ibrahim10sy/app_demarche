// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'dart:convert';

import 'package:demarche_app/model/Admin.dart';
import 'package:demarche_app/model/Utilisateur.dart';

class Forum {
  int idForum;
  String libelle;
  String description;
  Utilisateur utilisateur;
  Forum({
    required this.idForum,
    required this.libelle,
    required this.description,
    required this.utilisateur,
  });
 

  Forum copyWith({
    int? idForum,
    String? libelle,
    String? description,
    Utilisateur? utilisateur,
  }) {
    return Forum(
      idForum: idForum ?? this.idForum,
      libelle: libelle ?? this.libelle,
      description: description ?? this.description,
      utilisateur: utilisateur ?? this.utilisateur,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'idForum': idForum,
      'libelle': libelle,
      'description': description,
      'utilisateur': utilisateur.toMap(),
    };
  }

  factory Forum.fromMap(Map<String, dynamic> map) {
    return Forum(
      idForum: map['idForum'] as int,
      libelle: map['libelle'] as String,
      description: map['description'] as String,
      utilisateur: Utilisateur.fromMap(map['utilisateur'] as Map<String,dynamic>),
    );
  }

  String toJson() => json.encode(toMap());

  factory Forum.fromJson(String source) => Forum.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Forum(idForum: $idForum, libelle: $libelle, description: $description, utilisateur: $utilisateur)';
  }

  @override
  bool operator ==(covariant Forum other) {
    if (identical(this, other)) return true;
  
    return 
      other.idForum == idForum &&
      other.libelle == libelle &&
      other.description == description &&
      other.utilisateur == utilisateur;
  }

  @override
  int get hashCode {
    return idForum.hashCode ^
      libelle.hashCode ^
      description.hashCode ^
      utilisateur.hashCode;
  }
}
