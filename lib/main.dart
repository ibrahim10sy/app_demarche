import 'package:demarche_app/provider/utilisateurProvider.dart';
import 'package:demarche_app/provider/forumProvider.dart';
import 'package:demarche_app/screen/home_splash.dart';
import 'package:demarche_app/service/forumService.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

const d_red = Color(0x001c2481);

void main() {
  runApp(MultiProvider(providers: [
     ChangeNotifierProvider(create: (context) => UtilisateurProvider()),
    ChangeNotifierProvider(create: (context) => ForumProvider()),
    ChangeNotifierProvider(create: (context) => ForumService()),
  ], child: const MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Demarche facile',
        home: Home_splash());
  } 
}
