import 'dart:convert';

import 'package:demarche_app/model/Actualite.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ActualiteService {
  static var client = http.Client();

  static Future<dynamic> getActualite() async {
    try {
      var response = await client.get(
        Uri.parse('http://10.0.2.2//Actualite/read'),
      );
      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      }
    } catch (e) {
      return null;
    }
  }
}
