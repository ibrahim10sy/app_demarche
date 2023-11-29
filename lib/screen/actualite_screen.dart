import 'package:demarche_app/model/Actualite.dart';
import 'package:demarche_app/screen/actualite_detail.dart';
import 'package:demarche_app/screen/home.dart';
import 'package:demarche_app/service/actualiteService.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ActualiteScreen extends StatefulWidget {
  const ActualiteScreen({super.key});

  @override
  State<ActualiteScreen> createState() => _ActualiteScreenState();
}

const d_red = Color.fromRGBO(28, 36, 129, 10);

class _ActualiteScreenState extends State<ActualiteScreen> {
  late List<Actualite> actualiteListe = [];
  late Future<List<Actualite>> _actualite;
  var actualiteService = ActualiteService();

  Future<List<Actualite>> getActualiteListe() async {
    return actualiteService.fetchActualite();
  }

  @override
  void initState() {
    _actualite = getActualiteListe();
    _actualite.printInfo();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromARGB(255, 247, 245, 245),
        appBar: const CustomAppBar(),
        body: SizedBox(
            child: ListView(
          children: [
            FutureBuilder(
                future: _actualite,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  if (snapshot.hasError) {
                    return Center(
                      child: Text(snapshot.error.toString()),
                    );
                  }

                  if (!snapshot.hasData) {
                    return Center(
                      child: Text("Aucune donnée trouvé"),
                    );
                  }

                  actualiteListe = snapshot.data!;

                  return Column(
                      children: actualiteListe.map((Actualite actualite) {
                    return Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Expanded(
                        child: Container(
                          width: double.infinity,
                          height: 250,
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
                                bottom: 80, 
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: Image.network(
                                   "http://10.0.2.2/${actualite.image}",
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              // Contenu en bas du Container
                              Positioned(
                                bottom: 0,
                                // top: 10,
                                left: 0,
                                right: 0,
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Expanded(
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 15,
                                          vertical: 10,
                                        ),
                                        child: Text(
                                          actualite.libelle,
                                          style: const TextStyle(
                                            fontSize: 19,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 15,
                                        vertical: 10,
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          IconButton(
                                            onPressed: () {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      ActualiteDetail(
                                                          actualites: actualite),
                                                ),
                                              );
                                            },
                                            icon: const Icon(
                                              Icons.remove_red_eye_outlined,
                                              color: Colors.black,
                                              size: 25,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  }).toList());
                }),
          ],
        )));
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
            width: 70,
          ),
          const Text(
            'Actualites',
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
