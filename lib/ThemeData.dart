import 'dart:ui';
import 'package:flutter/material.dart';

class themeData {
  Color backgroundColor = const Color(0xFFECFFF0);

  TextStyle genericTextStyle = const TextStyle(
    fontWeight: FontWeight.normal,
    fontSize: 16,
  );

  TextStyle genericBigTextStyle = const TextStyle(
    fontWeight: FontWeight.bold,
    fontSize: 20,
  );

  TextStyle guideScreenBigTextStyle = const TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 30,
      color: Colors.white,
      shadows: [
        Shadow(
          color: Colors.grey,
          offset: Offset(2, 2),
          blurRadius: 10,
        ),
      ]);

  TextStyle guideScreenSmallTextStyle = const TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 20,
      color: Colors.white,
      shadows: [
        Shadow(
          color: Colors.grey,
          offset: Offset(2, 2),
          blurRadius: 10,
        ),
      ]);

  TextStyle boldDigit = const TextStyle(
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

  TextStyle BMSHeaderTextStyle = const TextStyle(
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

  TextStyle quizQuestionTextStyle = const TextStyle(
    fontWeight: FontWeight.w700,
    fontSize: 20,
    color: Colors.black54,
  );

  TextStyle gradingScreenScoreTextStyle = const TextStyle(
    fontWeight: FontWeight.w700,
    fontSize: 100,
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
  );

  TextStyle gradingScreenMessageTextStyle = const TextStyle(
    fontWeight: FontWeight.w700,
    fontSize: 100,
    color: Colors.white,
    shadows: [
      Shadow(
        color: Color(0xFF008615),
        offset: Offset(2, 2),
        blurRadius: 2,
      ),
    ],
  );

  //for buttons that do no give a hint
  Color genericButtonLabelTextColor = Colors.black;
  Color genericButtonBackgroundColor = Colors.white;
  Color genericButtonBorderColor = Colors.black;

  //for buttons that i want user to click on
  Color proceedButtonLabelTextColor = const Color(0xFF3C3C3C);
  Color proceedButtonBackgroundColor = const Color(0xFF80FE94);
  Color proceedButtonBorderColor = const Color(0xFF14AE5C);

  //for buttons that i want user to click on - secondary
  Color semiProceedButtonLabelTextColor = const Color(0xFF00CE2D);
  Color semiProceedButtonBackgroundColor = Colors.white;
  Color semiProceedButtonBorderColor = Colors.black;

  //for buttons that i warn user before click
  Color warningButtonLabelTextColor = const Color(0xFF000000);
  Color warningButtonBackgroundColor = const Color(0xFFFFD0D0);
  Color warningButtonBorderColor = const Color(0xFFFF0000);

  //for buttons that i warn user before click - secondary
  Color semiWarningButtonLabelTextColor = const Color(0xFFFF0000);
  Color semiWarningButtonBackgroundColor = Colors.white;
  Color semiWarningButtonBorderColor = Colors.black;
}
