import 'package:demarche_app/delayed_animation.dart';
import 'package:demarche_app/screen/Inscription.dart';
import 'package:flutter/material.dart';

class commence1 extends StatelessWidget {
  const commence1({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            ],
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                margin:
                    const EdgeInsets.symmetric(vertical: 35, horizontal: 118),
                child: DelayedAnimation(
                  delay: 1500,
                  child: SizedBox(
                    width: 1100,
                    height: 280,
                    child: Image.asset(
                      'assets/images/image16.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 25,
              ),
              const DelayedAnimation(
                delay: 1500,
                child: Padding(
                    // height: 170,
                    padding: EdgeInsets.all(15),
                    child: Text(
                      textAlign: TextAlign.justify,
                      'Démarche Facile est une application conçue pour vous facile vos démarche administratives ',
                      style: TextStyle(
                          fontSize: 18,
                          fontFamily: 'Poppins',
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                    )),
              ),
              const SizedBox(
                height: 70,
              ),
              DelayedAnimation(
                delay: 4500,
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor:
                              const Color.fromRGBO(28, 36, 129, 10),
                          shape: const StadiumBorder(),
                          padding: const EdgeInsets.all(17)),
                      child: const Text(
                        'Suivant',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const Inscription()));
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
