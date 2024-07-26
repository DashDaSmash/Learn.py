import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:learn_py/ThemeData.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:learn_py/Objects/GenericButton.dart';
import 'package:learn_py/Objects/QuizQuestion.dart';
import 'package:get/get.dart';

import '../main.dart';

//TODO: Remember that you cant use two quizes in same launch. fix it
class QuizScreen extends StatefulWidget {
  final questionController = Get.put(Controller());

  final int quizId;

  QuizScreen({required this.quizId});

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  RxInt questionId = 1.obs;
  RxInt questionsCompleted = 0.obs;
  RxInt questionsGotCorrect = 0.obs;
  RxInt totalQuestions = 1.obs;
  double? Progress;

  Widget ProgressBar() {
    if (widget.questionController.questionsCompleted == 0) {
      Progress = 0;
    } else {
      Progress = widget.questionController.questionsCompleted /
          widget.questionController.totalQuestions;
    }

    return new LinearPercentIndicator(
      width: MediaQuery.of(context).size.width - 50,
      animation: true,
      lineHeight: 10.0,
      animationDuration: 1000,
      percent: Progress!,
      // center: Text("90.0%"),
      linearStrokeCap: LinearStrokeCap.roundAll,
      progressColor: Color(0xFF80FE94),
    );
  }

  void _showBottomSheet(BuildContext context) {
    print('Bottom modal sheet coming right up....');
    showModalBottomSheet<void>(
        context: context,
        builder: (BuildContext context) {
          return Container(
            height: MediaQuery.of(context).size.height * 0.4,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.red,
                width: 1.0,
              ),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20.0),
                topRight: Radius.circular(20.0),
              ),
              gradient: LinearGradient(
                colors: [Color(0xFFFFD0D0), Colors.white],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Column(
              children: [
                Expanded(
                    child: Center(
                        child: Text(
                  'Are you leaving?',
                  style: themeData().BMSHeaderTextStyle,
                ))),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        'Reallyyyy?',
                        style: themeData().genericTextStyle,
                      ),
                      SizedBox(height: 20),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: GenericButton(
                          label: 'No',
                          function: () {
                            Navigator.of(context).pop();
                          },
                          type: GenericButtonType.semiProceed,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            bottom: 8.0, left: 8, right: 8),
                        child: GenericButton(
                          label: 'Yes',
                          function: () {
                            widget.questionController.resetQuizScreen();
                            Navigator.of(context).pop();
                            Navigator.of(context).pop();
                          },
                          type: GenericButtonType.warning,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        });
  }

  void checkQuestionCount() async {
    String formattedQuizId = widget.quizId.toString().padLeft(3, '0');

    final userDetails = FirebaseFirestore.instance
        .collection('quiz')
        .doc('quiz$formattedQuizId');
    final userDoc = await userDetails.get();
    final questionCount = userDoc.data()?['questionCount'];
    widget.questionController.setTotalQuestionCount(questionCount);
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    checkQuestionCount();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: themeData().backgroundColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Quiz ${widget.quizId}',
                        style: themeData().genericBigTextStyle,
                      ),
                      GenericButton(
                          label: 'Quit',
                          function: () {
                            _showBottomSheet(context);
                          },
                          type: GenericButtonType.semiWarning),
                    ],
                  ),
                  Center(
                    child: GetBuilder<Controller>(
                      builder: (_) => ProgressBar(),
                    ),
                  ),
                ],
              ), //Progressbar
              GetBuilder<Controller>(builder: (_) {
                if (widget.questionController.questionId <=
                    widget.questionController.totalQuestions) {
                  return QuizQuestion(
                      quizId: widget.quizId,
                      questionId: widget.questionController.questionId,
                      myController: widget.questionController);
                } else
                  return Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox.shrink(),
                        Text(
                          'You have answered all the questions!\nYou may proceed to grading screen now',
                          style: themeData().genericBigTextStyle,
                        ),
                        GenericButton(
                          label: 'Continue',
                          function: () {
                            double score = (widget.questionController
                                        .questionsGotCorrect /
                                    widget.questionController.totalQuestions) *
                                100;
                            print('score is $score');
                            Navigator.of(context).pop();
                            Navigator.of(context, rootNavigator: true)
                                .pushNamed('/grading', arguments: {
                              'score': score.round(),
                              'quizId': widget.quizId
                            });
                          },
                          type: GenericButtonType.proceed,
                        ),
                      ],
                    ),
                  );
              }), //Question and answers
            ],
          ),
        ),
      ),
    );
  }
}

class Controller extends GetxController {
  var questionId = 1;
  var questionsCompleted = 0;
  var questionsGotCorrect = 0;
  var totalQuestions = 1;

  void nextQuestion(questionCount, context, isAnswerCorrect) {
    print('there are only $questionCount questions in the firestore');
    questionsCompleted++;
    questionId++;

    if (isAnswerCorrect) {
      questionsGotCorrect++;
    }
    update();
  }

  void setTotalQuestionCount(count) {
    totalQuestions = count;
  }

  void resetQuizScreen() {
    print('resetting question screen');
    questionId = 1;
    questionsCompleted = 0;
    questionsGotCorrect = 0;
    totalQuestions = 1;
    update();
  }
}
