import 'package:flutter/material.dart';

class GenericButton extends StatelessWidget {
  final VoidCallback function;
  final String label;
  final Color labelTextColor;
  final Color backgroundColor;
  final Color strokeColor;
  final IconData? icon;
  final String? image;

  GenericButton({
    required this.label,
    required this.function,
    required this.labelTextColor,
    required this.backgroundColor,
    required this.strokeColor,
    this.icon,
    this.image,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: function,
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
          side: BorderSide(color: strokeColor),
        ),
        backgroundColor: backgroundColor,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (icon != null) Icon(icon),
          if (image != null)
            Image.asset(
              image!,
              height: 25,
              width: 25,
            ),
          if (image != null || icon != null) SizedBox(width: 30),
          Text(
            label,
            style: TextStyle(color: labelTextColor, fontSize: 17),
          ),
        ],
      ),
    );
  }
}
