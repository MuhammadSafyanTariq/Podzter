import 'package:flutter/material.dart';

class TextInputFeilds extends StatelessWidget {
  final TextEditingController textEditingController;
  final bool isPass;
  final String hintText;
  final TextInputType textInputType;

  const TextInputFeilds({
    Key? key,
    required this.textEditingController,
    this.isPass = false,
    required this.hintText,
    required this.textInputType,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final enabledBorder = OutlineInputBorder(
        borderSide: BorderSide(color: Colors.white),
        borderRadius: BorderRadius.circular(10));
    final focusedBorder = OutlineInputBorder(
        borderSide: BorderSide(color: Colors.blue),
        borderRadius: BorderRadius.circular(10));
    return TextField(
      controller: textEditingController,
      decoration: InputDecoration(
        fillColor: Colors.transparent,
        hintText: hintText,
        hintStyle: TextStyle(
            color: Colors.white70, fontWeight: FontWeight.w400, fontSize: 14),
        border: enabledBorder,
        enabledBorder: enabledBorder,
        focusedBorder: focusedBorder,
        filled: true,
        contentPadding: const EdgeInsets.symmetric(
            vertical: 18, horizontal: 10), // Increase height
      ),
      keyboardType: textInputType,
      obscureText: isPass,
    );
  }
}
