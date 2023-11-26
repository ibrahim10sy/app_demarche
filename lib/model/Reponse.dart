// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:demarche_app/model/Admin.dart';
import 'package:demarche_app/model/Forum.dart';
import 'package:demarche_app/model/Utilisateur.dart';

class Reponse {
  int idReponse;
  String reponse;
  Forum forum;
  Utilisateur utilisateur;
  Admin admin;
  
  Reponse({
    required this.idReponse,
    required this.reponse,
    required this.forum,
    required this.utilisateur,
    required this.admin,
  });

  Reponse copyWith({
    int? idReponse,
    String? reponse,
    Forum? forum,
    Utilisateur? utilisateur,
    Admin? admin,
  }) {
    return Reponse(
      idReponse: idReponse ?? this.idReponse,
      reponse: reponse ?? this.reponse,
      forum: forum ?? this.forum,
      utilisateur: utilisateur ?? this.utilisateur,
      admin: admin ?? this.admin,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'idReponse': idReponse,
      'reponse': reponse,
      'forum': forum.toMap(),
      'utilisateur': utilisateur.toMap(),
      'admin': admin.toMap(),
    };
  }

  factory Reponse.fromMap(Map<String, dynamic> map) {
    return Reponse(
      idReponse: map['idReponse'] as int,
      reponse: map['reponse'] as String,
      forum: Forum.fromMap(map['forum'] as Map<String,dynamic>),
      utilisateur: Utilisateur.fromMap(map['utilisateur'] as Map<String,dynamic>),
      admin: Admin.fromMap(map['admin'] as Map<String,dynamic>),
    );
  }

  String toJson() => json.encode(toMap());

  factory Reponse.fromJson(String source) => Reponse.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Reponse(idReponse: $idReponse, reponse: $reponse, forum: $forum, utilisateur: $utilisateur, admin: $admin)';
  }

  @override
  bool operator ==(covariant Reponse other) {
    if (identical(this, other)) return true;
  
    return 
      other.idReponse == idReponse &&
      other.reponse == reponse &&
      other.forum == forum &&
      other.utilisateur == utilisateur &&
      other.admin == admin;
  }

  @override
  int get hashCode {
    return idReponse.hashCode ^
      reponse.hashCode ^
      forum.hashCode ^
      utilisateur.hashCode ^
      admin.hashCode;
  }
}
