import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:merged/main.dart'; 
import 'package:merged/pages/registration.dart';
import 'package:merged/pages/main_page.dart';
import 'package:merged/repositories/user_repo.dart'; 
import 'package:merged/widgets/custom_text_field.dart'; 


class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _checkLoginStatus();
  }

  Future<void> _checkLoginStatus() async {
    final prefs = await SharedPreferences.getInstance();
    bool isLoggedIn = prefs.getBool('isLoggedIn') ?? false;
    if (isLoggedIn) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const MainPage()),
      );
    }
  }

  Future<void> _login() async {
    final hasInternet = await checkInternetConnection();
    if (!hasInternet) {
      showDialogMessage(context, 'No Internet', 'Please check your connection.');
      return;
    }

    final email = emailController.text;
    final password = passwordController.text;

    final repo = LocalUserRepository();
    final userData = await repo.getUser();

    if (userData != null &&
        userData['email'] == email &&
        userData['password'] == password) {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool('isLoggedIn', true);

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const MainPage()),
      );

      showDialogMessage(context, 'Success', 'Login successful!');
    } else {
      showDialogMessage(context, 'Error', 'Invalid credentials');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomTextField(controller: emailController, label: 'Email'),
            CustomTextField(controller: passwordController, label: 'Password'),
            ElevatedButton(
              onPressed: _login,
              child: const Text('Login'),
            ),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const RegistrationPage()),
                );
              },
              child: const Text('Register'),
            ),
          ],
        ),
      ),
    );
  }
}
