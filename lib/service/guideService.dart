import 'dart:convert';

import 'package:demarche_app/model/Guide.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class GuideService {
  final String baseUrl = "http://10.0.2.2:8080/Guide";

  List<Guide> guides = [];

  Future<List<Guide>> fetchGuide() async {
    final response = await http.get(Uri.parse('$baseUrl/read'));

    if (response.statusCode == 200) {
      List<dynamic> body = jsonDecode(utf8.decode(response.bodyBytes));
      guides = body.map((dynamic item) => Guide.fromJson(item)).toList();
      print('Resultat attendue : ${response.statusCode}');
      debugPrint(response.body);
      return guides;
    } else {
      guides = [];
      print('Échec de la requête avec le code d\'état: ${response.statusCode}');
      throw Exception(jsonDecode(utf8.decode(response.bodyBytes))["message"]);
    }
  }
}
