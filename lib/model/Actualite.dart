// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Actualites {
  final int? idActualite;
  final String libelle;
  final String image;
  final String description;
  final DateTime dateDebut;
  final DateTime dateFin;
  
  Actualites({
    this.idActualite,
    required this.libelle,
    required this.image,
    required this.description,
    required this.dateDebut,
    required this.dateFin,
  });
  
 

  Actualites copyWith({
    int? idActualite,
    String? libelle,
    String? image,
    String? description,
    DateTime? dateDebut,
    DateTime? dateFin,
  }) {
    return Actualites(
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

  factory Actualites.fromMap(Map<String, dynamic> map) {
    return Actualites(
      idActualite: map['idActualite'] != null ? map['idActualite'] as int : null,
      libelle: map['libelle'] as String,
      image: map['image'] as String,
      description: map['description'] as String,
      dateDebut: DateTime.fromMillisecondsSinceEpoch(map['dateDebut'] as int),
      dateFin: DateTime.fromMillisecondsSinceEpoch(map['dateFin'] as int),
    );
  }

  String toJson() => json.encode(toMap());

  factory Actualites.fromJson(String source) => Actualites.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Actualites(idActualite: $idActualite, libelle: $libelle, image: $image, description: $description, dateDebut: $dateDebut, dateFin: $dateFin)';
  }

  @override
  bool operator ==(covariant Actualites other) {
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
