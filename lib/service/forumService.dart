import 'dart:convert';

import 'package:demarche_app/model/Forum.dart';
import 'package:demarche_app/model/Utilisateur.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ForumService extends ChangeNotifier {
  final baseUrlUser = 'http://10.0.2.2:8080/Forum/createForUser';
  final baseUrlUserList = 'http://10.0.2.2:8080/Forum/read';
  // final baseUrlUserList = 'http://10.0.2.2:8080/Forum/readForUser/';
  List<Forum> forumList = [];

  Future<String> creerForumByUser(
      {required BuildContext context,
      required String libelle,
      required String description,
      required Utilisateur utilisateur}) async {
    var forum = jsonEncode({
      'libelle': libelle,
      'description': description,
      'utilisateur': utilisateur.toMap(),
    });

    final response = await http.post(Uri.parse(baseUrlUser),
        headers: {'Content-Type': 'application/json'}, body: forum);

    if (response.statusCode == 200) {
      print("Forum service : ${response.body}");
      applyChange();
    } else {
      debugPrint(response.reasonPhrase);
      debugPrint(response.body);
      throw Exception('Impossible de créer un forum ${response.statusCode}');
    }
    throw Exception('Impossible de créer un forum');
  }

  Future<List<Forum>> getForumList() async {
    final response = await http.get(Uri.parse('$baseUrlUserList'));

    if (response.statusCode == 200) {
      List<dynamic> body = jsonDecode(utf8.decode(response.bodyBytes));
      forumList = body.map((e) => Forum.fromMap(e)).toList();
      print('Resultat attendue : ${response.statusCode}');
      debugPrint('Forum service ${response.body}');
      return forumList;
    }else{
       print('Échec de la requête avec le code d\'état: ${response.statusCode}');
      throw Exception(jsonDecode(utf8.decode(response.bodyBytes))["message"]);
    }
  }
  // Future<List<Forum>> getForumList(int id) async {
  //   final response = await http.get(Uri.parse('$baseUrlUserList$id'));

  //   if (response.statusCode == 200) {
  //     List<dynamic> body = jsonDecode(utf8.decode(response.bodyBytes));
  //     forumList = body.map((e) => Forum.fromMap(e)).toList();
  //     print('Resultat attendue : ${response.statusCode}');
  //     debugPrint('Forum service ${response.body}');
  //     return forumList;
  //   }else{
  //      print('Échec de la requête avec le code d\'état: ${response.statusCode}');
  //     throw Exception(jsonDecode(utf8.decode(response.bodyBytes))["message"]);
  //   }
  // }

  void applyChange() {
    notifyListeners();
  }
}
