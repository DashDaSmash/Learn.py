// AFTER GETTING REGISTERED WITH AN EMAIL, USER RECEIVES AN EMAIL CONFIRMATION
// IF USER HAVEN'T VERIFIED THEIR EMAIL YET, THEN THEY'RE LOCKED IN THIS SCREEN

import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:learn_py/ThemeData.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class EmailVerificationScreen extends StatefulWidget {
  const EmailVerificationScreen({super.key});

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
    // THIS VOID IS RUN PERIODICALLY TO CHECK USER'S EMAIL VERIFICATION STATUS
    // AS SOON AS USER IS DONE VERIFYING, THIS REDIRECTS USER TO HOME SCREEN
    final FirebaseAuth _auth = FirebaseAuth.instance;
    await _auth.currentUser!.reload();
    if (_auth.currentUser!.emailVerified) {
      Navigator.pop(context);
      Navigator.of(context, rootNavigator: true).pushNamed('/home');
    }
  }

  @override
  void initState() {
    super.initState();
    // VERIFICATION STATUS IS CHECKED EVERY 3 SECONDS
    verificationTimer = Timer.periodic(const Duration(seconds: 3), (timer) {
      checkVerificationStatus(context);
    });
  }

  @override
  void dispose() {
    // TO SAVE DEVICE RESOURCES
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
                color: const Color(0xFF80FE94),
                size: 100.0,
              ),
              const SizedBox(height: 30),
              Text(
                'We\'re waiting for you\nto verify your email',
                style: themeData().genericBigTextStyle,
              ),
              const SizedBox(height: 30),
              GestureDetector(
                onTap: () {
                  resendEmailVerification();
                },
                child: const Text(
                  'Resend verification link',
                  style: TextStyle(color: Colors.red),
                ),
              ), // RESEND BUTTON
              const SizedBox(height: 10),
              const Text('or'),
              const SizedBox(height: 10),
              GestureDetector(
                onTap: () {
                  FirebaseAuth.instance.signOut();
                },
                child: const Text(
                  'Use another account',
                  style: TextStyle(color: Colors.red),
                ),
              ), // SWITCH ACCOUNT
            ],
          ),
        ),
      ),
    );
  }
}
