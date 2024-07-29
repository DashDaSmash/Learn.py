import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:learn_py/Objects/GuideSheet.dart';
import 'package:learn_py/ThemeData.dart';
import 'package:learn_py/main.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:countup/countup.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import '../Objects/GenericButton.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  int userTotalScore = 0;
  int quizCount = 0;
  int averageScore = 0;
  int lastTestScore = 0;
  String FirstName = '';
  String LastName = '';
  var imageUrl;
  Map<String, dynamic>? quizScores;

  //STATE VARIABLES
  bool wantToChangePP = false;
  bool loading = false;
  bool loadingScores = false;

  Future<void> _fetchUserData() async {
    setState(() {
      loadingScores = true;
    });

    userTotalScore = 0;

    final userScore =
        FirebaseFirestore.instance.collection('users').doc(userEmail);
    final userDoc = await userScore.get();
    quizScores = userDoc.data()?['QuizScores'] ?? {};
    FirstName = userDoc.data()?['FirstName'];
    LastName = userDoc.data()?['LastName'];
    print('quizScores: $quizScores');
    for (final key in quizScores!.keys) {
      lastTestScore = int.parse(quizScores![key].toString());
      print('lastTestScore: $lastTestScore');
      userTotalScore += lastTestScore;
      quizCount++;
      double average = userTotalScore / quizCount;
      averageScore = average.round();
    }

    final storageRef =
        FirebaseStorage.instance.ref().child('profile_images/$userEmail.jpg');
    try {
      imageUrl = await storageRef.getDownloadURL();
    } catch (e) {
      print(e);
    }
    setState(() {
      loadingScores = false;
    });
  }

  void _signOut() {
    FirebaseAuth.instance.signOut();
    print('***********************************************************');
  }

  void showGuideAgain() async {
    // SHOW LOADING SCREEN
    loading = true;
    setState(() {});

    for (String screenName in fireStoreGuideSheetMap.keys) {
      // SET ALL THE SCREENS TO SHOW AGAIN
      fireStoreGuideSheetMap[screenName] = true;
    }

    final userRef =
        FirebaseFirestore.instance.collection('users').doc(userEmail);

    await userRef.update({'ShowGuideSheet': fireStoreGuideSheetMap});

    // STOP LOADING SCREEN
    loading = false;
    setState(() {});
  }

  void resetQuizScores() async {
    setState(() {
      loading = true;
    });

    for (String quizId in quizScores!.keys) {
      quizScores![quizId] = 0;
    }

    final userRef =
        FirebaseFirestore.instance.collection('users').doc(userEmail);

    await userRef.update({'QuizScores': quizScores});

    loading = false;
    _fetchUserData();
  }

  @override
  void initState() {
    super.initState();
    _fetchUserData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: themeData().backgroundColor,
      body: Stack(
        children: [
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 70, bottom: 30),
                            child: Column(
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    _clickedOnPP();
                                  },
                                  child: wantToChangePP
                                      ? CircleAvatar(
                                          backgroundColor: Colors.white,
                                          radius: 80,
                                          child: Icon(
                                            Icons.edit,
                                            color: Color(0xFF78FF8E),
                                            size: 50,
                                          ),
                                        )
                                      : imageUrl != null
                                          ? CircleAvatar(
                                              backgroundColor: Colors.white,
                                              radius: 80,
                                              child: ClipOval(
                                                child: Image.network(
                                                  imageUrl, // Replace with your image URL
                                                  height: 160,
                                                  width: 160,
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                            )
                                          : CircleAvatar(
                                              backgroundColor: Colors.white,
                                              radius: 80,
                                              child: Icon(
                                                CupertinoIcons.profile_circled,
                                                color: Color(0xFFB4FFC0),
                                                size: 160,
                                              ),
                                            ),
                                ),
                                FirstName.isNotEmpty && LastName.isNotEmpty
                                    ? Text(
                                        '$FirstName $LastName',
                                        style: themeData().genericBigTextStyle,
                                      )
                                    : SizedBox.shrink(),
                                Text(
                                  '$userEmail',
                                  style: themeData().genericTextStyle,
                                ),
                              ],
                            ), // PROFILE PIC, NAME AND EMAIL
                          ),
                          loadingScores
                              ? LoadingAnimationWidget.threeRotatingDots(
                                  color: Color(
                                      0xFF80FE94), // Set your desired color
                                  size: 50.0, // Set the size of the animation
                                )
                              : Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          'Last Quiz Score: ',
                                          style: themeData().genericTextStyle,
                                        ),
                                        Row(
                                          children: [
                                            Countup(
                                              begin: 0,
                                              end: lastTestScore.toDouble(),
                                              duration: Duration(seconds: 1),
                                              separator: ',',
                                              style: themeData().boldDigit,
                                            ),
                                            Column(
                                              // mainAxisAlignment: MainAxisAlignment.end,
                                              children: [
                                                Container(
                                                  height: 18,
                                                  width: 16,
                                                ),
                                                Text(
                                                  '%',
                                                  style: themeData()
                                                      .genericTextStyle,
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ],
                                    ), // LAST QUIZ SCORE
                                    Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            'Average Score: ',
                                            style: themeData().genericTextStyle,
                                          ),
                                          Row(
                                            children: [
                                              Countup(
                                                begin: 0,
                                                end: averageScore.toDouble(),
                                                duration: Duration(seconds: 1),
                                                separator: ',',
                                                style: themeData().boldDigit,
                                              ),
                                              Column(
                                                // mainAxisAlignment: MainAxisAlignment.end,
                                                children: [
                                                  Container(
                                                    height: 18,
                                                    width: 16,
                                                  ),
                                                  Text(
                                                    '%',
                                                    style: themeData()
                                                        .genericTextStyle,
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ]), // AVERAGE SCORE
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          'Total Score: ',
                                          style: themeData().genericTextStyle,
                                        ),
                                        Countup(
                                          begin: 0,
                                          end: userTotalScore.toDouble(),
                                          duration: Duration(seconds: 1),
                                          separator: ',',
                                          style: themeData().boldDigit,
                                        ),
                                      ],
                                    ), // TOTAL SCORE
                                    SizedBox(height: 10),
                                    Column(
                                      children: [
                                        Text(
                                            'By clicking the below button, you will consent to erase any scores you have achived. This action is irreversible.\n*Unlocked quizzes will remain the same',
                                            textAlign: TextAlign.center),
                                        TextButton(
                                            onPressed: () {
                                              resetQuizScores();
                                            },
                                            child: Text(
                                              'Reset scores',
                                              style:
                                                  TextStyle(color: Colors.red),
                                            )),
                                      ],
                                    ), // RESET SCORES SECTION
                                  ],
                                ),
                        ],
                      ),
                    ),
                  ),
                ),

                // Add some spacing
                //BackButton
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      GenericButton(
                          label: 'Sign out',
                          function: () {
                            _signOut();
                            Navigator.pop(context);
                          },
                          type: GenericButtonType.semiWarning),
                      GenericButton(
                          label: 'Show guide again',
                          function: () {
                            showGuideAgain();
                          },
                          type: GenericButtonType.generic),
                      GenericButton(
                        label: 'Back',
                        function: () => Navigator.pop(context),
                        type:
                            GenericButtonType.generic, // Set your desired color
                      ),
                    ],
                  ),
                ), //BackButton
              ],
            ),
          ),
          loading
              ? Container(
                  color: Colors.white.withOpacity(0.5),
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  child: Center(
                      child: LoadingAnimationWidget.threeRotatingDots(
                    color: Color(0xFF80FE94), // Set your desired color
                    size: 50.0, // Set the size of the animation
                  )),
                )
              : SizedBox.shrink(),
          GuideSheet(currentScreen: 'ProfileScreen'),
        ],
      ),
    );
  }

  void _clickedOnPP() {
    if (wantToChangePP) {
      print('user wants to changePP');
      _changePP();
    }

    wantToChangePP = !wantToChangePP;

    setState(() {});
  }

  Future<void> _changePP() async {
    try {
      final ImagePicker _picker = ImagePicker();
      final XFile? selectedImage = await _picker.pickImage(
        source: ImageSource.gallery,
      );

      if (selectedImage != null) {
        File imageFile = File(selectedImage.path);
        // Now you can use 'imageFile' as a regular File
        final storageRef = FirebaseStorage.instance
            .ref()
            .child('profile_images/$userEmail.jpg');
        await storageRef.putFile(imageFile);
      }

      // Use 'imageFile' here
    } catch (e) {
      print(e);
    }
  }
}
