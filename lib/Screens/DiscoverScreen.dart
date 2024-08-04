import 'package:flutter/material.dart';

import 'package:learn_py/Objects/GuideSheet.dart';
import '../Objects/GeminiAI.dart';
import '../Objects/News.dart';
import '../Objects/GenericButton.dart';
import '../ThemeData.dart';
import '../main.dart';

class DiscoverScreen extends StatefulWidget {
  const DiscoverScreen({super.key});

  @override
  State<DiscoverScreen> createState() => _DiscoverScreenState();
}

class _DiscoverScreenState extends State<DiscoverScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFECFFF0),
      body: Stack(
        children: [
          SafeArea(
            child: Column(
              children: [
                Expanded(
                  flex: 2,
                  // child: Placeholder(),
                  child: Column(
                    children: [
                      const SizedBox(height: 10),
                      const Text(
                        'Discover Python',
                        style: TextStyle(
                            color: Color(0xFF3C3C3C),
                            fontSize: 20,
                            fontWeight: FontWeight.w500),
                      ), // DISCOVER TEXT
                      Expanded(
                        child: Container(
                          margin: const EdgeInsets.all(10),
                          // height: 300,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: const [
                              BoxShadow(
                                color: Color(0xFFBDCEC1),
                                blurRadius: 5,
                                spreadRadius: 2,
                                offset: Offset(0, 2),
                              ),
                            ],
                            border: Border.all(
                              color: const Color(0xFF00B71D),
                              width: 2,
                            ),
                          ),
                          child: const Center(
                            child: GeminiAI(
                                prompt:
                                    'Why should I learn python? give me a simple reason. Also tell me why python is popular. Give me some idea about future of Python. What jobs can I get with Python knowledge? Whats new about Python?'),
                          ),
                        ),
                      ), // AI MESSAGE
                    ],
                  ),
                ), // DISCOVERY BOX
                const SizedBox(height: 10),
                const Text(
                  'What\'s new...',
                  style: TextStyle(
                    color: Color(0xFF3C3C3C),
                    fontWeight: FontWeight.w500,
                    fontSize: 20,
                  ),
                ), // TITLE ABOVE NEW LIST
                Expanded(
                  flex: 3,
                  // child: Placeholder(),
                  child: SizedBox(
                    width: double.infinity,
                    // child: Placeholder(),
                    child: Stack(
                      children: [
                        const NewsScreen(),
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
                        )), // FADING EFFECT
                      ],
                    ),
                  ),
                ), // NEWS
              ],
            ),
          ), // MAIN SCREEN ELEMENTS
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
          ), // BACK BUTTON
          GuideSheet(currentScreen: 'DiscoveryScreen'),
        ],
      ),
    );
  }
}
