import 'dart:convert';

import 'package:demarche_app/model/Admin.dart';
import 'package:demarche_app/model/Forum.dart';
import 'package:demarche_app/model/Utilisateur.dart';

class Reponse {
  int idReponse;
  String reponse;
  Forum forum;
  Utilisateur utilisateur;
  
  Reponse({
    required this.idReponse,
    required this.reponse,
    required this.forum,
    required this.utilisateur,
  });

  Reponse copyWith({
    int? idReponse,
    String? reponse,
    Forum? forum,
    Utilisateur? utilisateur,
  }) {
    return Reponse(
      idReponse: idReponse ?? this.idReponse,
      reponse: reponse ?? this.reponse,
      forum: forum ?? this.forum,
      utilisateur: utilisateur ?? this.utilisateur,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'idReponse': idReponse,
      'reponse': reponse,
      'forum': forum.toMap(),
      'utilisateur': utilisateur.toMap(),
    };
  }

  factory Reponse.fromMap(Map<String, dynamic> map) {
    return Reponse(
      idReponse: map['idReponse'] as int,
      reponse: map['reponse'] as String,
      forum: Forum.fromMap(map['forum'] as Map<String,dynamic>),
      utilisateur: Utilisateur.fromMap(map['utilisateur'] as Map<String,dynamic>),
    );
  }

  String toJson() => json.encode(toMap());

  factory Reponse.fromJson(String source) => Reponse.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Reponse(idReponse: $idReponse, reponse: $reponse, forum: $forum, utilisateur: $utilisateur)';
  }

  @override
  bool operator ==(covariant Reponse other) {
    if (identical(this, other)) return true;
  
    return 
      other.idReponse == idReponse &&
      other.reponse == reponse &&
      other.forum == forum &&
      other.utilisateur == utilisateur;
  }

  @override
  int get hashCode {
    return idReponse.hashCode ^
      reponse.hashCode ^
      forum.hashCode ^
      utilisateur.hashCode;
  }
}
