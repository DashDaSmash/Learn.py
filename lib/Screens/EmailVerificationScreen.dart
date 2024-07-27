import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:learn_py/ThemeData.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class EmailVerificationScreen extends StatefulWidget {
  @override
  _EmailVerificationScreenState createState() =>
      _EmailVerificationScreenState();
}

class _EmailVerificationScreenState extends State<EmailVerificationScreen> {
  late Timer verificationTimer;

  Future<void> resendEmailVerification() async {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    await _auth.currentUser!.sendEmailVerification();
  }

  Future<void> checkVerificationStatus(BuildContext context) async {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    await _auth.currentUser!.reload();
    if (_auth.currentUser!.emailVerified) {
      // User is verified
      // Implement your logic here (e.g., navigate to a different screen)
      Navigator.pop(context);
      Navigator.of(context, rootNavigator: true).pushNamed('/home');
    } else {
      // User is not verified
      // You can display a message or take appropriate action
    }
  }

  @override
  void initState() {
    super.initState();
    // Start the timer to check verification status every 30 seconds
    verificationTimer = Timer.periodic(Duration(seconds: 3), (timer) {
      checkVerificationStatus(context);
    });
  }

  @override
  void dispose() {
    // Cancel the timer when the widget is disposed
    verificationTimer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        color: Colors.white,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              LoadingAnimationWidget.threeRotatingDots(
                color: Color(0xFF80FE94), // Set your desired color
                size: 100.0, // Set the size of the animation
              ),
              SizedBox(height: 30),
              Text(
                'We\'re waiting for you\nto verify your email',
                style: themeData().genericBigTextStyle,
              ),
              SizedBox(height: 30),
              GestureDetector(
                onTap: () {
                  resendEmailVerification();
                },
                child: Text(
                  'Resend verification link',
                  style: TextStyle(color: Colors.red),
                ),
              ),
              SizedBox(height: 10),
              Text('or'),
              SizedBox(height: 10),
              GestureDetector(
                onTap: () {
                  FirebaseAuth.instance.signOut();
                },
                child: Text(
                  'Use another account',
                  style: TextStyle(color: Colors.red),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
