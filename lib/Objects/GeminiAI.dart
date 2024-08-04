// ignore_for_file: file_names, library_private_types_in_public_api

import 'package:flutter/material.dart';

import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import 'TextFormatting.dart';

class GeminiAI extends StatefulWidget {
  final String prompt;
  final String apiKey = 'AIzaSyBdIuWbpG5tVOpuS3V4I4DQMKM15zDZ71Y';

  const GeminiAI({super.key, required this.prompt});

  @override
  _GeminiAIState createState() => _GeminiAIState();
}

class _GeminiAIState extends State<GeminiAI> {
  String _response = '';
  String completeResponse = '';

  Future<void> _getGeminiResponse(String prompt) async {
    // SETTING UP GEMINI AI REQUEST
    final model = GenerativeModel(
      model: 'gemini-1.5-flash',
      apiKey: widget.apiKey,
    );

    try {
      // SENDING PROMPT AND TAKING THE OUTPUT
      final response = await model.generateContent([
        Content.text(prompt),
      ]);

      setState(() {
        _response = response.text!;
        completeResponse += _response;
      });
    } catch (e) {
      setState(() {
        _response = 'Network error: $e';
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _getGeminiResponse(widget.prompt);
  }

  @override
  Widget build(BuildContext context) {
    // THE FOLLOWING INSTANCE IS TO MAKE THE PLAIN TEXT BE FORMATTED WITH THE INTENDED WAY BY ANALYSING ESCAPE CHARACTERS
    Widget formattedResponse =
        TextFormatting(textWithFormattingSymbols: completeResponse);

    return completeResponse == ''
        // SHOW LOADING ICON UNTIL WHOLE RESPONSE IS READY
        ? LoadingAnimationWidget.threeRotatingDots(
            // ignore: prefer_const_constructors
            color: Color(0xFF80FE94), // Set your desired color
            size: 30.0, // Set the size of the animation
          )
        // ONCE DATA STREAM IS COMPLETE, WE SHOW THE RESPONSE
        : SingleChildScrollView(child: formattedResponse);
  }
}
