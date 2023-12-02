import 'dart:convert';

import 'package:demarche_app/model/Forum.dart';
import 'package:demarche_app/model/Reponse.dart';
import 'package:demarche_app/model/Utilisateur.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class ReponseService extends ChangeNotifier {
  final baseUrl = 'http://10.0.2.2:8080/Reponse';

  List<Reponse> reponseByUser = [];
  List<Reponse> reponseAll = [];

  Future<String> creerReponseUser({
    required BuildContext context,
    required String reponse,
    required Forum forum,
    required Utilisateur utilisateur,
  }) async {
    var rep = jsonEncode({
      'reponse': reponse,
      'forum': forum.toMap(),
      'utilisateur': utilisateur.toMap()
    });

    final response = await http.post(
        Uri.parse('http://10.0.2.2:8080/Reponse/createForUtilisateur'),
        headers: {'Content-Type': 'application/json'},
        body: rep);

    if (response.statusCode == 200) {
      print(response.body);
      applyChange();
    } else {
      debugPrint(response.body);
      throw Exception('Impossible de créer une reponse ${response.statusCode}');
    }
    throw Exception('Impossible de créer une reponse');
  }

  Future<List<Reponse>> fetchReponseByIdUser(
      int idUtilisateur, int idForum) async {
    final response = await http
        .get(Uri.parse('$baseUrl/readForUtilisateur/$idUtilisateur/$idForum'));

    if (response.statusCode == 200) {
      List<dynamic> body = jsonDecode(utf8.decode(response.bodyBytes));
      reponseByUser = body.map((item) => Reponse.fromMap(item)).toList();
      print('Resultat attendu du post reponse : ${response.statusCode}');
      reponseByUser.printInfo();
      return reponseByUser;
    } else {
      reponseByUser = [];
      print('Échec de la requête avec le code d\'état: ${response.statusCode}');
      throw Exception(jsonDecode(utf8.decode(response.bodyBytes))["message"]);
    }
  }

  Future<List<Reponse>> fetchReponseAll(int idUtilisateur, int idForum) async {
    final response = await http.get(
        Uri.parse('$baseUrl/readForOtherUtilisateurs/$idUtilisateur/$idForum'));

    if (response.statusCode == 200) {
      List<dynamic> body = jsonDecode(utf8.decode(response.bodyBytes));
      reponseByUser = body.map((item) => Reponse.fromMap(item)).toList();
      print('Resultat attendu du get reponse : ${response.statusCode}');
      reponseByUser.printInfo();
      return reponseByUser;
    } else {
      reponseByUser = [];
      print('Échec de la requête avec le code d\'état: ${response.statusCode}');
      throw Exception(jsonDecode(utf8.decode(response.bodyBytes))["message"]);
    }
  }

  Future<void> deleteForReponse(int idReponse, int idUtilisateur) async {
    final response = await http.delete(Uri.parse(
        'http://10.0.2.2:8080/Reponse/deleteForUtilisateur/$idReponse/utilisateur/$idUtilisateur'));
    debugPrint("${response.statusCode}");

    if (response.statusCode == 200) {
      applyChange();
    } else {
      throw Exception(jsonDecode(utf8.decode(response.bodyBytes))["message"]);
    }
  }

  applyChange() {
    notifyListeners();
  }
}
