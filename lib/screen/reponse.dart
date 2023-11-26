import 'package:demarche_app/model/Forum.dart';
import 'package:flutter/material.dart';

class Reponses extends StatefulWidget {
  final Forum forum;
  const Reponses({super.key, required this.forum});

  @override
  State<Reponses> createState() => _ReponsesState();
}

class _ReponsesState extends State<Reponses> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Reponse"),
      ),
    );
  }
}
