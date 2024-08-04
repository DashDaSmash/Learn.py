import 'package:firebase_auth/firebase_auth.dart';

// FOLLOWING VOID SIGNS UP USER WITH EMAIL AND PASSWORD

Future<void> signInWithEmail(String email, String password) async {
  try {
    await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  } catch (e) {}
}
