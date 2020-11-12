import 'package:flutter/foundation.dart';

class Avatar extends ChangeNotifier {
  String _avatar;

  Avatar(this._avatar);

  String get avatar {
    return _avatar;
  }

  set avatar(String s) {
    _avatar = s;
    notifyListeners();
  }

  void newAvatar(String userChoice) {
    _avatar = userChoice;
    notifyListeners();
  }

  @override
  String toString() => _avatar;
}
