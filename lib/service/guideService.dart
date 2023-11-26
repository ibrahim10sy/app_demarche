import 'dart:convert';

import 'package:demarche_app/model/Document.dart';
import 'package:demarche_app/model/Guide.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class GuideService {
  final String baseUrl = "http://10.0.2.2:8080/Guide";
  final String baseUrl1 = "http://10.0.2.2:8080/Document/liste/";

  List<Guide> guides = [];
  List<Document> documents = [];

  Future<List<Guide>> fetchGuide() async {
    final response = await http.get(Uri.parse('$baseUrl/read'));

    if (response.statusCode == 200) {
      List<dynamic> body = jsonDecode(utf8.decode(response.bodyBytes));
      guides = body.map((item) => Guide.fromMap(item)).toList();
      print('Resultat attendue : ${response.statusCode}');
      debugPrint('docservice ${response.body}');
      return guides;
    } else {
      guides = [];
      print('Échec de la requête avec le code d\'état: ${response.statusCode}');
      throw Exception(jsonDecode(utf8.decode(response.bodyBytes))["message"]);
    }
  }

  Future<List<Document>> getDocumentByIdGuide(int idGuide) async {
    final response = await http.get(Uri.parse('$baseUrl1$idGuide'));

    if (response.statusCode == 200) {
      List<dynamic> body = jsonDecode(utf8.decode(response.bodyBytes));
      documents = body.map((item) => Document.fromMap(item)).toList();
      print('Resultat attendu du get doc : ${response.statusCode}');
      documents.printInfo();
      return documents;
    } else {
      documents = [];
      print('Échec de la requête avec le code d\'état: ${response.statusCode}');
      throw Exception(jsonDecode(utf8.decode(response.bodyBytes))["message"]);
    }
  }
}
