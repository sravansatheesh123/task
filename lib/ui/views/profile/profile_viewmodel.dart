import 'package:flutter/material.dart';

import '../../../services/SessionManager.dart';

class ProfileViewModel with ChangeNotifier {
  final SessionManager _sessionManager = SessionManager();

  Future<void> logout() async {
    await _sessionManager.logout();
    notifyListeners();
  }
}
