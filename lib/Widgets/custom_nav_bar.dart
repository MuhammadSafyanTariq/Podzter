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
            ),
          ),
        ),
        Container(
          height: 75.0,
          width: MediaQuery.of(context).size.width,
          decoration: const BoxDecoration(
            color: Colors.transparent,
            image: DecorationImage(
              image: AssetImage('assets/navbar.png'),
              fit: BoxFit.fill,
            ),
          ),
          child: Column(
            children: [
              SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () => onItemSelected(0),
                    child: Image.asset(
                      'assets/icons/home.png',
                      width: 24,
                      height: 24,
                      color:
                          selectedIndex == 0 ? Colors.white : Color(0xFF8388A4),
                    ),
                  ),
                  GestureDetector(
                    onTap: () => onItemSelected(1),
                    child: Image.asset(
                      'assets/icons/search.png',
                      width: 24,
                      height: 24,
                      color:
                          selectedIndex == 1 ? Colors.white : Color(0xFF8388A4),
                    ),
                  ),
                  GestureDetector(
                    onTap: () => onItemSelected(2),
                    child: Image.asset(
                      'assets/icons/add.png',
                      width: 50,
                      height: 50,
                      // color: selectedIndex == 2 ? Colors.white : Colors.white70,
                    ),
                  ),
                  GestureDetector(
                    onTap: () => onItemSelected(3),
                    child: Image.asset(
                      'assets/icons/chatdoted.png',
                      width: 24,
                      height: 24,
                      color:
                          selectedIndex == 3 ? Colors.white : Color(0xFF8388A4),
                    ),
                  ),
                  GestureDetector(
                    onTap: () => onItemSelected(4),
                    child: Image.asset(
                      'assets/icons/person.png',
                      width: 24,
                      height: 24,
                      color:
                          selectedIndex == 4 ? Colors.white : Color(0xFF8388A4),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
