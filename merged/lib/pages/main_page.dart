import 'package:flutter/material.dart';
import 'package:merged/main.dart'; 
import 'package:merged/pages/list_page.dart';
import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'profile_page.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  MainPageState createState() => MainPageState();
}


class MainPageState extends State<MainPage> {
  int _selectedIndex = 0; 
  late StreamSubscription<ConnectivityResult> subscription;

  static const List<Widget> _pages = <Widget>[
    ComicListPage(),
    ProfilePage(),   
  ];

  @override
  void initState() {
    super.initState();
    
    subscription = Connectivity().onConnectivityChanged.listen((result) {
      if (result == ConnectivityResult.none) {
        showDialogMessage(context, 'No Internet', 'You are offline.');
      }
    });
  }

  @override
  void dispose() {
    subscription.cancel();
    super.dispose();
  }

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