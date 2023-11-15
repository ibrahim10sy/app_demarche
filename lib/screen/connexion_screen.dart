import 'package:demarche_app/delayed_animation.dart';
import 'package:demarche_app/screen/Inscription.dart';
import 'package:demarche_app/screen/home.dart';
import 'package:flutter/material.dart';

class Connexion_Screen extends StatefulWidget {
  const Connexion_Screen({super.key});

  @override
  State<Connexion_Screen> createState() => _Connexion_ScreenState();
}

const d_red = Color.fromRGBO(28, 36, 129, 10);

class _Connexion_ScreenState extends State<Connexion_Screen> {
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromARGB(255, 245, 242, 242),
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white.withOpacity(0),
          leading: Row(
            children: [
              IconButton(
                icon: const Icon(
                  Icons.arrow_back,
                  color: Colors.black,
                  size: 30,
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              // const Expanded(
              //   child: Text(
              //     'Retour',
              //   ),
              // )
            ],
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin:
                    const EdgeInsets.symmetric(vertical: 35, horizontal: 118),
                child: DelayedAnimation(
                  delay: 1500,
                  child: SizedBox(
                    height: 180,
                    child: Image.asset('assets/images/logo.png'),
                  ),
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 40),
                child: Text(
                  'Connexion',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontSize: 25,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    const Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 40, vertical: 16),
                        child: TextField(
                          style: TextStyle(fontSize: 18.0),
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.all(18.0),
                            hintText: 'Nom d\'utilisateur ou email',
                            prefixIcon: Icon(
                              Icons.person,
                              color: d_red,
                              size: 30.0,
                            ),
                            border: OutlineInputBorder(
                              //  borderRadius: BorderRadius.circular(10.0),
                              borderSide:
                                  BorderSide(color: Colors.black, width: 2.0),
                            ),
                          ),
                        )),
                    const Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 40, vertical: 0),
                        child: TextField(
                          style: TextStyle(fontSize: 18.0),
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.all(18.0),
                            hintText: 'Mot de passe',
                            prefixIcon: Icon(
                              Icons.lock,
                              color: d_red,
                              size: 30.0,
                            ),
                            border: OutlineInputBorder(
                              //  borderRadius: BorderRadius.circular(10.0),
                              borderSide:
                                  BorderSide(color: Colors.black, width: 2.0),
                            ),
                          ),
                        )),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 45, vertical: 15),
                      child: GestureDetector(
                        onTap: () {
                          // Action à effectuer lorsqu'un appui simple est détecté
                          print('Appui simple détecté!');
                        },
                        child: Container(
                          alignment: Alignment.centerRight,
                          child: Container(
                            padding: const EdgeInsets.all(1.0),
                            child: const Text(
                              'Mot de passe oublié!',
                              style: TextStyle(
                                decoration: TextDecoration.underline,
                                decorationColor: d_red,
                                color: d_red,
                                fontSize: 16.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 40, vertical: 15),
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const home()));
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                const Color.fromRGBO(28, 36, 129, 1.0),
                            // shape: const StadiumBorder(),
                            padding: const EdgeInsets.all(17),
                          ),
                          child: const Text(
                            'Connexion',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Text(
                      'Ou',
                      style:
                          TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 40, vertical: 15),
                          child: ElevatedButton(
                            onPressed: () {
                              print('Bouton pressé!');
                            },
                            
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  const Color.fromRGBO(28, 36, 129, 1.0),
                                 
                              padding: const EdgeInsets.all(17),
                            ),
                            child: const Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(
                                    width:
                                        8), // Espace entre l'icône et le texte (facultatif)
                                Text(
                                  'Continue avec Google',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          )),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 45, vertical: 15),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const Inscription()));
                          print('Appui simple détecté!');
                        },
                        child: Container(
                          alignment: Alignment.center,
                          child: Container(
                            padding: const EdgeInsets.all(1.0),
                            child: const Text(
                              'Vous n\'avez pas de compte ? Créer un compte',
                              style: TextStyle(
                                decoration: TextDecoration.underline,
                                decorationColor: d_red,
                                color: d_red,
                                fontSize: 15.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}
