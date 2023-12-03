import 'dart:convert';

import 'package:demarche_app/model/Bureau.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class BureauService {
  final String baseUrl = "http://10.0.2.2:8080/Bureau/read";

  List<Bureau> bureau = [];

  Future<List<Bureau>> fetchbureau() async {
    final response = await http.get(Uri.parse(baseUrl));

    if (response.statusCode == 200) {
      List<dynamic> body = jsonDecode(utf8.decode(response.bodyBytes));
      bureau = body.map((item) => Bureau.fromMap(item)).toList();
      print('Resultat attendue : ${response.statusCode}');
      debugPrint('Bureauservice ${response.body}');
      return bureau;
    } else {
      bureau = [];
      print('Échec de la requête avec le code d\'état: ${response.statusCode}');
      throw Exception(jsonDecode(utf8.decode(response.bodyBytes))["message"]);
    }
  }
}
