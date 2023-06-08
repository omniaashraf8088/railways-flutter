import 'package:flutter/material.dart';
import 'package:reservation_railway/screen/booking/booking_screen.dart';
import 'package:reservation_railway/screen/home/home_screen.dart';
import 'package:reservation_railway/screen/profile/profile_screen.dart';
import 'package:reservation_railway/screen/search_screen.dart';
import 'package:reservation_railway/theme/theme.dart';

class MainScreen extends StatefulWidget {
  int currentScreen = 0;

  MainScreen({required this.currentScreen});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  final screens = [
    const HomeScreen(),
    const SearchScreen(),
    const BookingScreen(),
    const ProfileScreen(),
  ];

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.currentScreen;
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
            backgroundColor: primaryColor,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Search',
            backgroundColor: primaryColor,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: 'Booking',
            backgroundColor: primaryColor,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
            backgroundColor: primaryColor,
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: successColor,
        onTap: _onItemTapped,
      ),
    );
  }
}
