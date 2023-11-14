import 'package:demarche_app/delayed_animation.dart';
import 'package:flutter/material.dart';

class Localisation extends StatefulWidget {
  const Localisation({super.key});

  @override
  State<Localisation> createState() => _LocalisationState();
}

class _LocalisationState extends State<Localisation> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 245, 242, 242),
        title: Text("Localisation"),
      ),
    );
  }
}
