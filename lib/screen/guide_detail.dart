import 'package:demarche_app/model/Document.dart';
import 'package:demarche_app/model/Guide.dart';
import 'package:demarche_app/service/guideService.dart';
import 'package:flutter/material.dart';

class GuideDetail extends StatefulWidget {
  final Guide guide;
  const GuideDetail({super.key, required this.guide});

  @override
  State<GuideDetail> createState() => _GuideDetailState();
}

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
      appBar: AppBar(
        title: Text('guide details'),
      ),
    );
  }
}
