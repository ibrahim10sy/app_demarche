import 'package:demarche_app/model/Document.dart';
import 'package:demarche_app/model/Guide.dart';
import 'package:demarche_app/screen/document_screen.dart';
import 'package:demarche_app/screen/home.dart';
import 'package:demarche_app/service/guideService.dart';
import 'package:flutter/material.dart';

class GuideDetail extends StatefulWidget {
  final Guide guide;
  const GuideDetail({super.key, required this.guide});

  @override
  State<GuideDetail> createState() => _GuideDetailState();
}

const d_red = Color.fromRGBO(28, 36, 129, 10);

class _GuideDetailState extends State<GuideDetail> {
  late Guide guides;
  late List<Document> documentsListe = [];
  late Future<List<Document>> _documents;
  var guideervice = GuideService();

  @override
  void initState() {
    guides = widget.guide;
    print("guide details");
    print(guides.toString());
    _documents = fetchData(guides.idGuide!);
    print('doc $_documents.toString()');
    super.initState();
  }

  Future<List<Document>> fetchData(int id) async {
    return guideervice.getDocumentByIdGuide(id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(),
      body: SizedBox(
        // height: 1100,
        child: ListView(
          children: [
            const SizedBox(
              height: 35,
            ),
            Expanded(
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 150,
                        // scale: 0.7,
                        height: 150,
                        child: Image.network(
                          "http://10.0.2.2/${guides.image!}",
                          scale: 0.2,
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        guides.libelle,
                        style: const TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 25,
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Container(
                height: 460,
                width: 300,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: const [
                      BoxShadow(
                        color: Color.fromARGB(40, 15, 15, 15),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset: Offset(0, 3),
                      )
                    ]),
                child: Expanded(
                    child: FutureBuilder(
                        future: _documents,
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
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
                            return const Center(
                              child: Text("Aucune donné trouvé !"),
                            );
                          }

                          documentsListe = snapshot.data!;

                          return ListView.builder(
                            itemCount: documentsListe.length,
                            itemBuilder: (context, index) {
                              return ListTile(
                                  title: Text(documentsListe[index].nom,
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18)),
                                  trailing: IconButton(
                                    onPressed: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  DocumentScreen(
                                                      document: documentsListe[
                                                          index])));
                                    },
                                    icon: const Icon(
                                      Icons.info,
                                      size: 22,
                                    ),
                                  ));
                            },
                          );
                        })),
              ),
            )
          ],
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
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const Home()),
                  );
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
            'Détails',
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
