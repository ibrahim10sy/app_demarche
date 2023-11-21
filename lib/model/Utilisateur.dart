

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

  String toJson() => json.encode(toMap());

  factory Utilisateur.fromJson(String source) =>
      Utilisateur.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Utilisateur(idUtilisateur: $idUtilisateur, nom: $nom, prenom: $prenom, email: $email, motDePasse: $motDePasse, image: $image)';
  }

  @override
  bool operator ==(covariant Utilisateur other) {
    if (identical(this, other)) return true;

    return other.idUtilisateur == idUtilisateur &&
        other.nom == nom &&
        other.prenom == prenom &&
        other.email == email &&
        other.motDePasse == motDePasse &&
        other.image == image;
  }

  @override
  int get hashCode {
    return idUtilisateur.hashCode ^
        nom.hashCode ^
        prenom.hashCode ^
        email.hashCode ^
        motDePasse.hashCode ^
        image.hashCode;
  }
}
