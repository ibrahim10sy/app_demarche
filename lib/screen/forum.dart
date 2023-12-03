import 'package:demarche_app/model/Forum.dart';
import 'package:demarche_app/model/Utilisateur.dart';
import 'package:demarche_app/provider/utilisateurProvider.dart';
import 'package:demarche_app/screen/home.dart';
import 'package:demarche_app/screen/reponse.dart';
import 'package:demarche_app/service/forumService.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Forums extends StatefulWidget {
  const Forums({super.key});

  @override
  State<Forums> createState() => _ForumsState();
}

final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

const d_red = Color.fromRGBO(28, 36, 129, 10);

class _ForumsState extends State<Forums> {
  final libelleController = TextEditingController();
  final descController = TextEditingController();
  late Utilisateur utilisateur;
  late List<Forum> forumListe = [];
  late Future<List<Forum>> _forum;
  var forumService = ForumService();

  Future<List<Forum>> fetchData() async {
    return forumService.getForumList();
  }

  @override
  void initState() {
    utilisateur =
        Provider.of<UtilisateurProvider>(context, listen: false).utilisateur!;
    _forum = fetchData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const CustomAppBar(),
      body: ListView(
        children: [
          const SizedBox(
            height: 20,
          ),
          Align(
            alignment: Alignment.centerRight,
            child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextButton(
                  child: const Text(
                    " + Créer un forum",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20)),
                            titlePadding:
                                const EdgeInsets.only(top: 0, left: 0),
                            content: SingleChildScrollView(
                              child: Form(
                                  key: _formKey,
                                  child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: <Widget>[
                                        const Text(
                                          'Libelle',
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8),
                                          child: Container(
                                            decoration: BoxDecoration(
                                              border: Border.all(
                                                color: Colors.black12,
                                                style: BorderStyle.solid,
                                                width: 1.0,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(40),
                                            ),
                                            child: TextFormField(
                                              controller: libelleController,
                                              decoration: const InputDecoration(
                                                hintText: "libelle",
                                              ),
                                            ),
                                          ),
                                        ),
                                        const Text(
                                          'Description',
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8),
                                          child: Container(
                                            decoration: BoxDecoration(
                                              border: Border.all(
                                                color: Colors.black12,
                                                style: BorderStyle.solid,
                                                width: 1.0,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(40),
                                            ),
                                            child: TextFormField(
                                              controller: descController,
                                              decoration: const InputDecoration(
                                                hintText: "Description",
                                              ),
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8),
                                          child: ElevatedButton(
                                            onPressed: () async {
                                              String libelle =
                                                  libelleController.text;
                                              String description =
                                                  descController.text;

                                              await Provider.of<ForumService>(
                                                context,
                                                listen: false,
                                              )
                                                  .creerForumByUser(
                                                context: context,
                                                libelle: libelle,
                                                description: description,
                                                utilisateur: utilisateur,
                                              )
                                                  .then((value) {
                                                libelleController.clear();
                                                descController.clear();
                                                Navigator.of(context).pop();
                                              }).catchError((onError) {
                                                print(
                                                    'Une erreur est survenue lors de l\'envoie $onError');
                                              });
                                            },
                                            style: ElevatedButton.styleFrom(
                                              elevation: 3,
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                vertical: 15,
                                                horizontal: 80,
                                              ),
                                              backgroundColor: d_red,
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(30),
                                                side: const BorderSide(
                                                  color: Colors.white70,
                                                ),
                                              ),
                                            ),
                                            child: const Text(
                                              "Créer",
                                              style: TextStyle(
                                                fontSize: 14,
                                                color: Colors.white,
                                                fontWeight: FontWeight.w700,
                                              ),
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8),
                                          child: ElevatedButton(
                                            onPressed: () {
                                              Navigator.of(context)
                                                  .pop(); // Ferme la boîte de dialogue
                                            },
                                            style: ElevatedButton.styleFrom(
                                              elevation: 3,
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                vertical: 15,
                                                horizontal: 80,
                                              ),
                                              backgroundColor:
                                                  const Color.fromARGB(
                                                      255,
                                                      230,
                                                      10,
                                                      10), // Couleur du bouton
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(30),
                                                side: const BorderSide(
                                                  color: Colors.white70,
                                                ),
                                              ),
                                            ),
                                            child: const Text(
                                              "Annuler",
                                              style: TextStyle(
                                                fontSize: 14,
                                                color: Colors.white,
                                                fontWeight: FontWeight.w700,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ])),
                            )));
                  },
                )),
          ),
          Consumer<ForumService>(
            builder: (context, forumService, child) {
              return FutureBuilder(
                future: forumService.getForumList(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }

                  if (!snapshot.hasData) {
                    return const Center(
                      child: Text("Aucune donnée trouvée"),
                    );
                  } else {
                    forumListe = snapshot.data!;
                    return Column(
                      children: forumListe.map((Forum forum) {
                        return GestureDetector(
                            child: buildForumItem(forum),
                            onDoubleTap: () {
                              showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: const Text("Suppression"),
                                      content: const Text(
                                        "Voulez-vous vraiment supprimer",
                                        style: TextStyle(
                                            fontSize: 18, color: Colors.red),
                                      ),
                                      actions: [
                                        TextButton(
                                            onPressed: () async {
                                              await Provider.of<ForumService>(
                                                context,
                                                listen: false,
                                              )
                                                  .deleteForumById(
                                                      forum.idForum,
                                                      forum.utilisateur
                                                          .idUtilisateur!)
                                                  .then((value) => {
                                                        Navigator.of(context)
                                                            .pop()
                                                      })
                                                  .catchError((onError) {
                                                showDialog(
                                                    context: context,
                                                    builder:
                                                        (BuildContext context) {
                                                      return AlertDialog(
                                                        title: const Text(
                                                            "Erreur de suppression"),
                                                        content: const Text(
                                                            "Vous n'êtes pas autorisé à supprimer un forum que vous n'avez pas créer"),
                                                        actions: [
                                                          TextButton(
                                                              onPressed: () {
                                                                Navigator.of(
                                                                        context)
                                                                    .pop();
                                                              },
                                                              child: const Text(
                                                                  'OK'))
                                                        ],
                                                      );
                                                    });
                                              });
                                            },
                                            child: const Text(
                                              'OUI',
                                              style: TextStyle(
                                                  fontSize: 20,
                                                  color: Colors.red),
                                            )),
                                        TextButton(
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                            child: const Text(
                                              'Non',
                                              style: TextStyle(
                                                  fontSize: 20, color: d_red),
                                            ))
                                      ],
                                    );
                                  });
                            });
                      }).toList(),
                    );
                  }
                },
              );
            },
          )
        ],
      ),
    );
  }

  Widget buildForumItem(Forum forum) {
    color:
    Colors.white;
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Reponses(forum: forum)),
        );
      },
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Card(
          color: Colors.white,
          child: ListTile(
            leading: const CircleAvatar(
              radius: 30,
              backgroundImage: AssetImage("assets/images/forum.jpg"),
            ),
            title: Text(
              forum.libelle,
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            subtitle: Text(
              "Créé par : ${forum.utilisateur.prenom} ${forum.utilisateur.nom}",
              style: const TextStyle(
                fontSize: 15,
              ),
            ),
          ),
        ),
      ),
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
                      MaterialPageRoute(builder: (context) => const Home()));
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
