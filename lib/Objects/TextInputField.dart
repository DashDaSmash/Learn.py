import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';

class TextInputField extends StatefulWidget {
  final String label;
  final bool isPassword;
  final TextEditingController controller;
  // final Color defaultBorderColor;
  // final Color selectedBorderColor;

  TextInputField({
    required this.label,
    required this.isPassword,
    required this.controller,
    // required this.defaultBorderColor,
    // required this.selectedBorderColor,
  });

  @override
  State<TextInputField> createState() => _TextInputFieldState();
}

class _TextInputFieldState extends State<TextInputField> {
  Color currentBorderColor = Colors.green; // Initialize with green
  bool error = false;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
        obscureText: widget.isPassword,
        controller: widget.controller,
        textAlign: TextAlign.center,
        textAlignVertical: TextAlignVertical.center,
        decoration: InputDecoration(
          labelText: widget.label,
          alignLabelWithHint: true,
          filled: true,
          fillColor: Colors.white,
          labelStyle: TextStyle(
            color: Color(0xFF3C3C3C), // Set your desired color here
            fontSize: 18.0, // Optional: adjust font size
            fontWeight: FontWeight.w400, // Optional: adjust font weight
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: error ? Color(0xFFFF0000) : Color(0xFFD9D9D9),
              width: 3.0, // Adjust the border thickness here
            ),
            borderRadius: BorderRadius.circular(15),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide(
                width: 2, color: error ? Color(0xFFFF0000) : Color(0xFFD9D9D9)),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
                width: 2, color: error ? Color(0xFFFF0000) : Color(0xFF00B71D)),
            borderRadius: BorderRadius.circular(15.0),
          ),
        ),
        validator: (value) {
          if (value!.isEmpty && widget.label == 'Email') {
            return 'Please enter an email address';
          } else if (!EmailValidator.validate(value) &&
              widget.label == 'Email') {
            setState(() {
              error = true;
              //borderColor = Colors.red; // Set border color to red
            });
            return 'Enter a valid email address';
          } else {
            setState(() {
              error = false;
              //borderColor = Colors.green; // Set border color to green
            });
            return null;
          }
        });
  }

  // To change to red (e.g., on button press):
  void changeBorderColorToRed() {
    setState(() {
      currentBorderColor = Colors.red;
    });
  }
}
