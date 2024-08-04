import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import 'package:learn_py/ThemeData.dart';
import 'GenericButton.dart';
import '../main.dart';
import '../Screens/QuizScreen.dart';

// ignore: must_be_immutable
class QuizQuestion extends StatefulWidget {
  final Controller myController;
  final int quizId;
  final int questionId;
  List<String> questionDetails = [];

  QuizQuestion({
    super.key,
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
    // AFTER CHECKING ANSWER, BOTTOM SHEET IS SHOWN TO LET USER KNOW ABOUT THEIR ANSWER
    if (selectedAnswer == widget.questionDetails[1]) {
      _showBottomSheet(
        context,
        true,
      );
    } else {
      _showBottomSheet(
        context,
        false,
      );
    }
  }

  void _showBottomSheet(BuildContext context, bool isAnswerCorrect) {
    showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: MediaQuery.of(context).size.height * 0.3,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(20), topRight: Radius.circular(20)),
            gradient: LinearGradient(
              colors: isAnswerCorrect
                  ? [const Color(0xFF00FF29), Colors.white]
                  : [Colors.red, Colors.white],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: Column(
            children: [
              Expanded(
                child: Center(
                  child: Text(
                    isAnswerCorrect ? 'Awesome!' : 'Oh no...',
                    style: themeData().BMSHeaderTextStyle,
                  ),
                ),
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      isAnswerCorrect
                          ? 'That was the correct answer'
                          : 'You selected the wrong one :(',
                      style: themeData().genericTextStyle,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: GenericButton(
                          label: 'Next',
                          function: () {
                            Navigator.of(context).pop();
                            widget.myController.nextQuestion(
                                questionCount, context, isAnswerCorrect);
                          },
                          type: isAnswerCorrect
                              ? GenericButtonType.proceed
                              : GenericButtonType.semiWarning),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // ADD ZEROES TO LEFT SIDE TO MAKE THE NUMBER 3 DIGITS
    String formattedQuizId = widget.quizId.toString().padLeft(3, '0');
    return FutureBuilder<DocumentSnapshot>(
      future: FirebaseFirestore.instance
          .collection('quiz')
          .doc('quiz$formattedQuizId')
          .get(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        }
        if (!snapshot.hasData) {
          // IF DATA IS FOUND THEN SHOW LOADING ICON UNTIL ALL READY TO SHOW THE QUIZ QUESTION
          return SizedBox(
            height: 100,
            width: 100,
            child: LoadingAnimationWidget.threeRotatingDots(
              color: const Color(0xFF80FE94), // Set your desired color
              size: 30.0, // Set the size of the animation
            ),
          );
        }

        questionCount = snapshot.data!['questionCount'];

        // NOTIFY QUIZ SCREEN ABOUT NUMBER OF TOTAL QUESTIONS
        widget.myController.setTotalQuestionCount(questionCount);

        // SAVE QUESTION, ANSWER AND OPTIONS IN A LIST
        widget.questionDetails = [
          snapshot.data!['question${widget.questionId}'],
          snapshot.data!['question${widget.questionId}answer'],
          for (int i = 1;
              i <= snapshot.data!['question${widget.questionId}optionCount'];
              i++)
            snapshot.data!['question${widget.questionId}option$i'] as String,
        ];

        String Question = widget.questionDetails[0];

        //IN CASE QUESTION IS MANUALLY INSERTED TO DATABASE, FOLLOWING CODE FACILITATES NEW LINE BREAK
        String formattedQuestion = Question.replaceAll(r'\n', '\n');

        return Column(
          children: [
            Text(
              formattedQuestion,
              style: themeData().quizQuestionTextStyle,
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.1,
            ),
            for (int i = 2;
                i <=
                    snapshot.data!['question${widget.questionId}optionCount'] +
                        1;
                i++)
              GenericButton(
                label: widget.questionDetails[i],
                function: () {
                  selectedAnswer = 'option${i - 1}';
                  _checkAnswer();
                },
                type: GenericButtonType.semiProceed,
              ), // OPTIONS
          ],
        );
      },
    );
  }
}
