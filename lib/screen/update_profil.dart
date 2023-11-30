import 'dart:io';

import 'package:demarche_app/model/Utilisateur.dart';
import 'package:demarche_app/screen/profil.dart';
import 'package:demarche_app/service/utilisateurService.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as pp;
import 'package:provider/provider.dart';
import 'package:path_provider/path_provider.dart';
import '../provider/utilisateurProvider.dart';

class UpdateProfil extends StatefulWidget {
  const UpdateProfil({super.key});

  @override
  State<UpdateProfil> createState() => _UpdateProfilState();
}

const d_red = Color.fromRGBO(28, 36, 129, 10);

class _UpdateProfilState extends State<UpdateProfil> {
  final _formKey = GlobalKey<FormState>();
  String _errorMessage = '';
  TextEditingController nom_controller = TextEditingController();
  TextEditingController prenom_controller = TextEditingController();
  TextEditingController email_controller = TextEditingController();
  TextEditingController motDepasse_controller = TextEditingController();
  TextEditingController RepmotDePasse_controller = TextEditingController();
  String? imageSrc;
  File? photo;
  late Utilisateur utilisateur;

  @override
  void initState() {
    super.initState();
    utilisateur =
        Provider.of<UtilisateurProvider>(context, listen: false).utilisateur!;
    nom_controller.text = utilisateur.nom;
    prenom_controller.text = utilisateur.prenom;
    email_controller.text = utilisateur.email;
    RepmotDePasse_controller.text = utilisateur.motDePasse;
    motDepasse_controller.text = utilisateur.motDePasse;
  }

  Future<File> saveImagePermanently(String imagePath) async {
    final directory = await getApplicationDocumentsDirectory();
    final name = pp.basename(imagePath);
    final image = File('${directory.path}/$name');
    return File(imagePath).copy(image.path);
  }

  Future<void> _pickImage() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image != null) {
        final imagePermanent = await saveImagePermanently(image.path);

        setState(() {
          photo = imagePermanent;

          imageSrc = imagePermanent.path; // Notez l'utilisation de "?"
        });
      } else {
        // L'utilisateur a annulé la sélection d'image.
        return;
      }
    } on PlatformException catch (e) {
      debugPrint('erreur : $e');
    }
  }

  Future<void> _updateUtilisateur() async {
    final utilisateurId = utilisateur.idUtilisateur;
    final nom = nom_controller.text;
    final prenom = prenom_controller.text;
    final email = email_controller.text;
    final motDePasse = motDepasse_controller.text;

    if (nom.isEmpty || prenom.isEmpty || email.isEmpty || motDePasse.isEmpty) {
      // Gérez le cas où l'email ou le mot de passe est vide.
      const String errorMessage = "Veuillez remplir tous les champs";
      debugPrint(errorMessage);
      return;
    }

    Utilisateur utilisateurMaj;

    try {
      if (photo != null) {
        utilisateurMaj =
            await Provider.of<UtilisateurService>(context, listen: false)
                .updateUser(
          idUtilisateur: utilisateur.idUtilisateur!,
          nom: nom,
          prenom: prenom,
          email: email,
          motDePasse: motDePasse,
          image: photo as File,
        );
        Provider.of<UtilisateurProvider>(context, listen: false)
            .setUtilisateur(utilisateurMaj);
      } else {
        utilisateurMaj =
            await Provider.of<UtilisateurService>(context, listen: false)
                .updateUser(
          idUtilisateur: utilisateur.idUtilisateur!,
          nom: nom,
          prenom: prenom,
          email: email,
          motDePasse: motDePasse,
        );
        Provider.of<UtilisateurProvider>(context, listen: false)
            .setUtilisateur(utilisateurMaj);
      }

      // Le profil utilisateur a été mis à jour avec succès, vous pouvez gérer la réponse ici.
      print('Profil utilisateur mis à jour avec succès : $utilisateurMaj');
    } catch (e) {
      final String errorMessage = e.toString();
      debugPrint(errorMessage);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(),
      body: ListView(
        children: [
          const SizedBox(
            height: 10,
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 55, vertical: 5),
            decoration: const BoxDecoration(
                // color: Color(0xfff5f8fd),
                borderRadius: BorderRadius.all(Radius.circular(20))),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                elevation: 5,
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 45),
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
          const SizedBox(height: 15),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 40, vertical: 0),
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
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 16),
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
                    borderSide: BorderSide(color: Colors.black, width: 2.0),
                  ),
                ),
              )),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 40, vertical: 0),
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
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 16),
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
                    borderSide: BorderSide(color: Colors.black, width: 2.0),
                  ),
                ),
              )),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 40, vertical: 0),
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
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 16),
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
                    borderSide: BorderSide(color: Colors.black, width: 2.0),
                  ),
                ),
              )),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 40, vertical: 0),
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
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 16),
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
                    borderSide: BorderSide(color: Colors.black, width: 2.0),
                  ),
                ),
              )),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 40, vertical: 0),
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
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 16),
              child: TextField(
                obscureText: true,
                controller: RepmotDePasse_controller,
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
                    borderSide: BorderSide(color: Colors.black, width: 2.0),
                  ),
                ),
              )),
          SizedBox(
            width: double.infinity,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
              child: ElevatedButton(
                onPressed: () async {
                  _updateUtilisateur().then((value) {
                    utilisateur.printInfo();
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Profil()));
                  }).catchError((onError) {
                    print("erreur du debutant : $onError");
                  });
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromRGBO(28, 36, 129, 1.0),
                  // shape: const StadiumBorder(),
                  padding: const EdgeInsets.all(17),
                ),
                child: const Text(
                  'Modifier',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
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
          )
        ],
      ),
    );
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

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({Key? key}) : super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(100.0);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 100,
      padding: const EdgeInsets.fromLTRB(0, 28, 0, 0),
      decoration: const BoxDecoration(
        color: Colors.white,
      ),
      child: Row(
        children: [
          Row(
            children: [
              IconButton(
                onPressed: () {
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => const Profil()));
                },
                icon: const Icon(
                  Icons.arrow_back_ios,
                  color: d_red,
                ),
              ),
              const Text(
                'Retour',
                style: TextStyle(
                  color: d_red,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              )
            ],
          ),
          const SizedBox(
            width: 70,
          ),
          const Text(
            'Modifier rofil',
            style: TextStyle(
              color: d_red,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          )
        ],
      ),
    );
  }
}
