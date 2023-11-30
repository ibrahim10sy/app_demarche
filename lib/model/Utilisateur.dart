

import 'dart:convert';

class Utilisateur {
  final int? idUtilisateur;
  final String nom;
  final String prenom;
  final String email;
  final String motDePasse;
  final String? image;

  Utilisateur({
    required this.idUtilisateur,
    required this.nom,
    required this.prenom,
    required this.email,
    required this.motDePasse,
    this.image,
  });

  Utilisateur copyWith({
    int? idUtilisateur,
    String? nom,
    String? prenom,
    String? email,
    String? motDePasse,
    String? image,
  }) {
    return Utilisateur(
      idUtilisateur: idUtilisateur ?? this.idUtilisateur,
      nom: nom ?? this.nom,
      prenom: prenom ?? this.prenom,
      email: email ?? this.email,
      motDePasse: motDePasse ?? this.motDePasse,
      image: image ?? this.image,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'idUtilisateur': idUtilisateur,
      'nom': nom,
      'prenom': prenom,
      'email': email,
      'motDePasse': motDePasse,
      'image': image,
    };
  }

  factory Utilisateur.fromMap(Map<String, dynamic> map) {
    return Utilisateur(
      idUtilisateur: map['idUtilisateur'] as int,
      nom: map['nom'] as String,
      prenom: map['prenom'] as String,
      email: map['email'] as String,
      motDePasse: map['motDePasse'] as String,
      image: map['image'] != null ? map['image'] as String : null,
    );
  }

 factory Utilisateur.fromJson(Map<String, dynamic> json) {
    return Utilisateur(
      idUtilisateur: json['idUtilisateur'],
      nom: json['nom'],
      prenom: json['prenom'],
      email: json['email'],
      motDePasse: json['motDePasse'],
      image: json['image'],
    );
  }
}
