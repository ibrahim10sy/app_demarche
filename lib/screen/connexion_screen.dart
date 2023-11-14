import 'package:flutter/material.dart';

class Connexion_screen extends StatefulWidget {
  const Connexion_screen({super.key});

  @override
  State<Connexion_screen> createState() => _Connexion_screenState();
}

class _Connexion_screenState extends State<Connexion_screen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white.withOpacity(0),
        leading: Row(
          children: [
            IconButton(
              icon: const Icon(
                Icons.arrow_back,
                color: Colors.black,
                size: 30,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            const Expanded(
              child: Text(
                'Retour',
              ),
            )
          ],
        ),
      ),
    );
  }
}
