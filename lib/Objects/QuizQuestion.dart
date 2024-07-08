import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'GenericButton.dart';
import 'AnswerCheckSlideUpPanel.dart';

class QuizQuestion extends StatefulWidget {
  final int quizId;
  final int questionId;
  List<String> questionDetails = []; // Initialize as an empty list

  QuizQuestion({required this.quizId, required this.questionId});

  @override
  State<QuizQuestion> createState() => _QuizQuestionState();
}

class _QuizQuestionState extends State<QuizQuestion> {
  String selectedAnswer = '';

  void _checkAnswer() {
    if (selectedAnswer == widget.questionDetails[1]) {
      print('answer is correct');
      AnswerCheckSlideUpPanel();
    } else {
      print('answer is wrong');
    }
  }

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
          return Container(
              height: 100,
              width: 100,
              child: CircularProgressIndicator()); // Show a loading indicator
        }

        widget.questionDetails = [
          snapshot.data!['question${widget.questionId}'],
          snapshot.data!['question${widget.questionId}answer'],
          for (int i = 1;
              i <= snapshot.data!['question${widget.questionId}optionCount'];
              i++)
            snapshot.data!['question${widget.questionId}option$i'] as String,
        ];

        print(widget.questionDetails);

        return Column(
          children: [
            Text(widget.questionDetails[0]),
            for (int i = 2;
                i <=
                    snapshot.data!['question${widget.questionId}optionCount'] +
                        1;
                i++)
              GenericButton(
                  label: widget.questionDetails[i],
                  function: () {
                    print(
                        'user selected option${i - 1} which is ${widget.questionDetails[i]}');
                    selectedAnswer = 'option${i - 1}';
                    _checkAnswer();
                  },
                  labelTextColor: Colors.white,
                  backgroundColor: Colors.black,
                  strokeColor: Colors.pink),

            // Display question text
            // Create widgets for displaying options (e.g., Text)
          ],
        );
      },
    );
  }
}
