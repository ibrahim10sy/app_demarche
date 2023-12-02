import 'dart:io';

import 'package:demarche_app/model/Document.dart';
import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';

class DocumentScreen extends StatefulWidget {
  late Document document;

  DocumentScreen({super.key, required this.document});

  @override
  State<DocumentScreen> createState() => _DocumentScreenState();
}

const d_red = Color.fromRGBO(28, 36, 129, 10);
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
        appBar: const CustomAppBar(),
        body: SizedBox(
          child: ListView(
            children: [
              const SizedBox(
                height: 10,
              ),
              ClipRRect(
                borderRadius: BorderRadius.circular(80),
                // width: double.infinity,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: ("http://10.0.2.2/${documents.image!}" != null)
                      ? Image.network("http://10.0.2.2/${documents.image!}")
                      : Image.asset(
                          'assets/images/orange2.png',
                        ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 25, vertical: 30),
                  child: Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          documents.nom,
                          style: const TextStyle(
                              fontSize: 22, fontWeight: FontWeight.bold),
                        ),
                        IconButton(
                            onPressed: () {},
                            icon: const Icon(Icons.volume_up_outlined))
                      ],
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Container(
                    height: 450,
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
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 8,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(17.0),
                          child: Text(documents.description,
                              textAlign: TextAlign.justify,
                              style: const TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold)),
                        ),
                        const Padding(
                          padding: EdgeInsets.all(17.0),
                          child: Text('Service à contacter :',
                              textAlign: TextAlign.justify,
                              style: TextStyle(
                                  fontSize: 25, fontWeight: FontWeight.bold)),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(17.0),
                          child: Text(documents.bureau.nom,
                              textAlign: TextAlign.justify,
                              style: const TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold)),
                        ),
                        Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 40, vertical: 15),
                            child: ElevatedButton(
                              onPressed: () => pickFile(),
                              // onPressed: () {
                              //   _downloadPDF(documents);
                              // },
                              style: ElevatedButton.styleFrom(
                                shape: const StadiumBorder(),
                                backgroundColor:
                                    const Color.fromRGBO(28, 36, 129, 1.0),
                                padding: const EdgeInsets.all(17),
                              ),
                              child: const Text(
                                'Télécharger PDF',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            )),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ));
  }
}

Future<void> _downloadPDF(Document document) async {
  try {
    // Vérifier si l'attribut fichier est présent
    if (document.fichier != null && document.fichier!.isNotEmpty) {
      // Extraire le nom du fichier à partir de l'URL
      Uri uri = Uri.parse(document.fichier!);
      String fileName = uri.pathSegments.last;

      // Effectuer une requête HTTP pour obtenir le fichier PDF depuis l'API
      final response = await http.get(uri);

      //
      if (response.statusCode == 200) {
        // Obtenir le chemin l'application
        final documentDirectory = await getApplicationDocumentsDirectory();

        // Créer un objet File pour le fichier PDF
        final file = File('${documentDirectory.path}/$fileName');

        // Écrire les octets de la réponse dans le fichier
        await file.writeAsBytes(response.bodyBytes);

        // Le fichier est maintenant accessible localement
        print('Fichier PDF téléchargé à ${file.path}');
      } else {
        // Gérer l'erreur si la réponse n'est pas réussie
        print('Erreur lors du téléchargement du PDF: ${response.statusCode}');
      }
    } else {
      // Gérer le cas où l'attribut fichier est manquant ou vide
      print(
          'L\'attribut "fichier" est manquant ou vide dans l\'objet Document');
    }
  } catch (e) {
    // Gérer les exceptions lors du téléchargement
    print('Erreur lors du téléchargement du PDF: $e');
  }
}

Future openFile({required String url, String? fileName}) async {
  final name = fileName ?? url.split('/').last;
  final file = await pickFile();
  // final file = await donwloadFile(url, name);
  if (file == null) return null;

  print('Path : ${file.path}');
  OpenFile.open(file.path);
}

Future<File?> pickFile() async {
  final result = await FilePicker.platform.pickFiles();
  if (result == null) {
    return File(result!.files.first.path!);
  }
  return null;
}

Future<File?> donwloadFile(String url, String name) async {
  final appStorage = await getApplicationDocumentsDirectory();
  final file = File('${appStorage.path}/$name');

  try {
    final response = await Dio().get(
      url,
      options: Options(
        responseType: ResponseType.bytes,
        followRedirects: false,
        receiveTimeout: Duration.zero,
      ),
    );

    final raf = file.openSync(mode: FileMode.write);
    raf.writeFromSync(response.data);
    await raf.close();

    return file;
  } catch (e) {
    return null;
  }
}

// _downloadPDF(String url) async {
//   final response = await http
//       .get(Uri.parse(url));
//   final documentDirectory = await getApplicationDocumentsDirectory();
//   final file = File('${documentDirectory.path}/${documents.fichier!}');
//   file.writeAsBytesSync(response.bodyBytes);

//   // Maintenant le fichier est accessible localement
//   print('Fichier PDF téléchargé à ${file.path}');
// }

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
                  Navigator.of(context).pop();
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
