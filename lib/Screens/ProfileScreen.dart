import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:learn_py/main.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

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

  Future<void> _fetchUserData() async {
    final userRef =
        FirebaseFirestore.instance.collection('users').doc(userEmail);
    final userDoc = await userRef.get();
    final Map<String, dynamic> quizScores = userDoc.data()?['QuizScores'] ?? {};
    print('quizScores: $quizScores');
    for (final key in quizScores.keys) {
      lastTestScore = int.parse(quizScores[key].toString());
      userTotalScore += lastTestScore;
      quizCount++;
      double average = userTotalScore / quizCount;
      averageScore = average.round();
    }
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
            Text('Last test score: $lastTestScore'),
            Text('averageScore: $averageScore'),
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
}

Future<void> signOut() async {
  try {
    await FirebaseAuth.instance.signOut();
    // Navigate to the login screen or any other appropriate screen.
  } catch (e) {
    // Handle sign-out error (show an error message).
  }
}
