import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:learn_py/main.dart';

class QuizGradingScreen extends StatefulWidget {
  final int quizId;
  final int score;

  QuizGradingScreen({required this.score, required this.quizId});

  @override
  State<QuizGradingScreen> createState() => _QuizGradingScreenState();
}

class _QuizGradingScreenState extends State<QuizGradingScreen> {
  Future<void> updateQuizScore() async {
    final userRef =
        FirebaseFirestore.instance.collection('users').doc(userEmail);

    if (widget.score >= 80) {
      await userRef.update({
        'LastUnlockedQuiz': widget.quizId + 1, // Set the unlocked quiz number
        'QuizScores': {
          '1': widget.score
        }, // Initialize quiz scores (assuming quiz 1)
      });
    } else {
      {
        await userRef.update({
          'QuizScores': {
            '1': widget.score
          }, // Initialize quiz scores (assuming quiz 1)
        });
      }
    }

    // final userDoc = await userRef.get();
    //
    // final Map<String, dynamic>? userData = userDoc.data();
    // final Map<String, dynamic> existingScores = userData?['quizScores'] ?? {};
    // existingScores[quizId] = widget.score;
    //
    // await userRef.update({'quizScores': existingScores});
  }

  @override
  Widget build(BuildContext context) {
    updateQuizScore();
    return Scaffold(
      body: Center(
        // TODO: Make sure to display the updated quiz score
        child: Text('${widget.score}'),
      ),
    );
  }
}
