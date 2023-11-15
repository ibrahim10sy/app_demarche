// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Admin {
  final int? idAdmin;
  final String nom;
  final String prenom;
  final String email;
  final String motDePasse;
  final String? image;

  Admin({
    this.idAdmin,
    required this.nom,
    required this.prenom,
    required this.email,
    required this.motDePasse,
    this.image,
  });

  Admin copyWith({
    int? idAdmin,
    String? nom,
    String? prenom,
    String? email,
    String? motDePasse,
    String? image,
  }) {
    return Admin(
      idAdmin: idAdmin ?? this.idAdmin,
      nom: nom ?? this.nom,
      prenom: prenom ?? this.prenom,
      email: email ?? this.email,
      motDePasse: motDePasse ?? this.motDePasse,
      image: image ?? this.image,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'idAdmin': idAdmin,
      'nom': nom,
      'prenom': prenom,
      'email': email,
      'motDePasse': motDePasse,
      'image': image,
    };
  }

  factory Admin.fromMap(Map<String, dynamic> map) {
    return Admin(
      idAdmin: map['idAdmin'] != null ? map['idAdmin'] as int : null,
      nom: map['nom'] as String,
      prenom: map['prenom'] as String,
      email: map['email'] as String,
      motDePasse: map['motDePasse'] as String,
      image: map['image'] != null ? map['image'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Admin.fromJson(String source) =>
      Admin.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Admin(idAdmin: $idAdmin, nom: $nom, prenom: $prenom, email: $email, motDePasse: $motDePasse, image: $image)';
  }

  @override
  bool operator ==(covariant Admin other) {
    if (identical(this, other)) return true;

    return other.idAdmin == idAdmin &&
        other.nom == nom &&
        other.prenom == prenom &&
        other.email == email &&
        other.motDePasse == motDePasse &&
        other.image == image;
  }

  @override
  int get hashCode {
    return idAdmin.hashCode ^
        nom.hashCode ^
        prenom.hashCode ^
        email.hashCode ^
        motDePasse.hashCode ^
        image.hashCode;
  }
}
