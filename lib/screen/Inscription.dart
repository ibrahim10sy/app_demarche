import 'dart:io';

import 'package:demarche_app/delayed_animation.dart';
import 'package:demarche_app/model/Utilisateur.dart';
import 'package:demarche_app/provider/utilisateurProvider.dart';
import 'package:demarche_app/screen/Home.dart';
import 'package:demarche_app/screen/connexion_screen.dart';
import 'package:demarche_app/service/utilisateurService.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';

class Inscription extends StatefulWidget {
  const Inscription({super.key});

  @override
  State<Inscription> createState() => _InscriptionState();
}

const d_red = Color.fromRGBO(28, 36, 129, 10);

class _InscriptionState extends State<Inscription> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController nom_controller = TextEditingController();
  TextEditingController prenom_controller = TextEditingController();
  TextEditingController email_controller = TextEditingController();
  TextEditingController motDepasse_controller = TextEditingController();
  TextEditingController ConfirmerMotDePasse_controller =
      TextEditingController();
  String? imageSrc;
  File? photo;
  String _errorMessage = '';

  Future<void> _pickImage() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image != null) {
        final imagePermanent = await saveImagePermanently(image.path);

        setState(() {
          photo = imagePermanent;
          imageSrc = imagePermanent.path;
        });
      } else {
        throw Exception('Image non télécharger');
      }
    } on PlatformException catch (e) {
      debugPrint('erreur lors de téléchargement de l\'image : $e');
    }
  }

  Future<File> saveImagePermanently(String imagePath) async {
    final directory = await getApplicationDocumentsDirectory();
    final name = basename(imagePath);
    final image = File('${directory.path}/$name');
    return File(imagePath).copy(image.path);
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
              // const Expanded(
              //   child: Text(
              //     'Retour',
              //   ),
              // )
            ],
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                // margin:
                //     const EdgeInsets.symmetric(vertical: 35, horizontal: 118),
                child: DelayedAnimation(
                  delay: 1500,
                  child: SizedBox(
                    height: 140,
                    child: Center(
                      child: (photo != null)
                          ? Image.file(photo!)
                          : Image.asset('assets/images/logo.png'),
                    ),
                  ),
                ),
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 55, vertical: 5),
                decoration: const BoxDecoration(
                    // color: Color(0xfff5f8fd),
                    borderRadius: BorderRadius.all(Radius.circular(20))),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    elevation: 5,
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 45),
                    backgroundColor: const Color(0xff2ffffff), // Button color
                    // shape: RoundedRectangleBorder(
                    //   borderRadius: BorderRadius.circular(5),
                    //   side: const BorderSide(color: Color(0xFF2F9062)),
                    // ),
                  ),
                  onPressed: () {
                    _pickImage();
                  },
                  child: const Text(
                    'Sélectionner une photo de profil',
                    style: TextStyle(
                      color: d_red,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 40),
                child: Text(
                  'Inscription',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontSize: 25,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 40, vertical: 0),
                      child: Text(
                        'Nom',
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          fontSize: 18,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 40, vertical: 16),
                        child: TextField(
                          controller: nom_controller,
                          style: const TextStyle(fontSize: 18.0),
                          decoration: const InputDecoration(
                            contentPadding: EdgeInsets.all(18.0),
                            labelText: 'Nom ',
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
                    const Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 40, vertical: 0),
                      child: Text(
                        'Prénom',
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          fontSize: 18,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 40, vertical: 16),
                        child: TextField(
                          controller: prenom_controller,
                          style: const TextStyle(fontSize: 18.0),
                          decoration: const InputDecoration(
                            contentPadding: EdgeInsets.all(18.0),
                            labelText: 'Prénom ',
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
                    const Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 40, vertical: 0),
                      child: Text(
                        'Email',
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          fontSize: 18,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 40, vertical: 16),
                        child: TextField(
                          keyboardType: TextInputType.emailAddress,
                          controller: email_controller,
                          style: const TextStyle(fontSize: 18.0),
                          onChanged: (val) {
                            validateEmail(val);
                          },
                          decoration: const InputDecoration(
                            contentPadding: EdgeInsets.all(18.0),
                            labelText: 'Email ',
                            prefixIcon: Icon(
                              Icons.email,
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
                    const Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 40, vertical: 0),
                      child: Text(
                        'Mot de passe ',
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          fontSize: 18,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 40, vertical: 16),
                        child: TextField(
                          obscureText: true,
                          controller: motDepasse_controller,
                          style: const TextStyle(fontSize: 18.0),
                          decoration: const InputDecoration(
                            contentPadding: EdgeInsets.all(18.0),
                            labelText: 'Mot de passe ',
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
                    const Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 40, vertical: 0),
                      child: Text(
                        'Confirmer mot de passe',
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          fontSize: 18,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 40, vertical: 16),
                        child: TextField(
                          obscureText: true,
                          controller: ConfirmerMotDePasse_controller,
                          style: const TextStyle(fontSize: 18.0),
                          decoration: const InputDecoration(
                            contentPadding: EdgeInsets.all(18.0),
                            labelText: 'Mot de passe  ',
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
                    SizedBox(
                      width: double.infinity,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 40, vertical: 15),
                        child: ElevatedButton(
                          onPressed: () async {
                            String nom = nom_controller.text;
                            String prenom = prenom_controller.text;
                            String email = email_controller.text;
                            String motDePasse = motDepasse_controller.text;
                            String Confirmer =
                                ConfirmerMotDePasse_controller.text;

                            UtilisateurProvider utilisateurprovider =
                                Provider.of<UtilisateurProvider>(context,
                                    listen: false);

                            if (nom.isEmpty ||
                                prenom.isEmpty ||
                                email.isEmpty ||
                                motDePasse.isEmpty) {
                              return showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: const Text('Formulaire'),
                                    content: const Text(
                                        "Veuillez remplir tous les champs"),
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
                            } else if (Confirmer != motDePasse) {
                              return showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: const Text('Erreur de mot de passe'),
                                    content: const Text(
                                        'les mots de passe ne doivent pas etre differents'),
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
                            } else {
                              Utilisateur nouveauUtilisateur;
                              try {
                                if (photo != null) {
                                  nouveauUtilisateur =
                                      await UtilisateurService.creerCompte(
                                          nom: nom,
                                          prenom: prenom,
                                          email: email,
                                          motDePasse: motDePasse,
                                          image: photo as File);
                                } else {
                                  nouveauUtilisateur =
                                      await UtilisateurService.creerCompte(
                                    nom: nom,
                                    prenom: prenom,
                                    email: email,
                                    motDePasse: motDePasse,
                                  );
                                  print(nouveauUtilisateur.toString());
                                }

                                utilisateurprovider
                                    .setUtilisateur(nouveauUtilisateur);
                                showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: const Text('Succèss'),
                                        content: const Text(
                                            'Compte créer avec succèss'),
                                        actions: <Widget>[
                                          TextButton(
                                            onPressed: () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          const Home()));
                                            },
                                            child: const Text('OK'),
                                          ),
                                        ],
                                      );
                                    });
                              } catch (e) {
                                throw Exception(
                                    'Impossible de créer un compte $e');
                              }
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                const Color.fromRGBO(28, 36, 129, 1.0),
                            // shape: const StadiumBorder(),
                            padding: const EdgeInsets.all(17),
                          ),
                          child: const Text(
                            'Inscription',
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        textAlign: TextAlign.center,
                        _errorMessage,
                        style: const TextStyle(color: Colors.red),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 45, vertical: 15),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const Connexion_Screen()));
                          print('Appui simple détecté!');
                        },
                        child: Container(
                          alignment: Alignment.centerRight,
                          child: Container(
                            padding: const EdgeInsets.all(1.0),
                            child: const Text(
                              'Vous avez déà un compte ? Conncectez-vous',
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

  void validateEmail(String val) {
    if (val.isEmpty) {
      setState(() {
        _errorMessage = "Email ne doit pas être vide";
      });
    } else if (!EmailValidator.validate(val, true)) {
      setState(() {
        _errorMessage = "Email non valide";
      });
    } else {
      setState(() {
        _errorMessage = "";
      });
    }
  }
}
