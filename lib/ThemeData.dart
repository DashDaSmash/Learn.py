import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class themeData {
  Color backgroundColor = Color(0xFFECFFF0);

  TextStyle genericTextStyle = TextStyle(
    fontWeight: FontWeight.normal,
    fontSize: 16,
  );

  TextStyle genericBigTextStyle = TextStyle(
    fontWeight: FontWeight.bold,
    fontSize: 20,
  );

  TextStyle boldDigit = TextStyle(
      fontWeight: FontWeight.w700,
      fontSize: 40,
      color: Color(0xFF00FF29),
      shadows: [
        Shadow(
          color: Colors.black26,
          offset: Offset(2, 2),
          blurRadius: 1,
        ),
        Shadow(
          color: Colors.white,
          offset: Offset(-2, -2),
          blurRadius: 1,
        ),
      ]);

  TextStyle BMSHeaderTextStyle = TextStyle(
    fontWeight: FontWeight.w700,
    fontSize: 40,
    color: Colors.white,
    shadows: [
      Shadow(
        color: Colors.black38,
        offset: Offset(2, 2),
        blurRadius: 2,
      ),
      // Shadow(
      //   color: Colors.red,
      //   offset: Offset(-2, -2),
      //   blurRadius: 1,
      // ),
    ],
  ); //Bottom Modal Sheet

  TextStyle QuizQuestionTextStyle = TextStyle(
    fontWeight: FontWeight.w700,
    fontSize: 20,
    color: Colors.black54,
  );

  //for buttons that do no give a hint
  Color genericButtonLabelTextColor = Colors.black;
  Color genericButtonBackgroundColor = Colors.white;
  Color genericButtonBorderColor = Colors.black;

  //for buttons that i want user to click on
  Color proceedButtonLabelTextColor = Color(0xFF3C3C3C);
  Color proceedButtonBackgroundColor = Color(0xFF80FE94);
  Color proceedButtonBorderColor = Color(0xFF14AE5C);

  //for buttons that i want user to click on - secondary
  Color semiProceedButtonLabelTextColor = Color(0xFF00CE2D);
  Color semiProceedButtonBackgroundColor = Colors.white;
  Color semiProceedButtonBorderColor = Colors.black;

  //for buttons that i warn user before click
  Color warningButtonLabelTextColor = Color(0xFF000000);
  Color warningButtonBackgroundColor = Color(0xFFFFD0D0);
  Color warningButtonBorderColor = Color(0xFFFF0000);

  //for buttons that i warn user before click - secondary
  Color semiWarningButtonLabelTextColor = Color(0xFFFF0000);
  Color semiWarningButtonBackgroundColor = Colors.white;
  Color semiWarningButtonBorderColor = Colors.black;
}
