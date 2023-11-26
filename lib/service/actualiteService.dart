import 'dart:convert';
import 'package:demarche_app/model/Actualite.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class ActualiteService {

  final String baseUrl = "http://10.0.2.2:8080/Actualite/read";

  List<Actualite> actualite = [];

  Future<List<Actualite>> fetchActualite() async {
    final response = await http.get(Uri.parse(baseUrl));

    if (response.statusCode == 200) {
      List<dynamic> body = jsonDecode(utf8.decode(response.bodyBytes));
      actualite = body.map((item) => Actualite.fromMap(item)).toList();
      print('Resultat attendue : ${response.statusCode}');
      actualite.printInfo();
      return actualite;
    } else {
      actualite = [];
      print("Echec de la requête : ${response.statusCode}");
      throw Exception(jsonDecode(utf8.decode(response.bodyBytes)));
    }
  }
}
