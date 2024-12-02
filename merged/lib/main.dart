import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:connectivity_plus/connectivity_plus.dart'; 
import 'dart:async'; 
import 'package:merged/pages/login_page.dart';
import 'package:merged/pages/main_page.dart';
import 'package:merged/pages/network_warning_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); 
  final prefs = await SharedPreferences.getInstance();
  final isLoggedIn = prefs.getBool('isLoggedIn') ?? false;
  final hasInternet = await checkInternetConnection();

  runApp(
    MaterialApp(
      theme: ThemeData(brightness: Brightness.dark, primarySwatch: Colors.red),
      home: isLoggedIn
          ? hasInternet
              ? const MainPage()
              : const NetworkWarningPage()
          : const LoginPage(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.red,
      ),
      home: const LoginPage(),
    );
  }
}

Future<bool> checkInternetConnection() async {
  var connectivityResult = await Connectivity().checkConnectivity();
  return connectivityResult != ConnectivityResult.none;
}

void showDialogMessage(BuildContext context, String title, String message) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(title),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('OK'),
          ),
        ],
      );
    },
  );
}


   @override
  Future<Map<String, String>?> getUser() async {
    final prefs = await SharedPreferences.getInstance();
    final email = prefs.getString('email');
    final password = prefs.getString('password');
    final nickname = prefs.getString('nickname');
    if (email != null && password != null && nickname != null) {
      return {'email': email, 'password': password, 'nickname': nickname};
    }
    return null;
  }

  @override
  Future<void> updateNickname(String nickname) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('nickname', nickname);
  }

bool validateEmail(String email) {
  final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
  return emailRegex.hasMatch(email);
}

bool validatePassword(String password) {
  return password.length >= 6;
}

