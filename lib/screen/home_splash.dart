import 'package:demarche_app/delayed_animation.dart';
import 'package:demarche_app/screen/Inscription.dart';
import 'package:demarche_app/screen/connexion_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

const d_red = Color(0x001c2481);

class Home_splash extends StatelessWidget {
  const Home_splash({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
          child: Container(
        margin: const EdgeInsets.symmetric(
          vertical: 60,
          horizontal: 30,
        ),
        child: Column(
          children: [
            DelayedAnimation(
              delay: 1500,
              child: SizedBox(
                height: 270,
                child: Image.asset('assets/images/logo.png'),
              ),
            ),
            const DelayedAnimation(
              delay: 1500,
              child: SizedBox(
                  // height: 170,
                  child: Text(
                'Bienvenue !',
                style: TextStyle(
                    fontSize: 30,
                    fontFamily: 'Poppins',
                    color: Color.fromRGBO(28, 36, 129, 10),
                    fontWeight: FontWeight.bold),
              )),
            ),
            DelayedAnimation(
              delay: 3500,
              child: Container(
                margin: const EdgeInsets.only(
                  top: 35,
                  bottom: 80,
                ),
                child: Text(
                  "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(color: Colors.black, fontSize: 16),
                ),
              ),
            ),
            DelayedAnimation(
              delay: 4500,
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromRGBO(28, 36, 129, 10),
                      shape: const StadiumBorder(),
                      padding: const EdgeInsets.all(17)),
                  child: const Text(
                    'Commencer',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
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
            const SizedBox(
              height: 20,
            ),
            DelayedAnimation(
              delay: 4500,
              child: SizedBox(
                width: double.infinity,
                child: OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    // backgroundColor: const Color.fromRGBO(28, 36, 129, 10),
                    padding: const EdgeInsets.all(17),
                    shape: const StadiumBorder(),
                    side:
                        const BorderSide(color: Color(0xFF000000), width: 1.0),
                  ),
                  child: const Text(
                    'Se connecter',
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const Connexion_Screen()));
                  },
                ),
              ),
            )
          ],
        ),
      )),
    );
  }
}
