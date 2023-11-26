import 'package:demarche_app/screen/accueil.dart';
import 'package:demarche_app/screen/actualite.dart';
import 'package:demarche_app/screen/forum.dart';
import 'package:demarche_app/screen/localisation.dart';
import 'package:flutter/material.dart';

class Nav extends StatefulWidget {
  const Nav({super.key});

  @override
  State<Nav> createState() => _NavState();
}

const dRed = Color.fromRGBO(28, 36, 129, 10);

class _NavState extends State<Nav> {
  int _selectedIndex = 0;

  final List<Widget> _listTab = <Widget>[
    const Accueil(),
    const Localisation(),
    const Actualite(),
    const Forums()
  ];

  void _currentIndex(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 245, 242, 242),
      body: Center(child: _listTab.elementAt(_selectedIndex)),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: const Color.fromARGB(255, 245, 242, 242),
        elevation: 12.0,

        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
              color: dRed,
              size: 30,
            ),
            label: 'Accueil',
            // backgroundColor: Colors.white,
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.location_on,
              color: dRed,
              size: 30,
            ),
            label: 'Localisation',
            // backgroundColor: Colors.white,
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.article,
              color: dRed,
              size: 30,
            ),
            label: 'Actualite',
            // backgroundColor: Colors.white,
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.forum,
              color: dRed,
              size: 30,
            ),
            label: 'Forum',
            // backgroundColor: Colors.white,
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: dRed,
        unselectedItemColor:
            Colors.grey, // Couleur des icônes non sélectionnées
        selectedFontSize: 16.0, // Taille des icônes sélectionnées
        unselectedFontSize: 14.0, // Taille des icônes non sélectionnées
        onTap: _currentIndex,
      ),
    );
  }
}
