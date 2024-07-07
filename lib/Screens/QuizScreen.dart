import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:learn_py/Objects/GenericButton.dart';
import 'package:learn_py/Objects/QuizQuestion.dart';

class QuizScreen extends StatefulWidget {
  final int quizId;
  List? question1;
  List? options;

  QuizScreen({required this.quizId});

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  int questionId = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text('Quiz ${widget.quizId}'),
            QuizQuestion(quizId: widget.quizId, questionId: questionId),
            GenericButton(
                label: 'Next',
                function: () {
                  questionId++;
                  setState(() {});
                },
                labelTextColor: Colors.white,
                backgroundColor: Colors.black,
                strokeColor: Colors.purpleAccent)
          ],
        ),
      ),
    );
  }
}
