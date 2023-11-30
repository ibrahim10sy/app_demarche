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
      backgroundColor: const Color.fromARGB(255, 247, 245, 245),
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
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: const StadiumBorder(),
                    backgroundColor: const Color.fromRGBO(28, 36, 129, 1.0),
                    padding: const EdgeInsets.all(12),
                  ),
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20)),
                            titlePadding:
                                const EdgeInsets.only(top: 0, left: 0),
                            title: Container(
                              child: const Row(children: [
                                // Container(
                                //   padding : const EdgeInsets.only(top:8, left:10, right:8),
                                //   ch
                                // )
                              ]),
                            ),
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

                                              if (libelle.isEmpty ||
                                                  description.isEmpty) {
                                                const String errorMessage =
                                                    "Champs titre doit être renseigner";
                                                showDialog(
                                                    context: context,
                                                    builder:
                                                        (BuildContext context) {
                                                      return AlertDialog(
                                                        title: const Center(
                                                            child:
                                                                Text('Erreur')),
                                                        content: const Text(
                                                            errorMessage),
                                                        actions: <Widget>[
                                                          TextButton(
                                                            onPressed: () {
                                                              Navigator.of(
                                                                      context)
                                                                  .pop();
                                                            },
                                                            child: const Text(
                                                                'Ok'),
                                                          )
                                                        ],
                                                      );
                                                    });
                                                return;
                                              }
                                              await Provider.of<ForumService>(
                                                      context,
                                                      listen: false)
                                                  .creerForumByUser(
                                                      context: context,
                                                      libelle: libelle,
                                                      description: description,
                                                      utilisateur: utilisateur)
                                                  .then((value) {
                                                libelleController.clear();
                                                descController.clear();
                                                // await ForumService().creerForumByUser(
                                                //         context: context,
                                                //         libelle: libelle,
                                                //         description: description,
                                                //         utilisateur: utilisateur)
                                                //     .then((value) {
                                                libelleController.clear();
                                                descController.clear();
                                                Navigator.of(context).pop();
                                              }).catchError((onError) {
                                                final String errorMessage =
                                                    onError.toString();
                                                // ignore: use_build_context_synchronously
                                                showDialog(
                                                    context: context,
                                                    builder:
                                                        (BuildContext context) {
                                                      return AlertDialog(
                                                        title: const Center(
                                                            child:
                                                                Text('Erreur')),
                                                        content:
                                                            Text(errorMessage),
                                                        actions: <Widget>[
                                                          TextButton(
                                                            onPressed: () {
                                                              Navigator.of(
                                                                      context)
                                                                  .pop();
                                                            },
                                                            child: const Text(
                                                                'Ok'),
                                                          ),
                                                        ],
                                                      );
                                                    });
                                              });
                                              Navigator.of(context).pop();
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
                  child: const Text('Créer un forum')),
            ),
          ),
          Consumer<ForumService>(
            builder: (context, forumService, child) {
            return FutureBuilder(
                future:
                    forumService.getForumList(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
            
                  if (!snapshot.hasData) {
                    return const Center(
                      child: Text("Aucune donnée trouvé"),
                    );
                  } else {
                    forumListe = snapshot.data!;
                    return Column(
                        children: forumListe.map((Forum forum) {
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      Reponses(forum: forum)));
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Expanded(
                            child: Container(
                              width: double.infinity,
                              height: 220,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.white,
                                boxShadow: const [
                                  BoxShadow(
                                    offset: Offset(0.0, 0.0),
                                    blurRadius: 5.0,
                                    color: Color.fromRGBO(0, 0, 0, 0.38),
                                  )
                                ],
                              ),
                              child: Stack(
                                children: [
                                  // Image en haut du Container
                                  Positioned(
                                    top: 0,
                                    left: 0,
                                    right: 0,
                                    bottom:
                                        80, // Ajustez selon votre besoin
                                    child: ClipRRect(
                                      borderRadius:
                                          BorderRadius.circular(10),
                                      child: Image.asset(
                                        "assets/images/forum.jpg",
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  // Contenu en bas du Container
                                  Positioned(
                                    bottom: 10,
                                    // top: 10,
                                    left: 0,
                                    right: 0,
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Expanded(
                                          child: Padding(
                                            padding:
                                                const EdgeInsets.symmetric(
                                              horizontal: 15,
                                              vertical: 10,
                                            ),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  forum.libelle,
                                                  style: const TextStyle(
                                                    fontSize: 22,
                                                    fontWeight:
                                                        FontWeight.bold,
                                                    color: Colors.black,
                                                  ),
                                                ),
                                                IconButton(
                                                    onPressed: () {},
                                                    icon: const Icon(
                                                      Icons
                                                          .restore_from_trash,
                                                      size: 30,
                                                      color: Colors.red,
                                                    ))
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    }).toList());
                  }
                });
          }),
        ],
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
