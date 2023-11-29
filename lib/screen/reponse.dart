import 'package:demarche_app/model/Forum.dart';
import 'package:demarche_app/model/Utilisateur.dart';
import 'package:demarche_app/provider/utilisateurProvider.dart';
import 'package:demarche_app/screen/forum.dart';
import 'package:demarche_app/screen/nav.dart';
import 'package:demarche_app/service/reponseService.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class Reponses extends StatefulWidget {
  final Forum forum;
  const Reponses({super.key, required this.forum});

  @override
  State<Reponses> createState() => _ReponsesState();
}

const d_red = Color.fromRGBO(28, 36, 129, 10);

class _ReponsesState extends State<Reponses> {
  final reponseController = TextEditingController();
  late Utilisateur utilisateur;
  late Forum forums;

  @override
  void initState() {
    utilisateur =
        Provider.of<UtilisateurProvider>(context, listen: false).utilisateur!;
    utilisateur.printInfo();
    forums = widget.forum;
    forums.printInfo();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(),
      body: Stack(children: [
        Center(
          child: Text(
            'Forum crée ${forums.utilisateur.nom} ${forums.utilisateur.prenom}',
            style: const TextStyle(fontSize: 18),
          ),
        ),

        // Widget pour afficher le contenu principal du chat
        ListView(
          padding: const EdgeInsets.all(8.0),
          children: const <Widget>[
            // ... Autres messages du chat
          ],
        ),

        // Widget pour afficher le champ de texte en bas
        Align(
          alignment: Alignment.bottomCenter,
          child: Row(
            children: [
              // Champ de texte
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: reponseController,
                    decoration: const InputDecoration(
                      hintText: 'Entrez votre message...',
                    ),
                  ),
                ),
              ),

              IconButton(
                icon: const Icon(
                  Icons.send,
                  size: 30,
                  color: dRed,
                ),
                onPressed: () async {
                  String message = reponseController.text;
                  await Provider.of<ReponseService>(context, listen: false)
                      .creerReponseUser(
                          context: context, reponse: message, forum: forums, utilisateur: utilisateur)
                      .then((value) {
                    print('Message envoyé: $message');
                    // Efface le champ de texte après l'envoi
                    reponseController.clear();
                  }).catchError((onError) {
                    print('Une erreur est survenue $onError');
                  });
                },
              ),
            ],
          ),
        ),
      ]),
    );
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
        boxShadow: [
          BoxShadow(
            offset: Offset(0.0, 0.0),
            blurRadius: 5.0,
            color: Color.fromRGBO(0, 0, 0, 0.25),
          )
        ],
      ),
      child: Row(
        children: [
          Row(
            children: [
              IconButton(
                onPressed: () {
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => const Forums()));
                },
                icon: const Icon(Icons.arrow_back_ios),
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
            width: 80,
          ),
          const Text(
            'Forum',
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
