import 'package:demarche_app/screen/home.dart';
import 'package:demarche_app/screen/map_page.dart';
import 'package:flutter/material.dart';

class Localisation extends StatefulWidget {
  const Localisation({super.key});

  @override
  State<Localisation> createState() => _LocalisationState();
}

const d_red = Color.fromRGBO(28, 36, 129, 10);

class _LocalisationState extends State<Localisation> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Color.fromARGB(255, 245, 242, 242),
      appBar: CustomAppBar(),
      body: MapPage(),
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
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => const Home()));
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
            width: 70,
          ),
          const Text(
            'Localisation',
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
