import 'package:flutter/material.dart';
import 'package:merged/main.dart'; 
import 'package:merged/pages/main_page.dart'; 
import 'package:merged/repositories/user_repo.dart'; 
import 'package:merged/widgets/custom_text_field.dart'; 

class RegistrationPage extends StatelessWidget {
  const RegistrationPage({super.key});

  @override
  Widget build(BuildContext context) {
    final emailController = TextEditingController();
    final passwordController = TextEditingController();
    final nicknameController = TextEditingController();

    return Scaffold(
      appBar: AppBar(title: const Text('Registration')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomTextField(controller: emailController, label: 'Email'),
            CustomTextField(controller: passwordController, label: 'Password'),
            CustomTextField(controller: nicknameController, label: 'Nickname'),
            ElevatedButton(
              onPressed: () async {
                final email = emailController.text;
                final password = passwordController.text;
                final nickname = nicknameController.text;

                if (validateEmail(email) &&
                    validatePassword(password) &&
                    nickname.isNotEmpty) {
                  final repo = LocalUserRepository();
                  await repo.saveUser(email, password, nickname);
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const MainPage()),
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Invalid input data')),
                  );
                }
              },
              child: const Text('Register'),
            ),
          ],
        ),
      ),
    );
  }
}