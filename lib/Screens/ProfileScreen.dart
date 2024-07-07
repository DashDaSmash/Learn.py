import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('My Screen')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
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
