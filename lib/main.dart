import 'package:demarche_app/screen/home_splash.dart';
import 'package:flutter/material.dart';

const d_red = Color(0x001c2481);

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Demarche facile',
        home: Home_splash());
  }
}
