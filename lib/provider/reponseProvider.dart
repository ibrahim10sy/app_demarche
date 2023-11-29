import 'package:demarche_app/model/Forum.dart';
import 'package:demarche_app/model/Reponse.dart';
import 'package:flutter/foundation.dart';

class ReponseProvider with ChangeNotifier {
  final List<Reponse> _reponses = [];
 
 List<Reponse> get reponse => _reponses;

  void ajouterReponse(Reponse responses) {
    _reponses.add(responses);
    notifyListeners();
  }
}
