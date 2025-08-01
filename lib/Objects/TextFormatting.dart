// THIS CLASS ALLOWS A TEXT WITH FORMATTING SYMBOLS TO BE FORMATTED AS INTENDED

import 'package:flutter/material.dart';

class TextFormatting extends StatelessWidget {
  final String textWithFormattingSymbols;
  final Color boldTextColor = const Color(0xFF3C3C3C);
  final Color genericTextColor = Colors.black;
  final Color headerTextColor = const Color(0xFF00FF29);
  final Color secondaryTextColor = const Color(0xFF008615);

  const TextFormatting({super.key, required this.textWithFormattingSymbols});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: parseAndFormatText(textWithFormattingSymbols),
        ),
      ),
    );
  }

  List<Widget> parseAndFormatText(String text) {
    final List<Widget> formattedWidgets = [];
    final List<String> lines = text.split('\n');

    for (String line in lines) {
      // APPLY FORMATTING LINE BY LINE
      final formattedLine = applyFormatting(line);
      formattedWidgets.add(formattedLine);
    }

    // THE BELOW CODE IS THE FINAL OUTPUT - RICH TEXT
    return formattedWidgets;
  }

  Widget applyFormatting(String line) {
    final List<TextSpan> spans = [];

    while (line.isNotEmpty) {
      // THE FOLLOWING CODE WILL APPLY FORMATTING BY IDENTIFYING FORMATTING SYMBOLS
      if (line.startsWith('**')) {
        final boldEnd = line.indexOf('**', 2);
        if (boldEnd != -1) {
          spans.add(TextSpan(
            text: line.substring(2, boldEnd),
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
                color: boldTextColor),
          ));
          line = line.substring(boldEnd + 2);
        } else {
          spans.add(TextSpan(
              text: line,
              style: TextStyle(fontSize: 18, color: secondaryTextColor)));
          line = '';
        }
      } else if (line.startsWith('*')) {
        final italicEnd = line.indexOf('*', 1);
        if (italicEnd != -1) {
          spans.add(TextSpan(
            text: line.substring(1, italicEnd),
            style: TextStyle(
                fontStyle: FontStyle.italic,
                fontSize: 18,
                color: genericTextColor),
          ));
          line = line.substring(italicEnd + 1);
        } else {
          spans.add(TextSpan(
              text: line,
              style: TextStyle(fontSize: 18, color: secondaryTextColor)));
          line = '';
        }
      } else if (line.startsWith('`')) {
        final codeEnd = line.indexOf('`', 1);
        if (codeEnd != -1) {
          spans.add(TextSpan(
            text: line.substring(1, codeEnd),
            style: TextStyle(
                fontFamily: 'Courier New',
                fontSize: 18,
                color: genericTextColor),
          ));
          line = line.substring(codeEnd + 1);
        } else {
          spans.add(TextSpan(
              text: line,
              style: TextStyle(fontSize: 18, color: secondaryTextColor)));
          line = '';
        }
      } else if (line.startsWith('~~')) {
        final strikethroughEnd = line.indexOf('~~', 2);
        if (strikethroughEnd != -1) {
          spans.add(TextSpan(
            text: line.substring(2, strikethroughEnd),
            style: TextStyle(
                decoration: TextDecoration.lineThrough,
                fontSize: 18,
                color: genericTextColor),
          ));
          line = line.substring(strikethroughEnd + 2);
        } else {
          spans.add(TextSpan(
              text: line,
              style: TextStyle(fontSize: 18, color: secondaryTextColor)));
          line = '';
        }
      } else if (line.startsWith('#')) {
        spans.add(TextSpan(
          text: line.substring(1).trim(),
          style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,
              color: headerTextColor),
        ));
        line = '';
      } else if (line.contains("'''")) {
        final blockQuoteStart = line.indexOf("'''");
        final blockQuoteEnd = line.indexOf("'''", blockQuoteStart + 3);
        if (blockQuoteEnd != -1) {
          spans.add(TextSpan(
            text: line.substring(blockQuoteStart + 3, blockQuoteEnd),
            style: const TextStyle(
              fontSize: 18,
              fontStyle: FontStyle.italic,
              color: Colors.blue,
            ),
          ));
          line = line.substring(blockQuoteEnd + 3);
        } else {
          spans.add(TextSpan(
              text: line,
              style: TextStyle(fontSize: 18, color: secondaryTextColor)));
          line = '';
        }
      } else {
        spans.add(TextSpan(
            text: line,
            style: TextStyle(fontSize: 18, color: genericTextColor)));
        line = '';
      }
    }

    return RichText(text: TextSpan(children: spans));
  }
}
