import 'package:demarche_app/model/Actualite.dart';
import 'package:demarche_app/service/actualiteService.dart';
import 'package:flutter/material.dart';


class Actualite extends StatefulWidget {
  const Actualite({super.key});

  @override
  State<Actualite> createState() => _ActualiteState();
}

class _ActualiteState extends State<Actualite> {
  late List<Actualites> actualite = [];
  late Future<List<Actualites>> _actualite;
  var actualiteService = ActualiteService();

  @override
  void initState() {
    _actualite = getActualite();
    super.initState();
  }

   Future<List<Actualites>> getActualite() async {
    return actualiteService.fetchActualite();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 192, 191, 191),
      appBar: AppBar(
        title: Container(child: const Text("Actualite")),
      ),
    );
  }
}
