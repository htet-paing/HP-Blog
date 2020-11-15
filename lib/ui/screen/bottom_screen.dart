import 'package:flutter/material.dart';
import 'explore_screen.dart';
import 'home_screen.dart';
import 'setting_screen.dart';

class BottomScreen extends StatefulWidget {
  static const routeName = '/bottom';
  @override
  _BottomScreenState createState() => _BottomScreenState();
}

class _BottomScreenState extends State<BottomScreen> {
  int _selectedPageIndex = 0;
  List<Map<String, Object>> _pages;


  @override
  void initState() {
    _pages = [
      {
        'page': HomeScreen(),
        'title': 'Home'
      },
      {
        'page': ExploreScreen(),
        'title': 'Explore'
      },
      {
        'page': SettingScreen(),
        'title': 'Profile'
      }
    ];
    super.initState();
  }

  void _selectedPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.white,    
      body: _pages[_selectedPageIndex]['page'],
      bottomNavigationBar: BottomNavigationBar(    
        onTap: _selectedPage,
        unselectedItemColor: Colors.grey,
        selectedItemColor: Colors.blue,
        currentIndex: _selectedPageIndex,
        items: [
          BottomNavigationBarItem(

            icon: Icon(Icons.home),
            label: 'Home'
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.explore),
            label: 'Explore'
          ),
          
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Setting'
          ),
        ]
      ),
    );
  }
}