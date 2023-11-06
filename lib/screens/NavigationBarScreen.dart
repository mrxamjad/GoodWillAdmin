import 'package:color_wala_admin/screens/CurrentMatchScreen.dart';
import 'package:color_wala_admin/screens/RechargeScreen.dart';
import 'package:color_wala_admin/screens/withdrawScreen.dart';
import 'package:flutter/material.dart';

import 'package:google_nav_bar/google_nav_bar.dart';

import 'MatchScreen.dart';

/// Flutter code sample for [BottomNavigationBar].

class BottomNavigationBarExampleApp extends StatelessWidget {
  const BottomNavigationBarExampleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: BottomNavigationBarExample(),
    );
  }
}

class BottomNavigationBarExample extends StatefulWidget {
  const BottomNavigationBarExample({super.key});

  @override
  State<BottomNavigationBarExample> createState() =>
      _BottomNavigationBarExampleState();
}

class _BottomNavigationBarExampleState
    extends State<BottomNavigationBarExample> {
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.w600);
  static final List<Widget> _widgetOptions = <Widget>[
    const CurrentMatch(),
    const WithdrawTab(),
    const MatchScreen(),
    const RechargeScreen()
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: GNav(
        // rippleColor: Colors.grey[300]!,
        // hoverColor: Colors.grey[100]!,
        gap: 8,

        curve: Curves.easeOut,
        activeColor: Colors.white,
        iconSize: 28,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        duration: const Duration(milliseconds: 400),
        tabBackgroundColor: Colors.teal,
        backgroundColor: Colors.teal[100]!,
        color: Colors.teal,
        tabs: const [
          GButton(
            icon: Icons.home,
            text: 'Match',
          ),
          GButton(
            icon: Icons.currency_rupee,
            text: 'Withdraw',
          ),
          GButton(
            icon: Icons.games,
            text: 'Games',
          ),
          GButton(
            icon: Icons.person,
            text: 'Recharge',
          ),
        ],
        selectedIndex: _selectedIndex,
        onTabChange: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
      ),
    );
  }
}
