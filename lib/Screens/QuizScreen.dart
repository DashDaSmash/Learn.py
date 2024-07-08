import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

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
  RxString isAnswerCorrect = ''.obs;

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
            GetBuilder<Controller>(
              builder: (_) => QuizQuestion(
                quizId: widget.quizId,
                questionId: widget.questionController.questionId,
                myController: widget.questionController,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

//This runs after all the questions are done
class _QuizScreenENDState extends State<QuizScreen> {
  RxInt questionId = 1.obs;
  RxString isAnswerCorrect = ''.obs;

  @override
  Widget build(BuildContext context) {
    print('updating screen...');
    return Scaffold(
        backgroundColor: Colors.red,
        body: Container(
            width: double.infinity,
            height: double.infinity,
            color: Colors.blueAccent));
  }
}

class Controller extends GetxController {
  var questionId = 1;
  void nextQuestion(questionCount, context) {
    print('there are only $questionCount questions in the firestore');

    if (questionId < questionCount) {
      //DONT FUCKING TOUCH THIS INEQUALITY YOU SMART ASS
      questionId++;
      print('now questionId is $questionId');
      update();
    } else {
      print('all the questions are done');
      Navigator.of(context).pop();
      Navigator.of(context, rootNavigator: true).pushNamed('/grading');
      // State<QuizScreen> createState() => _QuizScreenENDState();
    }
  }
}
