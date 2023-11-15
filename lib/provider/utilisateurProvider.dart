import 'package:demarche_app/model/Utilisateur.dart';
import 'package:flutter/foundation.dart';


class utilisateurProvider with ChangeNotifier {
  Utilisateur? _utilisateur;

  Utilisateur? get utilisateur => _utilisateur;

  void setUtilisateur(Utilisateur utilisateur){
     _utilisateur = utilisateur;
    notifyListeners(); 
  }
}
