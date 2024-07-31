import 'package:flutter/material.dart';
import '../ThemeData.dart';
import '../main.dart';

class GenericButton extends StatelessWidget {
  final VoidCallback function;
  final String label;
  final Icon? icon;
  final String? image;
  final GenericButtonType type; //generic, proceed, warning
  final int? height;
  final int? width;

  GenericButton(
      {required this.label,
      required this.function,
      this.icon,
      this.image,
      required this.type,
      this.height,
      this.width});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: function,
      style: ElevatedButton.styleFrom(
        elevation: 20,
        shadowColor: Colors.black.withOpacity(0.5),
        fixedSize: Size(
          width?.toDouble() ?? double.infinity,
          height?.toDouble() ?? 30.0,
        ),
        overlayColor: Color(0xFFB4FFC0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
          side: BorderSide(
            width: 2,
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
          if (icon != null) icon!,
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
