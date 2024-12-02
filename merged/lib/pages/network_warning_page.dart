import 'package:flutter/material.dart';
//import 'package:merged/main.dart'; 
import 'package:merged/pages/main_page.dart'; 

class NetworkWarningPage extends StatelessWidget {
  const NetworkWarningPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('No Internet Connection'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.wifi_off, size: 100, color: Colors.redAccent),
            const SizedBox(height: 20),
            const Text(
              'You are offline',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            const Text(
              'Please check your internet connection and try again.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: () async {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => const MainPage()),
                  );
              },
              child: const Text('Offline mode'),
            ),
          ],
        ),
      ),
    );
  }
}
