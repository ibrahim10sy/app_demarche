import 'package:demarche_app/model/Forum.dart';
import 'package:flutter/foundation.dart';

class ForumProvider with ChangeNotifier {
  final List<Forum> _forumList = [];

  List<Forum> get forums => _forumList;

  void ajouterForum(Forum newforum) {
    _forumList.add(newforum);
    notifyListeners();
  }
}
