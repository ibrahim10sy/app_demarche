import 'package:demarche_app/model/Actualite.dart';
import 'package:demarche_app/screen/actualite_detail.dart';
import 'package:demarche_app/screen/home.dart';
import 'package:demarche_app/service/actualiteService.dart';
import 'package:flutter/material.dart';

class Actualite extends StatefulWidget {
  const Actualite({super.key});

  @override
  State<Actualite> createState() => _ActualiteState();
}

const d_red = Color.fromRGBO(28, 36, 129, 10);

class _ActualiteState extends State<Actualite> {
  late List<Actualites> actualiteListe = [];
  late Future<List<Actualites>> _actualite;
  var actualiteService = ActualiteService();

  @override
  void initState() {
    _actualite = getActualite();
    super.initState();
  }

  Future<List<Actualites>> getActualite() async {
    return actualiteService.fetchActualite();
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
                if (snapshot.hasError || snapshot.data == null) {
                  return const Center(
                    child: Text("Aucune donnée trouvée"),
                  );
                }
                actualiteListe = snapshot.data!;

                return Column(
                    children: actualiteListe.map((Actualites actualites) {
                  return Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Expanded(
                      child: Container(
                        width: double.infinity,
                        height: 300,
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
                        child: Column(
                          // mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              // width: double.infinity,
                              child: (actualites.image != null)
                                  ? Image.network(actualites.image!)
                                  : Image.asset(
                                      'assets/images/orange2.png',

                                      // fit: BoxFit.cover,
                                      // width: double.infinity,
                                    ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 15),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    actualites.libelle,
                                    style: const TextStyle(
                                        fontSize: 19,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black),
                                  ),
                                  IconButton(
                                      onPressed: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    ActualiteDetail(
                                                        actualites:
                                                            actualites)));
                                      },
                                      icon: const Icon(
                                        Icons.remove_red_eye_outlined,
                                        color: Colors.black,
                                        size: 25,
                                      ))
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
      )),
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
            'Actualités',
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
