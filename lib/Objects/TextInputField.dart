import 'package:flutter/material.dart';

import 'package:email_validator/email_validator.dart';

class TextInputField extends StatefulWidget {
  final String label;
  final bool isPassword;
  final TextEditingController controller;

  const TextInputField({super.key,
    required this.label,
    required this.isPassword,
    required this.controller,
  });

  @override
  State<TextInputField> createState() => _TextInputFieldState();
}

class _TextInputFieldState extends State<TextInputField> {
  Color currentBorderColor = Colors.green; // STARTS OFF AS GREEN

  // STATE VARIABLE
  bool error = false;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: widget.isPassword, // CHECKS IF ITS A PASSWORD
      controller: widget.controller,
      textAlign: TextAlign.center,
      textAlignVertical: TextAlignVertical.center,
      decoration: InputDecoration(
        labelText: widget.label,
        alignLabelWithHint: true,
        filled: true,
        fillColor: Colors.white,
        labelStyle: const TextStyle(
          color: Color(0xFF3C3C3C),
          fontSize: 18.0,
          fontWeight: FontWeight.w400,
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: error ? const Color(0xFFFF0000) : const Color(0xFFD9D9D9),
            width: 3.0, // Adjust the border thickness here
          ),
          borderRadius: BorderRadius.circular(15),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(
              width: 2, color: error ? const Color(0xFFFF0000) : const Color(0xFFD9D9D9)),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
              width: 2, color: error ? const Color(0xFFFF0000) : const Color(0xFF00B71D)),
          borderRadius: BorderRadius.circular(15.0),
        ),
      ),
      validator: (value) {
        if (value!.isEmpty && widget.label == 'Email') {
          // IF THE EMAIL FIELD IS EMPTY, DON'T SHOW AN ERROR
          error = false;
          return null;
        } else if (!EmailValidator.validate(value) && widget.label == 'Email') {
          // CAUGHT AN ERROR....
          setState(() {
            error = true;
          });
          return 'Enter a valid email address';
        } else {
          // ERROR IS FIXED - CORRECT EMAIL FORMAT
          setState(() {
            error = false;
          });
          return null;
        }
      },
    );
  }
}
