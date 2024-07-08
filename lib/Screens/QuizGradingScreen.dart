import 'package:flutter/material.dart';

class QuizGradingScreeen extends StatefulWidget {
  final int score;

  QuizGradingScreeen({required this.score});

  @override
  State<QuizGradingScreeen> createState() => _QuizGradingScreeenState();
}

class _QuizGradingScreeenState extends State<QuizGradingScreeen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          //TODO: make sure to make the counting go up
          child: Text('${widget.score}')),
    );
  }
}
