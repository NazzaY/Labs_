import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async'; 

abstract class UserRepository {
  Future<void> saveUser(String email, String password, String nickname);
  Future<Map<String, String>?> getUser();
  Future<void> updateNickname(String nickname);
}

class LocalUserRepository implements UserRepository {
  @override
  Future<void> saveUser(String email, String password, String nickname) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('email', email);
    await prefs.setString('password', password);
    await prefs.setString('nickname', nickname);
    await prefs.setBool('isLoggedIn', true);
  }

  @override
  Future<Map<String, String>?> getUser() async {
    final prefs = await SharedPreferences.getInstance();
    final email = prefs.getString('email');
    final password = prefs.getString('password');
    final nickname = prefs.getString('nickname'); 
    if (email != null && password != null && nickname != null) {
      return {
        'email': email,
        'password': password,
        'nickname': nickname,
      };
    }
    return null;
  }

  @override
  Future<void> updateNickname(String nickname) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('nickname', nickname); 
  }
}
