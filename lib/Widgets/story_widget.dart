import 'package:flutter/material.dart';
import 'package:insta_clone/utils/colors.dart';

class StoryWidget extends StatelessWidget {
  final String image;
  final String name;
  const StoryWidget({super.key, required this.image, required this.name});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 70,
          width: 70,
          margin: EdgeInsets.symmetric(horizontal: 10),
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: appColor, width: 3)),
          child: CircleAvatar(
            // radius: 30,
            backgroundImage: NetworkImage(image),
            // child: Image.asset(
            //   im,
            //   fit: BoxFit.fill,
            //   // height: 80,
            //   // width: 80,
            // ),
          ),
        ),
        SizedBox(
          height: 5,
        ),
        Text(
          name,
          style: TextStyle(fontWeight: FontWeight.w500),
        )
      ],
    );
  }
}
