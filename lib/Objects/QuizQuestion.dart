import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class QuizQuestion extends StatefulWidget {
  final int quizId;
  final int questionId;
  List<String> questionDetails = []; // Initialize as an empty list

  QuizQuestion({required this.quizId, required this.questionId});

  @override
  State<QuizQuestion> createState() => _QuizQuestionState();
}

class _QuizQuestionState extends State<QuizQuestion> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<DocumentSnapshot>(
      future: FirebaseFirestore.instance
          .collection('quiz')
          .doc('quiz${widget.quizId}')
          .get(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        }
        if (!snapshot.hasData) {
          return CircularProgressIndicator(); // Show a loading indicator
        }

        widget.questionDetails = [
          snapshot.data!['question${widget.questionId}'],
          snapshot.data!['question${widget.questionId}answer'],
          for (int i = 1;
              i <= snapshot.data!['question${widget.questionId}optionCount'];
              i++)
            snapshot.data!['question${widget.questionId}option$i'] as String,
        ];

        return Column(
          children: [
            Text(widget.questionDetails[2]), // Display question text
            // Create widgets for displaying options (e.g., Text)
          ],
        );
      },
    );
  }
}
