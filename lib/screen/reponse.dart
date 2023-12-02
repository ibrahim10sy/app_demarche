import 'package:demarche_app/model/Forum.dart';
import 'package:demarche_app/model/Reponse.dart';
import 'package:demarche_app/model/Utilisateur.dart';
import 'package:demarche_app/provider/utilisateurProvider.dart';
import 'package:demarche_app/screen/forum.dart';
import 'package:demarche_app/screen/nav.dart';
import 'package:demarche_app/service/reponseService.dart';
import 'package:flutter/material.dart';
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

  late Future<List<Reponse>> _reponsesUser;
  late Future<List<Reponse>> _reponseList;
  var reponseService = ReponseService();

  Future<List<Reponse>> fetchForUser(int idUtilisateur, int idForum) {
    return reponseService.fetchReponseByIdUser(idUtilisateur, idForum);
  }

  Future<List<Reponse>> fetchAll(int idUtilisateur, int idForum) {
    return reponseService.fetchReponseAll(idUtilisateur, idForum);
  }

  @override
  void initState() {
    utilisateur =
        Provider.of<UtilisateurProvider>(context, listen: false).utilisateur!;
    forums = widget.forum;
    _reponsesUser = fetchForUser(utilisateur.idUtilisateur!, forums.idForum);
    _reponseList = fetchAll(utilisateur.idUtilisateur!, forums.idForum);
    super.initState();
  }

  Widget buildReponsesList(
      Future<List<Reponse>> Function() fetchFunction, bool isCurrentUser) {
    return Consumer<ReponseService>(builder: (context, responseService, child) {
      return FutureBuilder(
        future: fetchFunction(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (!snapshot.hasData) {
            return const Center(
              child: Text("Aucune réponse trouvée"),
            );
          } else {
            List<Reponse> reponseList = snapshot.data!;
            return Column(
              children: reponseList.map((Reponse reponse) {
                return buildReponseItem(reponse, isCurrentUser);
              }).toList(),
            );
          }
        },
      );
    });
  }

  Widget buildReponseItem(Reponse reponse, bool isCurrentUser) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: GestureDetector(
        onDoubleTap: () {
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: const Text("Suppression"),
                  content: const Text(
                    "Voulez-vous vraiment supprimer",
                    style: TextStyle(fontSize: 18, color: Colors.red),
                  ),
                  actions: [
                    TextButton(
                        onPressed: () async {
                          await Provider.of<ReponseService>(
                            context,
                            listen: false,
                          )
                              .deleteForReponse(reponse.idReponse,
                                  reponse.utilisateur.idUtilisateur!)
                              .then((value) => {Navigator.of(context).pop()})
                              .catchError((onError) {
                            showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: const Text("onError"),
                                    actions: [
                                      TextButton(
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                          child: const Text('OK'))
                                    ],
                                  );
                                });
                          });
                        },
                        child: const Text(
                          'OUI',
                          style: TextStyle(fontSize: 20, color: Colors.red),
                        )),
                    TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: const Text(
                          'Non',
                          style: TextStyle(fontSize: 20, color: d_red),
                        ))
                  ],
                );
              });
        },
        child: Row(
          mainAxisAlignment:
              isCurrentUser ? MainAxisAlignment.end : MainAxisAlignment.start,
          children: [
            isCurrentUser
                ? Expanded(
                    child: Container(
                      width: 100,
                      padding: const EdgeInsets.all(8),
                      decoration: const BoxDecoration(
                        color: Colors.greenAccent,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10),
                          bottomLeft: Radius.circular(10),
                          bottomRight: Radius.circular(30),
                          topRight: Radius.circular(30),
                        ),
                      ),
                      child: Text(
                        reponse.reponse,
                        style: const TextStyle(
                            fontSize: 20,
                            color: Colors.black,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  )
                : Expanded(
                    child: Container(
                      width: 100,
                      padding: const EdgeInsets.all(8),
                      decoration: const BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10),
                          bottomLeft: Radius.circular(10),
                          bottomRight: Radius.circular(30),
                          topRight: Radius.circular(30),
                        ),
                      ),
                      child: Text(
                        reponse.reponse,
                        style: const TextStyle(
                            fontSize: 20,
                            color: Colors.black,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
            const SizedBox(width: 8),
            CircleAvatar(
              radius: 28,
              backgroundColor: dRed,
              child: Text(
                "${reponse.utilisateur.prenom.substring(0, 1).toUpperCase()}${reponse.utilisateur.nom.substring(0, 1).toUpperCase()}",
                style: const TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  letterSpacing: 2,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(),
      body: Stack(children: [
        // Widget pour afficher le contenu principal du chat
        ListView(
          padding: const EdgeInsets.all(8.0),
          children: <Widget>[
            buildReponsesList(
                () => reponseService.fetchReponseAll(
                      utilisateur.idUtilisateur!,
                      forums.idForum,
                    ),
                false),
            buildReponsesList(
                () => reponseService.fetchReponseByIdUser(
                      utilisateur.idUtilisateur!,
                      forums.idForum,
                    ),
                true)
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
                          context: context,
                          reponse: message,
                          forum: forums,
                          utilisateur: utilisateur)
                      .then((value) {
                    print('Message envoyé: $message');

                    reponseController.clear();
                  }).catchError((onError) {
                    print('Une erreur est survenue lors de l\'envoie $onError');
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
