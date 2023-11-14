import 'package:demarche_app/delayed_animation.dart';
import 'package:demarche_app/screen/connexion_screen.dart';
import 'package:flutter/material.dart';

class Inscription extends StatefulWidget {
  const Inscription({super.key});

  @override
  State<Inscription> createState() => _InscriptionState();
}

const d_red = Color.fromRGBO(28, 36, 129, 10);

class _InscriptionState extends State<Inscription> {
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
                    height: 140,
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
                  'Inscription',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontSize: 25,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 40, vertical: 0),
                      child: Text(
                        'Nom',
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          fontSize: 18,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    const Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 40, vertical: 16),
                        child: TextField(
                          style: TextStyle(fontSize: 18.0),
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.all(18.0),
                            labelText: 'Nom ',
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
                      child: Text(
                        'Prénom',
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          fontSize: 18,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    const Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 40, vertical: 16),
                        child: TextField(
                          style: TextStyle(fontSize: 18.0),
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.all(18.0),
                            labelText: 'Prénom ',
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
                      child: Text(
                        'Email',
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          fontSize: 18,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    const Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 40, vertical: 16),
                        child: TextField(
                          style: TextStyle(fontSize: 18.0),
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.all(18.0),
                            labelText: 'Email ',
                            prefixIcon: Icon(
                              Icons.email,
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
                      child: Text(
                        'Mot de passe ',
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          fontSize: 18,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    const Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 40, vertical: 16),
                        child: TextField(
                          style: TextStyle(fontSize: 18.0),
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.all(18.0),
                            labelText: 'Mot de passe ',
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
                    const Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 40, vertical: 0),
                      child: Text(
                        'Confirmer mot de passe',
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          fontSize: 18,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    const Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 40, vertical: 16),
                        child: TextField(
                          style: TextStyle(fontSize: 18.0),
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.all(18.0),
                            labelText: 'Mot de passe  ',
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
                    SizedBox(
                      width: double.infinity,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 40, vertical: 15),
                        child: ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                const Color.fromRGBO(28, 36, 129, 1.0),
                            // shape: const StadiumBorder(),
                            padding: const EdgeInsets.all(17),
                          ),
                          child: const Text(
                            'Inscription',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 45, vertical: 15),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const Connexion_Screen()));
                          print('Appui simple détecté!');
                        },
                        child: Container(
                          alignment: Alignment.centerRight,
                          child: Container(
                            padding: const EdgeInsets.all(1.0),
                            child: const Text(
                              'Vous avez déà un compte ? Conncectez-vous',
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
