import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
      var request = http.MultipartRequest('POST', Uri.parse('http://10.0.2.2:8080/utilisateur/create'));

      if (image != null) {
        request.files.add(http.MultipartFile(
          'image',
          image.readAsBytes().asStream(),
          image.lengthSync(),
          filename: basename(image.path),
        ));
      }

      request.fields['utilisateur'] = jsonEncode({
        'nom': nom,
        'prenom': prenom,
        'email': email,
        'motDePasse': motDePasse,
        'image': ""
      });

      var response = await request.send();

      if (response.statusCode == 200) {
        final responseData = json.decode(await response.stream.bytesToString());
        debugPrint(responseData.toString());
        responseData.printInfo();
        return Utilisateur.fromJson(responseData);
      } else {
        print('Impossible de créer un compte ${response.statusCode}');
        throw Exception(
            'Échec de la requête avec le code d\'état: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception(
          'Une erreur s\'est produite lors de l\'ajout de l\'utilisateur : $e');
    }
  }


}
