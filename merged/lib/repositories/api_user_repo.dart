import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:merged/repositories/user_repo.dart';

class ApiUserRepository implements UserRepository {
  final String apiUrl;

  ApiUserRepository(this.apiUrl);

  @override
  Future<void> saveUser(String email, String password, String nickname) async {
    final response = await http.post(
      Uri.parse('$apiUrl/users'),
      body: jsonEncode({'email': email, 'password': password, 'nickname': nickname}),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 201) {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('email', email);
      await prefs.setString('nickname', nickname);
      await prefs.setBool('isLoggedIn', true);
    } else {
      throw Exception('Failed to save user');
    }
  }

  @override
  Future<Map<String, String>?> getUser() async {
    final prefs = await SharedPreferences.getInstance();
    final email = prefs.getString('email');
    final nickname = prefs.getString('nickname');
    if (email != null && nickname != null) {
      return {'email': email, 'nickname': nickname};
    }
    return null;
  }

  @override
  Future<void> updateNickname(String nickname) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('nickname', nickname);
  }
}
