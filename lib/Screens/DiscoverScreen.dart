import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:learn_py/Objects/GuideSheet.dart';
import '../Objects/GeminiAI.dart';
import '../Objects/News.dart';
import '../Objects/GenericButton.dart';
import 'package:flutter/services.dart';

import '../ThemeData.dart';
import '../main.dart';

class DiscoverScreen extends StatefulWidget {
  const DiscoverScreen({Key? key}) : super(key: key);

  @override
  State<DiscoverScreen> createState() => _DiscoverScreenState();
}

class _DiscoverScreenState extends State<DiscoverScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFECFFF0),
      body: SafeArea(
        child: Stack(
          children: [
            Column(
              children: [
                Expanded(
                  flex: 2,
                  // child: Placeholder(),
                  child: Column(
                    children: [
                      SizedBox(height: 10),
                      Text(
                        'Discover Python',
                        style: TextStyle(
                            color: Color(0xFF3C3C3C),
                            fontSize: 20,
                            fontWeight: FontWeight.w500),
                      ),
                      Expanded(
                        child: Container(
                          margin: EdgeInsets.all(10),
                          // height: 300,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                color: Color(0xFFBDCEC1),
                                blurRadius: 5,
                                spreadRadius: 2,
                                offset: Offset(0, 2),
                              ),
                            ],
                            border: Border.all(
                              color: Color(0xFF00B71D),
                              width: 2,
                            ),
                          ),
                          child: Center(
                            child: GeminiAI(
                                prompt:
                                    'Why should I learn python? give me a simple reason. Also tell me why python is popular. Give me some idea about future of Python. What jobs can I get with Python knowledge? Whats new about Python?'),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  'What\'s new...',
                  style: TextStyle(
                    color: Color(0xFF3C3C3C),
                    fontWeight: FontWeight.w500,
                    fontSize: 20,
                  ),
                ),
                Expanded(
                  flex: 3,
                  // child: Placeholder(),
                  child: Container(
                    width: double.infinity,
                    // child: Placeholder(),
                    child: Stack(
                      children: [
                        NewsScreen(),
                        Positioned(
                            child: Container(
                          width: double.infinity,
                          height: 50,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.bottomCenter,
                              end: Alignment.topCenter,
                              colors: [
                                themeData().backgroundColor.withOpacity(
                                    0), // Transparent at the bottom
                                themeData().backgroundColor, // Green at the top
                              ],
                            ),
                          ),
                        )),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Positioned(
              bottom: 8, // Adjust the position as needed
              left: 8, // Adjust the position as needed
              right: 8, // Adjust the position as needed
              child: //BackButton
                  //BackButton
                  GenericButton(
                label: 'Back',
                function: () => Navigator.pop(context),
                type: GenericButtonType.generic, // Set your desired color
              ),
            ),
            GuideSheet(currentScreen: 'DiscoveryScreen'),
          ],
        ),
      ),
    );
  }
}
