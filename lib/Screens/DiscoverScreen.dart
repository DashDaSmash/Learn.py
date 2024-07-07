import 'package:flutter/material.dart';
import '../Objects/GeminiAI.dart';
import '../Objects/News.dart';

class DiscoverScreen extends StatefulWidget {
  const DiscoverScreen({super.key});

  @override
  State<DiscoverScreen> createState() => _DiscoverScreenState();
}

class _DiscoverScreenState extends State<DiscoverScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 300,
              width: double.infinity,
              color: Colors.blue,
              child: SingleChildScrollView(
                child: GeminiAI(
                  // prompt:
                  //     'Give me one example each for every special formatting symbols you use when sending a response text',
                  prompt: 'Give me a tip about Python language',
                ),
              ),
            ),
            Container(
              height: 400,
              width: double.infinity,
              color: Colors.red,
              child: NewsScreen(),
            ),
          ],
        ),
      ),
    );
  }
}
