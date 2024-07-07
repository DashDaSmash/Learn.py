import 'package:flutter/material.dart';
import 'package:learn_py/Objects/GenericButton.dart';
import 'package:learn_py/Objects/TextInputField.dart';
import '../Objects/SignInWithGoogle.dart';
import '../Objects/SignInWithEmail.dart';

class LoginScreen extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  void _handleSignInWithEmail() async =>
      await signInWithEmail(emailController.text, passwordController.text);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFECFFF0),
      appBar: AppBar(
        backgroundColor: Color(0xFFECFFF0),
        title: Center(
          child: Text(
            'Learn.py',
            style: TextStyle(
              fontSize: 36,
              color: Colors.white,
              shadows: [
                Shadow(
                  color: Colors.green,
                  offset: Offset(2, 2),
                  blurRadius: 4,
                ),
              ],
            ),
          ),
        ),
      ),
      body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            autovalidateMode: AutovalidateMode.always,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Flexible(child: Image.asset('assets/Learn.py border T.png')),
                TextInputField(
                    label: 'Email',
                    isPassword: false,
                    controller: emailController),
                SizedBox(height: 10),
                TextInputField(
                    label: 'Password',
                    isPassword: true,
                    controller: passwordController),
                SizedBox(height: 30),
                GenericButton(
                    label: 'Sign in',
                    function: _handleSignInWithEmail,
                    labelTextColor: Colors.white,
                    backgroundColor: Color(0xFF00CE2D),
                    strokeColor: Color(0xFF767676)),
                SizedBox(height: 10),
                Divider(
                  color: Color(0xFF80FE94),
                ),
                SizedBox(height: 10),
                GenericButton(
                    label: 'Sign in with Google',
                    image: 'assets/google_logo.png',
                    function: signInWithGoogle,
                    labelTextColor: Colors.black,
                    backgroundColor: Color(0xFFFFFFFF),
                    strokeColor: Color(0xFF80FE94)),
                GenericButton(
                    label: 'Register',
                    function: () => Navigator.of(context, rootNavigator: true)
                        .pushNamed('/registration'),
                    labelTextColor: Color(0xFF3C3C3C),
                    backgroundColor: Color(0xFF80FE94),
                    strokeColor: Color(0xFF14AE5C))
                // Other form fields...
              ],
            ),
          )

          //   children: [
          //
          //     SizedBox(height: 30),
          //     ElevatedButton(
          //       onPressed: () {
          //         signInWithEmail(emailController.text, passwordController.text);
          //         // Implement sign-in logic with email and password.
          //         // Use emailController.text and passwordController.text.
          //       },
          //       child: Text('Sign in'),
          //     ),
          //     SizedBox(height: 16),
          //     ElevatedButton(
          //       onPressed: signInWithGoogle,
          //       child: Text('Sign in with Google'),
          //     ),
          //   ],
          // ),
          ),
    );
  }
}
