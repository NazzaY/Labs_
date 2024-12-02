import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async'; 
import 'package:merged/pages/login_page.dart'; 
import 'package:merged/repositories/user_repo.dart'; 
import 'package:merged/widgets/custom_text_field.dart'; 

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  ProfilePageState createState() => ProfilePageState();
}


class ProfilePageState extends State<ProfilePage> {
  late Future<Map<String, String>?> userFuture;
  final nicknameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    userFuture = LocalUserRepository().getUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
      ),
      body: FutureBuilder<Map<String, String>?>( 
        future: userFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (!snapshot.hasData || snapshot.data == null) {
            return const Center(child: Text('No user data found.'));
          }

          final user = snapshot.data!;
          nicknameController.text = user['nickname'] ?? '';

          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Email: ${user['email']}'),
                const SizedBox(height: 8),
                CustomTextField(
                  controller: nicknameController,
                  label: 'Nickname',
                ),
                ElevatedButton(
                  onPressed: () async {
                    final newNickname = nicknameController.text;
                    if (newNickname.isNotEmpty) {
                      final repo = LocalUserRepository();
                      await repo.updateNickname(newNickname);
                      setState(() {
                        userFuture = repo.getUser();
                      });
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Nickname updated')),
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Nickname cannot be empty')),
                      );
                    }
                  },
                  child: const Text('Update Nickname'),
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text('Log Out'),
                          content: const Text('Are you sure you want to log out?'),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.of(context).pop(),
                              child: const Text('Cancel'),
                            ),
                            TextButton(
                              onPressed: () async {
                              final prefs = await SharedPreferences.getInstance();
                              
                              await prefs.setBool('isLoggedIn', false);

                              Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(builder: (context) => const LoginPage()),
                                (route) => false,
                              );
                            },
                              child: const Text('Log Out'),
                            ),

                          ],
                        );
                      },
                    );
                  },
                  child: const Text('Log Out'),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
