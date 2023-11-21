import 'package:demarche_app/model/Document.dart';
import 'package:flutter/material.dart';

class DocumentScreen extends StatefulWidget {
  late Document document;

  DocumentScreen({super.key, required this.document});

  @override
  State<DocumentScreen> createState() => _DocumentScreenState();
}

late Document documents;

class _DocumentScreenState extends State<DocumentScreen> {
  @override
  void initState() {
    documents = widget.document;
    debugPrint("doc recup ! $documents");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Text('database screen'),
      ),
    );
  }
}
