import 'package:flutter/material.dart';

class Actualite extends StatefulWidget {
  const Actualite({super.key});

  @override
  State<Actualite> createState() => _ActualiteState();
}

class _ActualiteState extends State<Actualite> {
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
