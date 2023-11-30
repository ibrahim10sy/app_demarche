import 'package:demarche_app/model/Utilisateur.dart';
import 'package:demarche_app/screen/home.dart';
import 'package:demarche_app/screen/update_profil.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/utilisateurProvider.dart';

class Profil extends StatefulWidget {
  const Profil({super.key});

  @override
  State<Profil> createState() => _ProfilState();
}

const d_red = Color.fromRGBO(28, 36, 129, 10);

class _ProfilState extends State<Profil> {
  late Utilisateur utilisateur;

  @override
  void initState() {
    utilisateur =
        Provider.of<UtilisateurProvider>(context, listen: false).utilisateur!;
    debugPrint("user recuperation : $utilisateur");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: d_red,
      appBar: const CustomAppBar(),
      body: Stack(
        children: [
          Column(
            children: [
              Positioned(
                top: 200,
                // left: 85,
                child: Consumer<UtilisateurProvider>(
                    builder: (context, utilisateurprovider, child) {
                  final user = utilisateurprovider.utilisateur;
                  return user?.image == null || user?.image?.isEmpty == true
                      ? CircleAvatar(
                          backgroundColor: d_red,
                          radius: 28,
                          child: Text(
                            "${user!.prenom.substring(0, 1).toUpperCase()}${user.nom.substring(0, 1).toUpperCase()}",
                            style: const TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                letterSpacing: 2),
                          ),
                        )
                      : ClipRRect(
                          borderRadius: BorderRadius.circular(200.0),
                          child: SizedBox(
                            width: 210.0,
                            height: 210.0,
                            child: Image.network(
                              "http://10.0.2.2/${user!.image!}",
                              // fit: BoxFit.fill,
                              fit: BoxFit
                                  .cover, // ou BoxFit.contain, BoxFit.fill, etc.
                              // scale: 0.5,
                            ),
                          ));
                }),
              ),
              Expanded(
                child: Container(
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(80.0),
                        topRight: Radius.circular(
                            80.0), // Arrondir le coin supérieur droit
                      ),
                    ),
                    height: MediaQuery.of(context).size.height *
                        0.8, // 80% de la hauteur de l'écran
                    width: MediaQuery.of(context).size.width,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const SizedBox(height: 110),
                        Consumer<UtilisateurProvider>(
                            builder: (context, utilisateurprovider, child) {
                          final user = utilisateurprovider.utilisateur;
                          return Column(
                            children: [
                               Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Text(
                            "Nom : ${user!.nom.toUpperCase()} ${user.prenom.toUpperCase()}",
                            style: const TextStyle(
                                fontSize: 22, fontWeight: FontWeight.bold),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Text(
                            "Email : ${user.email}",
                            style: const TextStyle(
                                fontSize: 22, fontWeight: FontWeight.bold),
                          ),
                        ),
                            ],
                          );
                        }),
                        OutlinedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const UpdateProfil()),
                            );
                          },
                          style: ButtonStyle(
                            side: MaterialStateProperty.all(const BorderSide(
                              color: d_red,
                            )),
                            padding: MaterialStateProperty.all(
                                const EdgeInsets.all(10)),
                          ),
                          child: const Text(
                            'Modifier profil',
                            style: TextStyle(
                              color: d_red,
                              fontSize: 20,
                            ),
                          ),
                        )
                      ],
                    )),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

//  Padding(
//                           padding: const EdgeInsets.all(10.0),
//                           child: Text(
//                             "Nom : ${utilisateur.nom.toUpperCase()} ${utilisateur.prenom.toUpperCase()}",
//                             style: const TextStyle(
//                                 fontSize: 22, fontWeight: FontWeight.bold),
//                           ),
//                         ),
//                         Padding(
//                           padding: const EdgeInsets.all(10.0),
//                           child: Text(
//                             "Email : ${utilisateur.email}",
//                             style: const TextStyle(
//                                 fontSize: 22, fontWeight: FontWeight.bold),
//                           ),
//                         ),
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
        color: d_red,
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
                icon: const Icon(
                  Icons.arrow_back_ios,
                  color: Colors.white,
                ),
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
            'Profil',
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          )
        ],
      ),
    );
  }
}
