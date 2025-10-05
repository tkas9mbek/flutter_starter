import 'package:flutter/material.dart';
import 'package:starter_uikit/example/bottom_sheets_screen.dart';
import 'package:starter_uikit/example/buttons_screen.dart';
import 'package:starter_uikit/example/forms_screen.dart';
import 'package:starter_uikit/example/misc_screen.dart';
import 'package:starter_uikit/resources/resources.dart';
import 'package:starter_uikit/widgets/bottom/app_bottom_nav_bar.dart';
import 'package:starter_uikit/widgets/bottom/bottom_nav_item.dart';

class RootPage extends StatefulWidget {
  const RootPage({super.key});

  @override
  _RootPageState createState() => _RootPageState();
}

class _RootPageState extends State<RootPage> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    const ButtonsScreen(),
    const FormsScreen(),
    const BottomSheetsScreen(),
    const MiscScreen(),
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
            iconPath: UiSvgIcons.calendar,
            title: 'Buttons',
            isActive: _selectedIndex == 0,
            onTap: () => _onItemTapped(0),
          ),
          BottomNavItem(
            iconPath: UiSvgIcons.filter,
            title: 'Forms',
            isActive: _selectedIndex == 1,
            onTap: () => _onItemTapped(1),
          ),
          BottomNavItem(
            iconPath: UiSvgIcons.chart,
            title: 'Sheets',
            isActive: _selectedIndex == 2,
            onTap: () => _onItemTapped(2),
          ),
          BottomNavItem(
            iconPath: UiSvgIcons.check,
            title: 'Misc',
            isActive: _selectedIndex == 3,
            onTap: () => _onItemTapped(3),
          ),
        ],
      ),
    );
  }
}
