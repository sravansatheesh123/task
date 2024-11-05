import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SessionManager {
  static const String _keyAccessToken = 'accessToken';
  static const String _keyRefreshToken = 'refreshToken';

  /// Save tokens to SharedPreferences
  Future<void> saveTokens(String accessToken, String refreshToken) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_keyAccessToken, accessToken);
    await prefs.setString(_keyRefreshToken, refreshToken);
  }

  /// Retrieve access token
  Future<String?> getAccessToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_keyAccessToken);
  }

  /// Retrieve refresh token
  Future<String?> getRefreshToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_keyRefreshToken);
  }

  /// Clear tokens on logout
  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_keyAccessToken);
    await prefs.remove(_keyRefreshToken);
  }

  /// Refresh the access token using the refresh token
  Future<void> refreshAccessToken() async {
    final prefs = await SharedPreferences.getInstance();
    String? refreshToken = prefs.getString(_keyRefreshToken);

    if (refreshToken != null) {
      // Replace this with your API service for refreshing tokens
      final response = await Dio().post('https://api.escuelajs.co/api/v1/auth/refresh',
        data: {'refresh_token': refreshToken},
      );

      if (response.statusCode == 200) {
        String newAccessToken = response.data['access_token'];
        await prefs.setString(_keyAccessToken, newAccessToken);
      } else {
        throw Exception("Failed to refresh access token");
      }
    }
  }
}
