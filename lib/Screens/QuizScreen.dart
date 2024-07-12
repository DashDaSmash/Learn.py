import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:learn_py/Objects/GenericButton.dart';
import 'package:learn_py/Objects/QuizQuestion.dart';
import 'package:get/get.dart';
import 'package:bottom_sheet/bottom_sheet.dart';

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
      Progress = widget.questionController.questionsGotCorrect /
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
      progressColor: Colors.green,
    );
  }

  @override
  Widget build(BuildContext context) {
    print('updating screen...');
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text('Quiz ${widget.quizId}'),
            //TODO: when this screen appears, prograss bar expands from middle, when user clicks next, it progresses with animantion

            Divider(),
            GetBuilder<Controller>(
              builder: (_) => ProgressBar(),
            ),
            GetBuilder<Controller>(builder: (_) {
              if (widget.questionController.questionId <=
                  widget.questionController.totalQuestions) {
                return QuizQuestion(
                    quizId: widget.quizId,
                    questionId: widget.questionController.questionId,
                    myController: widget.questionController);
              } else
                return GenericButton(
                    label: 'Continue',
                    function: () {
                      double score =
                          (widget.questionController.questionsGotCorrect /
                                  widget.questionController.totalQuestions) *
                              100;

                      Navigator.of(context).pop();
                      Navigator.of(context, rootNavigator: true)
                          .pushNamed('/grading', arguments: {
                        'score': score.round(),
                        'quizId': widget.quizId
                      });
                    },
                    labelTextColor: Colors.white,
                    backgroundColor: Colors.pinkAccent,
                    strokeColor: Colors.pink);
            }),
          ],
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
}
