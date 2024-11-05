import 'package:dio/dio.dart';

import '../../services/SessionManager.dart';
import '../models/Category.dart';
class ApiService {
  final Dio _dio = Dio();

  Future<dynamic> login(String email, String password) async {
    final response = await _dio.post('https://api.escuelajs.co/api/v1/auth/login',
      data: {'email': email, 'password': password},
    );
    print(response.data);
    if(response.statusCode!>=200 &&  response.statusCode!<=299){
      final accessToken = response.data['access_token'];
      final refreshToken = response.data['refresh_token'];

      // Save tokens to session manager
      await _sessionManager.saveTokens(accessToken, refreshToken);

      return true;
    }else{
      return false;
    }

  }

  final SessionManager _sessionManager = SessionManager();

  Future<List<dynamic>> fetchProducts() async {
    String? accessToken = await _sessionManager.getAccessToken();

    try {
      final response = await _dio.get(
        'https://prethewram.pythonanywhere.com/api/parts_categories/',
        options: Options(
          headers: {
            'Authorization': 'Bearer $accessToken',
          },
        ),
      );
      print(response.data);
      return response.data;
    } on DioError catch (e) {
      // Check if token expired
      if (e.response?.statusCode == 401) {
        await _sessionManager.refreshAccessToken();
        accessToken = await _sessionManager.getAccessToken();

        // Retry request with new access token
        final retryResponse = await _dio.get(
          'https://prethewram.pythonanywhere.com/api/parts_categories/',
          options: Options(
            headers: {
              'Authorization': 'Bearer $accessToken',
            },
          ),
        );
        return retryResponse.data;
      }
      throw Exception('Failed to fetch products');
    }
  }
  Future<List<dynamic>> fetchCategories() async {
    String? accessToken = await _sessionManager.getAccessToken();

    try {
      final response = await _dio.get(
        'https://prethewram.pythonanywhere.com/api/Top_categories/',
        options: Options(
          headers: {
            'Authorization': 'Bearer $accessToken',
          },
        ),
      );
      print(response.data);
      return response.data;
    } on DioError catch (e) {
      // Check if token expired
      if (e.response?.statusCode == 401) {
        // Attempt to refresh access token
        await _sessionManager.refreshAccessToken();
        accessToken = await _sessionManager.getAccessToken();

        // Retry request with new access token
        final retryResponse = await _dio.get(
          'https://prethewram.pythonanywhere.com/api/Top_categories/',
          options: Options(
            headers: {
              'Authorization': 'Bearer $accessToken',
            },
          ),
        );
        return retryResponse.data;
      }
      throw Exception('Failed to fetch categories');
    }
  }
}
