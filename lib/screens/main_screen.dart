import 'package:flutter/material.dart';
import 'home_screen.dart';
import 'centers_screen.dart';
import 'profile_screen.dart';
import 'settings_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;

  // List of widgets to be displayed when the tabs are selected
  final List<Widget> _screens = [
    const HomeScreen(title: 'Home'),
    const CentersScreen(),
    const ProfileScreen(),
    const SettingsScreen(),
  ];

  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: _onTabTapped,
        items: [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
              color: _currentIndex == 0 ? Colors.blue : Colors.grey,
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.location_city,
              color: _currentIndex == 1 ? Colors.green : Colors.grey,
            ),
            label: 'Centers',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.person,
              color: _currentIndex == 2 ? Colors.purple : Colors.grey,
            ),
            label: 'Profile',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.settings,
              color: _currentIndex == 3 ? Colors.orange : Colors.grey,
            ),
            label: 'Settings',
          ),
        ],
        selectedItemColor: _getSelectedColor(_currentIndex),
        unselectedItemColor: Colors.grey,
      ),
    );
  }

  // Get the color for the selected item
  Color _getSelectedColor(int index) {
    switch (index) {
      case 0:
        return Colors.blue;
      case 1:
        return Colors.green;
      case 2:
        return Colors.purple;
      case 3:
        return Colors.orange;
      default:
        return Colors.blue;
    }
  }
}
