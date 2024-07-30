

import 'package:flutter/material.dart';

class SocialIconsRow extends StatelessWidget {
  const SocialIconsRow({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: () {
            print('Spotify icon tapped');
          },
          child: Image.asset(
            'assets/spotify.png',
            width: 28,
            height: 28,
          ),
        ),
        const SizedBox(
          width: 15,
        ),
        GestureDetector(
          onTap: () {
            print('Podcast icon tapped');
          },
          child: Image.asset(
            'assets/man.png',
            width: 28,
            height: 28,
          ),
        ),
        const SizedBox(
          width: 15,
        ),
        GestureDetector(
          onTap: () {
            print('YouTube icon tapped');
          },
          child: Image.asset(
            'assets/youtube.png',
            width: 28,
            height: 28,
          ),
        ),
        const SizedBox(
          width: 15,
        ),
        GestureDetector(
          onTap: () {
            print('Web icon tapped');
          },
          child: Image.asset(
            'assets/web.png',
            width: 28,
            height: 28,
          ),
        ),
      ],
    );
  }
}
