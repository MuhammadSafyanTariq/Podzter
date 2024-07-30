import 'package:flutter/material.dart';

class FollowButton extends StatelessWidget {
  final Function()? function;
  final Color backgroundColor;
  final Color borderColor;
  final Widget icon;
  final String text;
  final Color textColor;
  const FollowButton({
    super.key,
    this.function,
    required this.backgroundColor,
    required this.borderColor,
    required this.text,
    required this.textColor,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.only(top: 2),
        child: TextButton(
          onPressed: function,
          child: Container(
            decoration: BoxDecoration(
              color: backgroundColor,
              border: Border.all(color: borderColor),
              borderRadius: BorderRadius.circular(30),
            ),
            alignment: Alignment.center,
            // width: MediaQuery.of(context).size.width * 0.3,
            height: 45,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                icon,
                SizedBox(
                  width: 10,
                ),
                Text(
                  text,
                  style: TextStyle(color: textColor, fontSize: 16
                      // fontWeight: FontWeight.bold,
                      ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
