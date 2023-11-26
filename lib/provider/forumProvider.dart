import 'package:demarche_app/model/Forum.dart';
import 'package:flutter/foundation.dart';

class ForumProvider with ChangeNotifier {
  final List<Forum> _forums = [];

  List<Forum> get forums => _forums;

  void ajouterForum(Forum newforum) {
    _forums.add(newforum);
    notifyListeners();
  }
}
