import 'package:demarche_app/model/Guide.dart';
import 'package:demarche_app/screen/guide_detail.dart';
import 'package:demarche_app/service/guideService.dart';
import 'package:flutter/material.dart';

class GuideScreen extends StatefulWidget {
  const GuideScreen({super.key});

  @override
  State<GuideScreen> createState() => _GuideScreenState();
}

class _GuideScreenState extends State<GuideScreen> {
  late List<Guide> guidesListe = [];
  late Future<List<Guide>> _futureListGuide;
  var guideService = GuideService();

  @override
  void initState() {
    super.initState();
    _futureListGuide = getGuide();
  }

  Future<List<Guide>> getGuide() async {
    return guideService.fetchGuide();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: FutureBuilder(
        future: _futureListGuide,
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
            return const Center(
              child: Text("Aucune donnée trouvée"),
            );
          }

          guidesListe = snapshot.data!;

          return Center(
            child: Wrap(
              spacing: 10,
              runSpacing: 10,
              children: guidesListe.map((Guide guide) {
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => GuideDetail(guide: guide)));
                  },
                  child: Container(
                    width: 150,
                    height: 150,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white,
                      boxShadow: const [
                        BoxShadow(
                            offset: Offset(0.0, 0.0),
                            blurRadius: 5.0,
                            color: Color.fromRGBO(0, 0, 0, 0.38))
                      ],
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.network("http://10.0.2.2/${guide.image}"),
                        const SizedBox(height: 10),
                        Text(
                          textAlign: TextAlign.center,
                          guide.libelle,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),
          );
        },
      ),
    );
  }
}
