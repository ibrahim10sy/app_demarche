import 'dart:io';

import 'package:demarche_app/model/Utilisateur.dart';
import 'package:demarche_app/service/utilisateurService.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:path/path.dart' as pp;
import '../provider/utilisateurProvider.dart';
import 'package:path_provider/path_provider.dart';

class UpdateProfil extends StatefulWidget {
  const UpdateProfil({super.key});

  @override
  State<UpdateProfil> createState() => _UpdateProfilState();
}

class _UpdateProfilState extends State<UpdateProfil> {
   TextEditingController nom_controller = TextEditingController();
  TextEditingController prenom_controller = TextEditingController();
  TextEditingController email_controller = TextEditingController();
  TextEditingController motDepasse_controller = TextEditingController();
  TextEditingController RepmotDePasse_controller = TextEditingController();
  String? imageSrc;
  File? photo ;
late Utilisateur utilisateur;


  @override
  void initState() {
    super.initState();
     utilisateur = Provider.of<UtilisateurProvider>(context, listen: false).utilisateur!;
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
          this.photo = imagePermanent;

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
      print(
          'Profil utilisateur mis à jour avec succès : ${utilisateurMaj.nom}');
      // Vous pouvez également gérer la navigation vers une autre page après la mise à jour.
    } catch (e) {
      // Une erreur s'est produite lors de la mise à jour du profil utilisateur, vous pouvez gérer l'erreur ici.
      final String errorMessage = e.toString();
      debugPrint(errorMessage);
    }
  }
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}