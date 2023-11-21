import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';
import 'package:provider/provider.dart';
import 'package:demarche_app/model/Utilisateur.dart';
import 'package:demarche_app/provider/utilisateurProvider.dart';

class UtilisateurService extends ChangeNotifier {
  static const String baseUrl = 'http://10.0.2.2:8080/utilisateur/create';

  static Future<Utilisateur> creerCompte({
    required String nom,
    required String prenom,
    required String email,
    required String motDePasse,
    File? image,
  }) async {
    try {
      var requete = http.MultipartRequest(
          'POST', Uri.parse('http://10.0.2.2:8080/utilisateur/create'));

      // Ajouter le fichier image à la requête s'il est fourni
      if (image != null) {
        requete.files.add(http.MultipartFile(
          'images',
          image.readAsBytes().asStream(),
          image.lengthSync(),
          filename: basename(image.path),
        ));
      }

      
      // requete.headers['Content-Type'] = 'application/json';

      // Encoder les données de l'utilisateur en JSON et les ajouter aux champs de la requête
      requete.fields['utilisateur'] = jsonEncode({
        'nom': nom,
        'prenom': prenom,
        'email': email,
        'motDePasse': motDePasse,
        'image': "",
      });

      var response = await requete.send();
      var responsed = await http.Response.fromStream(response);
      if (response.statusCode == 200 || response.statusCode == 201) {
        final donneesReponse =
            json.decode(responsed.body);
            // debugPrint(responsed.body);

        return Utilisateur.fromMap(donneesReponse);
      } else {
       
        throw Exception(
            'Échec de la requête avec le code d\'état : ${responsed.statusCode}');
      }
    } catch (e) {
     
      throw Exception(
          'Une erreur s\'est produite lors de l\'ajout de l\'utilisateur : $e');
    }
  }

  // Méthode pour la connexion
  static Future<Utilisateur> connexion({
    required String email,
    required String motDePasse,
  }) async {
    try {
      var request = http.MultipartRequest(
        'POST',
        Uri.parse('http://10.0.2.2:8080/utilisateur/connexion'),
        
      );

      request.headers['Content-Type'] = 'application/json';

      request.fields['utilisateur'] = jsonEncode({
        'email': email,
        'motDePasse': motDePasse,
      });
   print(request.toString());
      var response = await request.send();
      print(response.toString());
      if (response.statusCode == 200 || response.statusCode == 201) {
        final data = json.decode(await response.stream.bytesToString());
        print(data.toString());
        return Utilisateur.fromJson(data);
      } else {
        throw Exception('Échec de la connexion : ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Erreur lors de la connexion : $e');
    }
  }
}
