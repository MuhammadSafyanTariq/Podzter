import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        systemNavigationBarColor: Colors.black,
        statusBarColor: Color.fromRGBO(0, 0, 0, 0.50),
        systemNavigationBarIconBrightness: Brightness.light,
      ),
    );
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
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
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
