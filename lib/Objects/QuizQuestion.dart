import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:learn_py/Screens/LoginScreen.dart';
import 'GenericButton.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import '../Screens/QuizScreen.dart';

// ignore: must_be_immutable
class QuizQuestion extends StatefulWidget {
  final Controller myController;
  final int quizId;
  final int questionId;
  List<String> questionDetails = []; // Initialize as an empty list

  QuizQuestion({
    required this.quizId,
    required this.questionId,
    required this.myController,
  });

  @override
  State<QuizQuestion> createState() => _QuizQuestionState();
}

class _QuizQuestionState extends State<QuizQuestion> {
  String selectedAnswer = '';
  int? questionCount;

  void _checkAnswer() {
    if (selectedAnswer == widget.questionDetails[1]) {
      print('answer is correct');
      _showBottomSheet(
        context,
        true,
      );

      // AnswerCheckBottomSheet(
      //     isCorrect: true, myController: widget.myController);
      // widget.myController.nextQuestion();
    } else {
      print('answer is wrong');
      _showBottomSheet(
        context,
        false,
      );
      // AnswerCheckBottomSheet(
      //     isCorrect: false, myController: widget.myController);
      // widget.myController.nextQuestion();
    }
  }

  void _showBottomSheet(BuildContext context, bool isAnswerCorrect) {
    showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) {
        if (isAnswerCorrect == true) {
          return Container(
            height: MediaQuery.of(context).size.height * 0.5,
            width: MediaQuery.of(context).size.width,
            child: Column(
              children: [
                Expanded(child: Center(child: Text('Awesome!'))),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text('Hello, this is your bottom sheet!'),
                      GenericButton(
                        label: 'Next',
                        function: () {
                          Navigator.of(context).pop();
                          widget.myController
                              .nextQuestion(questionCount, context, true);
                        },
                        type: GenericButtonType.generic,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        } else {
          return Container(
            height: MediaQuery.of(context).size.height * 0.5,
            width: MediaQuery.of(context).size.width,
            child: Column(
              children: [
                Expanded(child: Center(child: Text('Oops!'))),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text('Hello, this is your bottom sheet!'),
                      GenericButton(
                        label: 'Next',
                        function: () {
                          Navigator.of(context).pop();
                          widget.myController
                              .nextQuestion(questionCount, context, false);
                        },
                        type: GenericButtonType.semiWarning,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        }
      },
    );
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
              child: LoadingAnimationWidget.threeRotatingDots(
                color: Color(0xFF80FE94), // Set your desired color
                size: 30.0, // Set the size of the animation
              )); // Show a loading indicator
        }

        questionCount = snapshot.data!['questionCount'];
        widget.myController.setTotalQuestionCount(questionCount);

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
                type: GenericButtonType.semiProceed,
              ),

            // Display question text
            // Create widgets for displaying options (e.g., Text)
          ],
        );
      },
    );
  }
}
