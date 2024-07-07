import 'package:flutter/material.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'TextFormatting.dart';

class GeminiAI extends StatefulWidget {
  final String prompt;
  final String apiKey = 'AIzaSyBdIuWbpG5tVOpuS3V4I4DQMKM15zDZ71Y';

  GeminiAI({required this.prompt});

  @override
  _GeminiAIState createState() => _GeminiAIState();
}

class _GeminiAIState extends State<GeminiAI> {
  String _response = '';
  String completeResponse = '';

  Future<void> _getGeminiResponse(String prompt) async {
    final model = GenerativeModel(
      model: 'gemini-1.5-flash', // Use the correct model name
      apiKey: widget.apiKey,
    );

    try {
      final response = await model.generateContent([
        Content.text(prompt),
      ]);

      print('***********************');
      setState(() {
        _response = response.text!;
        completeResponse += _response;
      });
    } catch (e) {
      print('********************Error: $e');
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
    print(completeResponse);
    Widget FormattedResponse =
        TextFormatting(textWithFormattingSymbols: completeResponse);
    return FormattedResponse;
  }
}
