import 'package:flutter/material.dart';

class ProfilePictureWithEditIcon extends StatelessWidget {
  final String imageUrl;
  final VoidCallback onEdit;

  const ProfilePictureWithEditIcon({
    Key? key,
    required this.imageUrl,
    required this.onEdit,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CircleAvatar(
          backgroundColor: Colors.white,
          radius: 42.5,
          child: CircleAvatar(
            radius: 40, // Adjust the radius as needed
            backgroundImage: NetworkImage(imageUrl),
          ),
        ),
        Positioned(
          bottom: 0,
          right: 0,
          child: GestureDetector(
            onTap: onEdit,
            child: const CircleAvatar(
              radius: 17,
              backgroundColor: Colors.white,
              child: CircleAvatar(
                radius: 15, // Adjust the radius of the edit icon background
                backgroundColor:
                    Colors.blue, // Background color of the edit icon
                backgroundImage: AssetImage("assets/buttonbg.png"),
                child: Icon(
                  Icons.edit,
                  color: Colors.white,
                  size: 18, // Size of the edit icon
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
