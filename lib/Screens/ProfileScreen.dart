import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:learn_py/main.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:countup/countup.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();

  // @override
  // void initState() {
  //   super.initState();
  //   // Initialize any state variables or perform other setup here
  //   // For example, fetch data from Firestore
  //   _fetchUserData();
  // }
}

class _ProfileScreenState extends State<ProfileScreen> {
  // Add your state variables and methods here
  int userTotalScore = 0;
  int quizCount = 0;
  int averageScore = 0;
  int lastTestScore = 0;
  String? FirstName;
  String? LastName;
  var imageUrl;
  bool wantToChangePP = false;

  Future<void> _fetchUserData() async {
    final userScore =
        FirebaseFirestore.instance.collection('users').doc(userEmail);
    final userDoc = await userScore.get();
    final Map<String, dynamic> quizScores = userDoc.data()?['QuizScores'] ?? {};
    print('quizScores: $quizScores');
    for (final key in quizScores.keys) {
      lastTestScore = int.parse(quizScores[key].toString());
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
    print('image URL is: $imageUrl');

    setState(() {});
    print('userTotalScore: $userTotalScore');
    print('quizCount: $quizCount');
  }

  @override
  void initState() {
    super.initState();
    _fetchUserData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('My Screen')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () {
                _clickedOnPP();
              },
              child: wantToChangePP
                  ? CircleAvatar(
                      radius: 50,
                      child: Icon(Icons.edit),
                    )
                  : CircleAvatar(
                      radius: 50,
                      child: imageUrl != null
                          ? Image.network(imageUrl)
                          : Text(':(')),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Last test score: '),
                Countup(
                  begin: 0,
                  end: lastTestScore.toDouble(),
                  duration: Duration(seconds: 1),
                  separator: ',',
                  style: TextStyle(
                    fontSize: 36,
                  ),
                ),
              ],
            ),
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              Text('averageScore: '),
              Countup(
                begin: 0,
                end: averageScore.toDouble(),
                duration: Duration(seconds: 1),
                separator: ',',
                style: TextStyle(
                  fontSize: 36,
                ),
              ),
            ]),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('total: '),
                Countup(
                  begin: 0,
                  end: userTotalScore.toDouble(),
                  duration: Duration(seconds: 1),
                  separator: ',',
                  style: TextStyle(
                    fontSize: 36,
                  ),
                ),
              ],
            ),
            Text('Email: $userEmail'),
            ElevatedButton(
              onPressed: () {
                signOut();
                // Handle sign-out logic here
                // For example, call a sign-out function
                // AuthService.signOut();
              },
              child: Text('Sign Out'),
            ),
            SizedBox(height: 16), // Add some spacing
            ElevatedButton(
              onPressed: () {
                // Navigate back to the previous screen
                Navigator.pop(context);
              },
              child: Text('Go Back'),
            ),
          ],
        ),
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

Future<void> signOut() async {
  try {
    await FirebaseAuth.instance.signOut();
    // Navigate to the login screen or any other appropriate screen.
  } catch (e) {
    print(e);
    // Handle sign-out error (show an error message).
  }
}
