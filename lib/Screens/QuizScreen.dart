import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:learn_py/Objects/GenericButton.dart';
import 'package:learn_py/Objects/QuizQuestion.dart';
import 'package:get/get.dart';

class QuizScreen extends StatefulWidget {
  final controller = Get.put(Controller());

  final int quizId;
  List? question1;
  List? options;

  QuizScreen({required this.quizId});

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  RxInt questionId = 1.obs;

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
            GetBuilder<Controller>(
                builder: (_) => QuizQuestion(
                    quizId: widget.quizId,
                    questionId: widget.controller.questionId,
                    myController: widget.controller)),
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

class Controller extends GetxController {
  var questionId = 1;
  void nextQuestion() {
    questionId++;
    update();
  }
}
