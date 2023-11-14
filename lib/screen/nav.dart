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
    const Forum()
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
       elevation: 12.0, // Augmentation de l'élévation
        
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home, color: dRed),
            label: 'Accueil',
            // backgroundColor: Colors.white,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.location_on, color: dRed),
            label: 'Localisation',
            // backgroundColor: Colors.white,
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.article,
              color: dRed,
              size: 22,
            ),
            label: 'Actualite',
            // backgroundColor: Colors.white,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.forum, color: dRed),
            label: 'Forum',
            // backgroundColor: Colors.white,
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: dRed,
        onTap: _currentIndex,
      ),
    );
  }
}
