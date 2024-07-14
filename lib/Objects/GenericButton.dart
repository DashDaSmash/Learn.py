import 'package:flutter/material.dart';
import 'package:learn_py/Screens/LoginScreen.dart';
import '../ThemeData.dart';

class GenericButton extends StatelessWidget {
  final VoidCallback function;
  final String label;
  // final Color labelTextColor;
  // final Color backgroundColor;
  // final Color strokeColor;
  final IconData? icon;
  final String? image;
  final GenericButtonType type; //generic, proceed, warning

  GenericButton({
    required this.label,
    required this.function,
    // required this.labelTextColor,
    // required this.backgroundColor,
    // required this.strokeColor,
    this.icon,
    this.image,
    required this.type,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: function,
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
          side: BorderSide(
            color: type == GenericButtonType.proceed
                ? themeData().proceedButtonBorderColor
                : type == GenericButtonType.warning
                    ? themeData().warningButtonBorderColor
                    : type == GenericButtonType.semiProceed
                        ? themeData().semiProceedButtonBorderColor
                        : type == GenericButtonType.semiWarning
                            ? themeData().semiWarningButtonBorderColor
                            : themeData().genericButtonBorderColor,
          ),
        ),
        backgroundColor: type == GenericButtonType.proceed
            ? themeData().proceedButtonBackgroundColor
            : type == GenericButtonType.warning
                ? themeData().warningButtonBackgroundColor
                : type == GenericButtonType.semiProceed
                    ? themeData().semiProceedButtonBackgroundColor
                    : type == GenericButtonType.semiWarning
                        ? themeData().semiWarningButtonBackgroundColor
                        : themeData().genericButtonBackgroundColor,
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
            style: TextStyle(
                color: type == GenericButtonType.proceed
                    ? themeData().proceedButtonLabelTextColor
                    : type == GenericButtonType.warning
                        ? themeData().warningButtonLabelTextColor
                        : type == GenericButtonType.semiProceed
                            ? themeData().semiProceedButtonLabelTextColor
                            : type == GenericButtonType.semiWarning
                                ? themeData().semiWarningButtonLabelTextColor
                                : themeData().genericButtonLabelTextColor,
                fontSize: 17),
          ),
        ],
      ),
    );
  }
}
