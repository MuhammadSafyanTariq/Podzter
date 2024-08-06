import 'dart:ui';
import 'package:flutter/material.dart';

class CustomNavBar extends StatelessWidget {
  final Function(int) onItemSelected;
  final int selectedIndex;

  const CustomNavBar({
    Key? key,
    required this.onItemSelected,
    required this.selectedIndex,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ClipRect(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 2.0, sigmaY: 2.0),
            child: Container(
              height: 55,
              width: MediaQuery.of(context).size.width,
              color: Colors.transparent,
            ),
          ),
        ),
        Container(
          height: 75.0,
          width: MediaQuery.of(context).size.width,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/navbar.png'),
              fit: BoxFit.fill,
            ),
          ),
          child: Column(
            children: [
              const SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildNavBarItem(0, 'assets/icons/home.png'),
                  _buildNavBarItem(1, 'assets/icons/search.png'),
                  _buildNavBarItem(2, 'assets/icons/add.png', isLarge: true),
                  _buildNavBarItem(3, 'assets/icons/chatdoted.png'),
                  _buildNavBarItem(4, 'assets/icons/person.png'),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildNavBarItem(int index, String assetPath, {bool isLarge = false}) {
    return GestureDetector(
      onTap: () => onItemSelected(index),
      child: Image.asset(
        assetPath,
        width: isLarge ? 50 : 24,
        height: isLarge ? 50 : 24,
        color: !isLarge
            ? selectedIndex == index
                ? Colors.white
                : const Color(0xFF8388A4)
            : null,
      ),
    );
  }
}
