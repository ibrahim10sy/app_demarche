import 'dart:convert';

import 'package:demarche_app/delayed_animation.dart';
import 'package:demarche_app/model/Utilisateur.dart';
import 'package:demarche_app/provider/utilisateurProvider.dart';
import 'package:demarche_app/screen/Inscription.dart';
import 'package:demarche_app/screen/accueil.dart';
import 'package:demarche_app/screen/home.dart';
import 'package:demarche_app/service/utilisateurService.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class Connexion_Screen extends StatefulWidget {
  const Connexion_Screen({super.key});

  @override
  State<Connexion_Screen> createState() => _Connexion_ScreenState();
}

const d_red = Color.fromRGBO(28, 36, 129, 10);

class _Connexion_ScreenState extends State<Connexion_Screen> {
  final _formKey = GlobalKey<FormState>();
  // final email_controller = TextEditingController();
  // final mdp_controller = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController motDePasseController = TextEditingController();

  String name = '';
  String email = '';
  String image = '';
  //methode de connexion
  Future<void> loginUser() async {
    final String email = emailController.text;
    final String motDePasse = motDePasseController.text;
    const String baseUrl = 'http://10.0.2.2:8080/utilisateur';

     UtilisateurProvider utilisateurprovider =
        Provider.of<UtilisateurProvider>(context, listen: false);

    if (email.isEmpty || motDePasse.isEmpty) {
      const String errorMessage = "Veillez remplir tout les champs ";
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Center(child: Text('Erreur')),
            content: const Text(errorMessage),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('OK'),
              ),
            ],
          );
        },
      );
      return;
    }

      const String endpoint = '/login';
    final Uri apiUrl =
        Uri.parse('$baseUrl$endpoint?email=$email&motDePasse=$motDePasse');


     try {
      final response = await http.post(
        apiUrl,
        headers: {
          'Content-Type': 'application/json',
        },
      );


      if (response.statusCode == 200) {
        final responseBody = json.decode(utf8.decode(response.bodyBytes));
        emailController.clear();
        motDePasseController.clear();

        Utilisateur utilisateur = Utilisateur(
          nom: responseBody['nom'],
          prenom: responseBody['prenom'],
          image: responseBody['image'],
          motDePasse: motDePasse,
          email: email,
          idUtilisateur: responseBody['idUtilisateur'],
        );

        utilisateurprovider.setUtilisateur(utilisateur);
       Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> const home()));
      } else {
        final responseBody = json.decode(response.body);
        final errorMessage = responseBody['message'];
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Center(child: Text('Connexion echouer !')),
              content: Text(errorMessage),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('OK'),
                ),
              ],
            );
          },
        );
      }
    } catch (e) {
      print('Erreur de connexion: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromARGB(255, 245, 242, 242),
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
            ],
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin:
                    const EdgeInsets.symmetric(vertical: 35, horizontal: 118),
                child: DelayedAnimation(
                  delay: 1500,
                  child: SizedBox(
                    height: 180,
                    child: Image.asset('assets/images/logo.png'),
                  ),
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 40),
                child: Text(
                  'Connexion',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontSize: 25,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 40, vertical: 16),
                        child: TextField(
                          controller: emailController,
                          style: const TextStyle(fontSize: 18.0),
                          decoration: const InputDecoration(
                            contentPadding: EdgeInsets.all(18.0),
                            hintText: 'Nom d\'utilisateur ou email',
                            prefixIcon: Icon(
                              Icons.person,
                              color: d_red,
                              size: 30.0,
                            ),
                            border: OutlineInputBorder(
                              //  borderRadius: BorderRadius.circular(10.0),
                              borderSide:
                                  BorderSide(color: Colors.black, width: 2.0),
                            ),
                          ),
                        )),
                    Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 40, vertical: 0),
                        child: TextField(
                          controller: motDePasseController,
                          obscureText: true,
                          style: const TextStyle(fontSize: 18.0),
                          decoration: const InputDecoration(
                            contentPadding: EdgeInsets.all(18.0),
                            hintText: 'Mot de passe',
                            prefixIcon: Icon(
                              Icons.lock,
                              color: d_red,
                              size: 30.0,
                            ),
                            border: OutlineInputBorder(
                              //  borderRadius: BorderRadius.circular(10.0),
                              borderSide:
                                  BorderSide(color: Colors.black, width: 2.0),
                            ),
                          ),
                        )),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 45, vertical: 15),
                      child: GestureDetector(
                        onTap: () {
                          // Action à effectuer lorsqu'un appui simple est détecté
                          print('Appui simple détecté!');
                        },
                        child: Container(
                          alignment: Alignment.centerRight,
                          child: Container(
                            padding: const EdgeInsets.all(1.0),
                            child: const Text(
                              'Mot de passe oublié!',
                              style: TextStyle(
                                decoration: TextDecoration.underline,
                                decorationColor: d_red,
                                color: d_red,
                                fontSize: 16.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 40, vertical: 15),
                          child: ElevatedButton(
                            onPressed: loginUser,

                            // onPressed: () async {
                            //   String email = email_controller.text;
                            //   String mdp = mdp_controller.text;

                            //   if (email.isEmpty || mdp.isEmpty) {
                            //     showDialog(
                            //       context: context,
                            //       builder: (BuildContext context) {
                            //         return AlertDialog(
                            //           title: const Text(
                            //               'Erreur dans le formulaire'),
                            //           content: const Text(
                            //               'Veuillez remplir tous les champs'),
                            //           actions: [
                            //             TextButton(
                            //               onPressed: () {
                            //                 Navigator.of(context).pop();
                            //               },
                            //               child: const Text('OK'),
                            //             )
                            //           ],
                            //         );
                            //       },
                            //     );
                            //   } else {
                            //     try {
                            //       Utilisateur utilisateur =
                            //           await UtilisateurService.connexion(
                            //         email: email,
                            //         motDePasse: mdp,
                            //       );
                            //       print(utilisateur.toString());
                            //       Provider.of<utilisateurProvider>(context,
                            //               listen: false)
                            //           .setUtilisateur(utilisateur);
                            //         Navigator.push(
                            //           context,
                            //           MaterialPageRoute(
                            //               builder: ((context) => home())));
                            //     } catch (e) {
                            //       showDialog(
                            //         context: context,
                            //         builder: (BuildContext context) {
                            //           return AlertDialog(
                            //             title:
                            //                 const Text('Erreur de connexion'),
                            //             content: Text(
                            //                 'Erreur lors de la connexion : $e'),
                            //             actions: [
                            //               TextButton(
                            //                 onPressed: () {
                            //                   Navigator.of(context).pop();
                            //                 },
                            //                 child: const Text('OK'),
                            //               )
                            //             ],
                            //           );
                            //         },
                            //       );
                            //     }
                            //   }
                            // },
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  const Color.fromRGBO(28, 36, 129, 1.0),
                              padding: const EdgeInsets.all(17),
                            ),
                            child: const Text(
                              'Connexion',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          )),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Text(
                      'Ou',
                      style:
                          TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 40, vertical: 15),
                          child: ElevatedButton(
                            onPressed: () {
                              print('Bouton pressé!');
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  const Color.fromRGBO(28, 36, 129, 1.0),
                              padding: const EdgeInsets.all(17),
                            ),
                            child: const Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(
                                    width:
                                        8), // Espace entre l'icône et le texte (facultatif)
                                Text(
                                  'Continue avec Google',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          )),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 45, vertical: 15),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const Inscription()));
                          print('Appui simple détecté!');
                        },
                        child: Container(
                          alignment: Alignment.center,
                          child: Container(
                            padding: const EdgeInsets.all(1.0),
                            child: const Text(
                              'Vous n\'avez pas de compte ? Créer un compte',
                              style: TextStyle(
                                decoration: TextDecoration.underline,
                                decorationColor: d_red,
                                color: d_red,
                                fontSize: 15.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}
