// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Actualite {
  final int? idActualite;
  final String libelle;
  final String image;
  final String description;
  final DateTime dateDebut;
  final DateTime dateFin;
  
  Actualite({
    this.idActualite,
    required this.libelle,
    required this.image,
    required this.description,
    required this.dateDebut,
    required this.dateFin,
  });

 

  Actualite copyWith({
    int? idActualite,
    String? libelle,
    String? image,
    String? description,
    DateTime? dateDebut,
    DateTime? dateFin,
  }) {
    return Actualite(
      idActualite: idActualite ?? this.idActualite,
      libelle: libelle ?? this.libelle,
      image: image ?? this.image,
      description: description ?? this.description,
      dateDebut: dateDebut ?? this.dateDebut,
      dateFin: dateFin ?? this.dateFin,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'idActualite': idActualite,
      'libelle': libelle,
      'image': image,
      'description': description,
      'dateDebut': dateDebut.millisecondsSinceEpoch,
      'dateFin': dateFin.millisecondsSinceEpoch,
    };
  }

  factory Actualite.fromMap(Map<String, dynamic> map) {
    return Actualite(
      idActualite: map['idActualite'] != null ? map['idActualite'] as int : null,
      libelle: map['libelle'] as String,
      image: map['image'] as String,
      description: map['description'] as String,
      dateDebut: DateTime.fromMillisecondsSinceEpoch(map['dateDebut'] as int),
      dateFin: DateTime.fromMillisecondsSinceEpoch(map['dateFin'] as int),
    );
  }

  String toJson() => json.encode(toMap());

  factory Actualite.fromJson(String source) => Actualite.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Actualite(idActualite: $idActualite, libelle: $libelle, image: $image, description: $description, dateDebut: $dateDebut, dateFin: $dateFin)';
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
      other.dateFin == dateFin;
  }

  @override
  int get hashCode {
    return idActualite.hashCode ^
      libelle.hashCode ^
      image.hashCode ^
      description.hashCode ^
      dateDebut.hashCode ^
      dateFin.hashCode;
  }
}
