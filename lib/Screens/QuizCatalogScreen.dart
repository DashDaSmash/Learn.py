import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:learn_py/Objects/GenericButton.dart';
import 'package:learn_py/Objects/GuideSheet.dart';
import 'package:learn_py/ThemeData.dart';
import 'package:learn_py/main.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class QuizCatalogScreen extends StatefulWidget {
  @override
  _QuizCatalogScreenState createState() => _QuizCatalogScreenState();
}

class _QuizCatalogScreenState extends State<QuizCatalogScreen> {
  int lastUnlockedQuiz = 0;
  Future<void> checkUserQuizUnlockProgress() async {
    final userDetails =
        FirebaseFirestore.instance.collection('users').doc(userEmail);
    final userDoc = await userDetails.get();
    lastUnlockedQuiz = userDoc.data()?['LastUnlockedQuiz'];
    print('lastUnlockedQuiz: $lastUnlockedQuiz');
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    checkUserQuizUnlockProgress();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: themeData().backgroundColor,
      body: Stack(children: [
        StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance.collection('quiz').snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Center(
                  child: LoadingAnimationWidget.threeRotatingDots(
                color: Color(0xFF80FE94), // Set your desired color
                size: 30.0, // Set the size of the animation
              ));
            }

            final documents = snapshot.data?.docs;

            return ListView.builder(
              itemCount: documents?.length ?? 0,
              itemBuilder: (context, index) {
                final doc = documents![index];
                final docId = doc.id;
                final quizId = int.parse(docId.substring(4, 7));

                return ListTile(
                  title: GenericButton(
                    icon: quizId < lastUnlockedQuiz
                        ? Icon(
                            Icons.check,
                            color: Colors.green,
                          )
                        : quizId == lastUnlockedQuiz
                            ? Icon(
                                Icons.arrow_forward_outlined,
                                color: Colors.white,
                              )
                            : Icon(
                                Icons.lock_outline_rounded,
                                color: Colors.black54,
                              ),
                    label: docId,
                    function: () => quizId <= lastUnlockedQuiz
                        ? Navigator.of(context, rootNavigator: true)
                            .pushNamed('/quiz', arguments: quizId)
                        : {},
                    type: quizId < lastUnlockedQuiz
                        ? GenericButtonType.semiProceed
                        : quizId == lastUnlockedQuiz
                            ? GenericButtonType.proceed
                            : GenericButtonType.generic,
                  ),
                  // Add other widgets or data from the document as needed
                );
              },
            );
          },
        ),
        Positioned(
          bottom: 8,
          left: 8,
          right: 8,
          child: //BackButton
              //BackButton
              GenericButton(
            label: 'Back',
            function: () => Navigator.pop(context),
            type: GenericButtonType.generic, // Set your desired color
          ),
        ),
        GuideSheet(currentScreen: 'QuizCatalogScreen'),
      ]),
    );
  }
}
