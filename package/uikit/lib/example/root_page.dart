import 'package:flutter/material.dart';
import 'package:uikit/example/buttons_screen.dart';
import 'package:uikit/resources/resources.dart';
import 'package:uikit/widgets/bottom/app_bottom_nav_bar.dart';
import 'package:uikit/widgets/bottom/bottom_nav_item.dart';

class RootPage extends StatefulWidget {
  const RootPage({super.key});

  @override
  _RootPageState createState() => _RootPageState();
}

class _RootPageState extends State<RootPage> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    const ButtonsScreen(),
    const ButtonsScreen(),
    const ButtonsScreen(),
    const ButtonsScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: AppBottomNavBar(
        children: [
          BottomNavItem(
            iconPath: SvgIcons.calendar,
            title: 'Buttons',
            isActive: _selectedIndex == 0,
            onTap: () => _onItemTapped(0),
          ),
          BottomNavItem(
            iconPath: SvgIcons.filter,
            title: 'Forms',
            isActive: _selectedIndex == 1,
            onTap: () => _onItemTapped(1),
          ),
          BottomNavItem(
            iconPath: SvgIcons.chart,
            title: 'Sheets',
            isActive: _selectedIndex == 2,
            onTap: () => _onItemTapped(2),
          ),
          BottomNavItem(
            iconPath: SvgIcons.check,
            title: 'Misc',
            isActive: _selectedIndex == 3,
            onTap: () => _onItemTapped(3),
          ),
        ],
      ),
    );
  }
}
