import 'package:flutter/material.dart';
import 'package:insta_clone/utils/colors.dart';

class TextInputFields extends StatefulWidget {
  final TextEditingController textEditingController;
  final bool isPass;
  final String hintText;
  final TextInputType textInputType;
  final bool isGenderField;

  const TextInputFields({
    Key? key,
    required this.textEditingController,
    this.isPass = false,
    required this.hintText,
    required this.textInputType,
    this.isGenderField = false,
  }) : super(key: key);

  @override
  _TextInputFieldsState createState() => _TextInputFieldsState();
}

class _TextInputFieldsState extends State<TextInputFields> {
  bool _isPasswordVisible = false;
  String? _selectedGender;

  @override
  Widget build(BuildContext context) {
    final enabledBorder = OutlineInputBorder(
      borderSide: BorderSide(color: Colors.white.withOpacity(.25)),
      borderRadius: BorderRadius.circular(30),
    );
    final focusedBorder = OutlineInputBorder(
      borderSide: BorderSide(color: appColor),
      borderRadius: BorderRadius.circular(30),
    );

    return widget.isGenderField
        ? DropdownButtonFormField<String>(
            value: _selectedGender,
            decoration: InputDecoration(
              fillColor: const Color.fromRGBO(0, 0, 0, 0.25),
              filled: true,
              border: enabledBorder,
              enabledBorder: enabledBorder,
              focusedBorder: focusedBorder,
              contentPadding: const EdgeInsets.symmetric(
                vertical: 20,
                horizontal: 25,
              ), // Increase height
            ),
            hint: Text(
              widget.hintText,
              style: const TextStyle(
                color: Colors.white70,
                fontWeight: FontWeight.w400,
                fontSize: 14,
              ),
            ),
            icon: const Icon(
              Icons.keyboard_arrow_down_outlined,
              color: Colors.white70,
            ),
            dropdownColor: Colors.black,
            items: <String>['Male', 'Female', 'Other'].map((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(
                  value,
                  style: const TextStyle(color: Colors.white),
                ),
              );
            }).toList(),
            onChanged: (String? newValue) {
              setState(() {
                _selectedGender = newValue;
                widget.textEditingController.text = newValue ?? '';
              });
            },
          )
        : TextField(
            controller: widget.textEditingController,
            decoration: InputDecoration(
              fillColor: const Color.fromRGBO(0, 0, 0, 0.25),
              hintText: widget.hintText,
              hintStyle: const TextStyle(
                color: Colors.white70,
                fontWeight: FontWeight.w400,
                fontSize: 14,
              ),
              border: enabledBorder,
              enabledBorder: enabledBorder,
              focusedBorder: focusedBorder,
              filled: true,
              contentPadding: const EdgeInsets.symmetric(
                vertical: 20,
                horizontal: 25,
              ), // Increase height
              suffixIcon: widget.isPass
                  ? Padding(
                      padding: const EdgeInsets.only(right: 10.0),
                      child: IconButton(
                        icon: Icon(
                          _isPasswordVisible
                              ? Icons.visibility
                              : Icons.visibility_off,
                          color: const Color(0xFF85808E),
                        ),
                        onPressed: () {
                          setState(() {
                            _isPasswordVisible = !_isPasswordVisible;
                          });
                        },
                      ),
                    )
                  : null,
            ),
            keyboardType: widget.textInputType,
            obscureText: widget.isPass ? !_isPasswordVisible : false,
          );
  }
}
