import 'dart:convert';
import 'package:flutter_planner/models/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CacheClient {
  final SharedPreferences prefs;
  CacheClient(this.prefs);

  /// Caches the current user's data.
  Future<void> cacheCurrentUser(UserModel user) async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      String userJson =
          jsonEncode(user.toJson()); // Convert user to JSON string
      await prefs.setString('cachedUser', userJson);
    } catch (e) {
      // Handle exceptions (e.g., logging)
      print('Error caching user: $e');
    }
  }

  /// Retrieves the cached user's data.
  Future<UserModel?> getCachedUser() async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      String? userJson = prefs.getString('cachedUser');
      if (userJson == null) return null;
      return UserModel.fromJson(
          jsonDecode(userJson)); // Convert JSON string back to UserModel
    } catch (e) {
      // Handle exceptions (e.g., logging)
      print('Error retrieving user from cache: $e');
      return null;
    }
  }
}
