import 'package:firebase_auth/firebase_auth.dart';

Future<void> signInWithEmail(String email, String password) async {
  try {
    await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    print("----------------------------------------------------------");
    print("requested FirebaseAuth for $email and $password");
    // Navigate to home page after successful login.
  } catch (e) {
    print(e);
    // Handle login error (show an error message).
  }
}
