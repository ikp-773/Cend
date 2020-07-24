import 'package:flutter/foundation.dart';

class Dark extends ChangeNotifier {
  bool _dark;

  Dark(this._dark);

  void darkOn() {
    _dark = !_dark;
    notifyListeners();
  }

  bool get dark {
    return _dark;
  }
}
