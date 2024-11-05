import 'package:flutter/material.dart';

import '../../../data/network/apiService.dart';

class LoginViewModel with ChangeNotifier {
  final ApiService _apiService = ApiService();

  bool _isLoading = false;
  String? _errorMessage;

  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  Future<bool> login(String email, String password) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    final success = await _apiService.login(email, password);

    if (success) {
      _isLoading = false;
      notifyListeners();
      return true; // Login was successful
    } else {
      _isLoading = false;
      _errorMessage = 'Login failed: Invalid credentials or network error';
      notifyListeners();
      return false; // Login failed
    }
  }
}
