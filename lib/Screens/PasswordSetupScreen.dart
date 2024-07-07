import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class PasswordSetupScreen extends StatefulWidget {
  @override
  State<PasswordSetupScreen> createState() => _PasswordSetupScreenState();
}

class _PasswordSetupScreenState extends State<PasswordSetupScreen> {
  bool _isEmailVerified = false;

  @override
  void initState() {
    super.initState();
    _checkEmailVerification();
  }

  Future<void> _checkEmailVerification() async {
    while (!_isEmailVerified) {
      await FirebaseAuth.instance.currentUser!.reload();
      setState(() {
        _isEmailVerified = FirebaseAuth.instance.currentUser!.emailVerified;
        print('not verified yet :(');
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Password Setup')),
      body: Center(
        child: _isEmailVerified
            ? ElevatedButton(
                onPressed: () {
                  // Handle password setup logic
                },
                child: Text('Set Up Password'),
              )
            : CircularProgressIndicator(),
      ),
    );
  }
}
