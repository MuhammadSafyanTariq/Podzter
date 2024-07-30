import 'package:flutter/material.dart';

class IconWidget extends StatelessWidget {
  final String assetPath;
  final double size;

  IconWidget({required this.assetPath, this.size = 16});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Image.asset(
        'assets/icons/$assetPath.png',
        // fit: BoxFit.fitHeight, // Adjust this to fit your needs
        height: size,
        width: size,
      ),
    );
  }
}
