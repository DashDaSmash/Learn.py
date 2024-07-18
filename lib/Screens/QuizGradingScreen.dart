import 'package:countup/countup.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:learn_py/ThemeData.dart';
import 'package:learn_py/main.dart';
import 'package:get/get.dart';
import '../Objects/GenericButton.dart';
import '../Objects/GradingScreenMessage.dart';
import 'QuizScreen.dart';

// ignore: must_be_immutable
class QuizGradingScreen extends StatefulWidget {
  final int quizId;
  final int score;

  QuizGradingScreen({required this.score, required this.quizId});

  @override
  State<QuizGradingScreen> createState() => _QuizGradingScreenState();
}

class _QuizGradingScreenState extends State<QuizGradingScreen> {
  bool? userPassedQuiz;
  final questionController = Get.put(Controller());
  Future<void> updateQuizScore() async {
    final userRef =
        FirebaseFirestore.instance.collection('users').doc(userEmail);
    final userDoc = await userRef.get();
    print(userDoc.data()?['QuizScores']);
    // widget.fireStoreQuizMap!['${widget.quizId}'] = widget.score;

    // widget.fireStoreQuizMap {
    //   '${widget.quizId}': widget.score,
    // };
    Map<String, dynamic> fireStoreQuizMap = userDoc.data()?['QuizScores'];
    print('*******************');
    print(fireStoreQuizMap);
    fireStoreQuizMap['${widget.quizId}'] = widget.score;
    print('####################');
    print(fireStoreQuizMap);
    //questionCount = snapshot.data!['questionCount'];

    if (userPassedQuiz!) {
      await userRef.update({
        'LastUnlockedQuiz': widget.quizId + 1, // Set the unlocked quiz number
        'QuizScores':
            fireStoreQuizMap // Initialize quiz scores (assuming quiz 1)
      });
    } else {
      {
        await userRef.update({'QuizScores': fireStoreQuizMap});
      }
    }
    questionController.resetQuizScreen();
  }

  @override
  Widget build(BuildContext context) {
    userPassedQuiz = widget.score >= 80;
    updateQuizScore();

    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: userPassedQuiz!
                ? [Colors.white, Color(0xFF00FF29)]
                : [Colors.white, Colors.red],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              flex: 1,
              child: Container(
                height: double.infinity,
                width: double.infinity,
              ),
            ), //Just to fill the space
            Expanded(
              flex: 3,
              child: Container(
                height: double.infinity,
                width: double.infinity,
                child: TextEnlargementAnimation(
                  userPassedQuiz: userPassedQuiz!,
                ),
              ),
            ),
            Expanded(
              flex: 3,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Row(
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.2,
                      ),
                      Text(
                        'You scored:',
                        style: themeData().genericTextStyle,
                      ),
                    ],
                  ),
                  IntrinsicHeight(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Countup(
                          begin: 0,
                          end: widget.score.toDouble(),
                          duration: Duration(seconds: 2),
                          separator: ',',
                          style: themeData().GradingScreenScoreTextStyle,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Column(
                          children: [
                            Expanded(flex: 6, child: Container()),
                            Expanded(
                              flex: 5,
                              child: Text(
                                '%',
                                style: themeData().genericBigTextStyle,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 1,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: GenericButton(
                        label: 'Continue',
                        function: () => Navigator.pop(context),
                        type: userPassedQuiz!
                            ? GenericButtonType.semiProceed
                            : GenericButtonType.semiWarning),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
