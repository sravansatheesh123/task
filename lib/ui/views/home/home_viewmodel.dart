import 'package:flutter/material.dart';

import '../../../data/network/apiService.dart';

class HomeViewModel with ChangeNotifier {
  final ApiService apiService = ApiService();
  bool _isLoading = true;
  List<dynamic> _products = [];
  List<dynamic> _categories = [];
  String? _errorMessage;

  bool get isLoading => _isLoading;
  List<dynamic> get products => _products;
  List<dynamic> get categories => _categories;
  String? get errorMessage => _errorMessage;

  Future<void> fetchProductsAndCategories() async {
    _isLoading = true;
    notifyListeners();
    try {
      _products = await apiService.fetchProducts();
      _categories = await apiService.fetchCategories();
    } catch (e) {
      _errorMessage = 'Failed to load data';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
