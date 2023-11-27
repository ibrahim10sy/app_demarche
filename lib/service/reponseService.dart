import 'dart:convert';
import 'package:demarche_app/model/Forum.dart';
import 'package:demarche_app/model/Reponse.dart';
import 'package:demarche_app/model/Utilisateur.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ReponseService extends ChangeNotifier {
  final baseUrl = 'http://10.0.2.2/Reponse/createForUtilisateur';
  List<Reponse> repos = [];

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

    final response = await http.post(Uri.parse(baseUrl),
        headers: {'Content-Type': 'application/json'}, body: rep);

    if (response.statusCode == 200) {
      print(response.body);
      applyChange();
    }else{
       debugPrint(response.body);
      throw Exception('Impossible de créer un forum ${response.statusCode}');
    }
    throw Exception('Impossible de créer un forum');
  }


  applyChange() {
    notifyListeners();
  }
}
