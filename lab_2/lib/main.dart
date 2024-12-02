import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

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


class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const CustomTextField(label: 'Email'),
            const CustomTextField(label: 'Password'),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute<MainPage>(builder: (context) => 
                  const MainPage(),),
                );
              },
              child: const Text('Login'),
            ),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute<MainPage>(builder: (context) => 
                  const MainPage(),),
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


class RegistrationPage extends StatelessWidget {
  const RegistrationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Registration')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const CustomTextField(label: 'Email'),
            const CustomTextField(label: 'Password'),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute<MainPage>(builder: (context) =>
                   const MainPage(),),
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


class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  MainPageState createState() => MainPageState();
}

class MainPageState extends State<MainPage> {
  int _selectedIndex = 0;


  static const List<Widget> _pages = <Widget>[
    ComicListPage(),
    ProfilePage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _pages[_selectedIndex],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.redAccent,
        onTap: _onItemTapped,
      ),
    );
  }
}


class ComicListPage extends StatelessWidget {
  const ComicListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Comics Library'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 8,
            mainAxisSpacing: 8,
          ),
          itemCount: 6,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute<ComicDetailPage>(builder: (context) => 
                  ComicDetailPage(index: index),),

                );
              },
              child: ComicCard(index: index), 
            );
          },
        ),
      ),
    );
  }
}

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
      ),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('User Profile'),
            Text('Email'),
          ],
        ),
      ),
    );
  }
}


class ComicCard extends StatelessWidget {
  final int index;
  const ComicCard({required this.index, super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5, 
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          Expanded(
            child: Image.network(
              'https://m.media-amazon.com/images/M/MV5BNTkxZjhhOWItZDk1Yy00ZTBiLWE5YzgtYWU0MjAyOWQ1NjhhXkEyXkFqcGc@._V1_.jpg', 
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8),
            child: Text('Comic #$index', style: const 
            TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
          ),
        ],
      ),
    );
  }
}


class ComicDetailPage extends StatelessWidget {
  final int index;
  const ComicDetailPage({required this.index, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Comic #$index'),
      ),
      body: Center(
        child: Column(
          children: [
            Expanded(
              child: Image.network(
                'https://m.media-amazon.com/images/M/MV5BNTkxZjhhOWItZDk1Yy00ZTBiLWE5YzgtYWU0MjAyOWQ1NjhhXkEyXkFqcGc@._V1_.jpg', 
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8),
              child: Text(
                'Comic #$index - Full Comic View',
                style: const TextStyle(fontSize: 20, 
                fontWeight: FontWeight.bold,),
              ),
            ),
          ],
        ),
      ),
    );
  }
}


class CustomTextField extends StatelessWidget {
  final String label;

  const CustomTextField({required this.label, super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: TextField(
        decoration: InputDecoration(
          border: const OutlineInputBorder(),
          labelText: label,
        ),
      ),
    );
  }
}
