import 'package:flutter/material.dart';
import 'package:insta_clone/Widgets/custom_nav_bar.dart';
import 'package:insta_clone/utils/GlobalVariables.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final PageController _pageController = PageController();
  int _selectedIndex = 0;

  void _onItemSelected(int index) {
    setState(() {
      _selectedIndex = index;
      _pageController.jumpToPage(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView(
            controller: _pageController,
            children: homeScreenItems,
            onPageChanged: (index) {
              setState(() {
                _selectedIndex = index;
              });
            },
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: CustomNavBar(
              onItemSelected: _onItemSelected,
              selectedIndex: _selectedIndex,
            ),
          ),
        ],
      ),
    );
  }
}
