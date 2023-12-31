import 'package:demarche_app/model/Utilisateur.dart';
import 'package:flutter/foundation.dart';

class UtilisateurProvider with ChangeNotifier {
  Utilisateur? _utilisateur;

  Utilisateur? get utilisateur => _utilisateur;

  void setUtilisateur(Utilisateur utilisateur) {
    _utilisateur = utilisateur;
    debugPrint("setUtilisateur : $utilisateur");
    notifyListeners();
  }
}
