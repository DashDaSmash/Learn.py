import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import '../Objects/GeminiAI.dart';
import '../Objects/News.dart';
import '../Objects/GenericButton.dart';

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
          //TODO: add loading icons
          children: [
            Column(
              children: [
                Expanded(
                  flex: 2,
                  child: Container(
                    height: 300,
                    width: double.infinity,
                    color: Colors.blue,
                    child: SingleChildScrollView(
                      child: GeminiAI(
                        prompt: 'Give me a tip about Python language',
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Container(
                    height: 400,
                    width: double.infinity,
                    color: Colors.red,
                    child: NewsScreen(),
                  ),
                ),
              ],
            ),
            Positioned(
              //TODO: button customization
              bottom: 16, // Adjust the position as needed
              left: 16, // Adjust the position as needed
              right: 16, // Adjust the position as needed
              child: GenericButton(
                label: 'Back',
                function: () => Navigator.pop(context),
                labelTextColor: Colors.white,
                backgroundColor: Colors.green, // Set your desired color
                strokeColor: Colors.black, // Set your desired color
                icon: Icons.add, // Replace with your icon
              ),
            ),
          ],
        ),
      ),
    );
  }
}
