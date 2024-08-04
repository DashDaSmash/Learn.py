import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import 'package:learn_py/Objects/GenericButton.dart';
import 'package:learn_py/Objects/TextInputField.dart';
import '../Objects/SignInWithGoogle.dart';
import '../Objects/SignInWithEmail.dart';
import '../main.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // STATE VARIABLES
  bool areCredentialsWrong = false;
  bool loading = false;
  String errorMessage = '';

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  void _handleSignInWithEmail() async {
    setState(() {
      loading = true;
    });

    try {
      await signInWithEmail(emailController.text, passwordController.text);
      errorMessage = '';
    } catch (e) {
      errorMessage =
          'Failed to sign in...\nCheck your email address and password';
    }
    areCredentialsWrong = true;
    passwordController = TextEditingController();

    setState(() {
      loading = false;
    });
  }

  void _forgotPassword() async {
    loading = true;
    setState(() {});
    await FirebaseAuth.instance
        .sendPasswordResetEmail(email: emailController.text);
    loading = false;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFECFFF0),
      appBar: AppBar(
        backgroundColor: const Color(0xFFECFFF0),
        title: const Center(
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
        padding: const EdgeInsets.all(8.0),
        child: Stack(
          children: [
            Form(
              autovalidateMode: AutovalidateMode.always,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Flexible(
                    child: Image.asset('assets/Learn.py border T.png'),
                  ), // LOGO
                  areCredentialsWrong
                      // FOLLOWING TEXT IS SHOWN WHEN USER CANNOT PASS LOGIN SCREEN
                      ? const Text(
                          'Failed to sign in...\nCheck your email address and password',
                          style: TextStyle(color: Colors.red),
                          textAlign: TextAlign.center,
                        )
                      : const SizedBox.shrink(),
                  TextInputField(
                      label: 'Email',
                      isPassword: false,
                      controller: emailController), // EMAIL INPUT
                  const SizedBox(height: 10),
                  TextInputField(
                      label: 'Password',
                      isPassword: true,
                      controller: passwordController), // PASSWORD INPUT
                  const SizedBox(height: 30),
                  GenericButton(
                    label: 'Sign in',
                    function: _handleSignInWithEmail,
                    type: GenericButtonType.semiProceed,
                  ), // SIGN IN BUTTON
                  //TODO: if user can't sign in and not registered either, show them register with guide screen
                  areCredentialsWrong // IF EMAIL/PASSWORD IS WRONG, IT ALLOWS USER TO CLICK FORGOT PASSWORD
                      ? GenericButton(
                          label: 'Forgot password',
                          function: _forgotPassword,
                          type:
                              GenericButtonType.semiWarning) // FORGOT PASSWORD
                      : const SizedBox.shrink(),
                  const SizedBox(height: 10),
                  const Divider(
                    color: Color(0xFF80FE94),
                  ),
                  const SizedBox(height: 10),
                  const GenericButton(
                    label: 'Sign in with Google',
                    image: 'assets/google_logo.png',
                    function: signInWithGoogle,
                    type: GenericButtonType.generic,
                  ), // SIGN IN WITH GOOGLE
                  GenericButton(
                    label: 'Register',
                    function: () => Navigator.of(context, rootNavigator: true)
                        .pushNamed('/registration'),
                    type: GenericButtonType.proceed,
                  ), // REGISTER BUTTON
                  // Other form fields...
                ],
              ),
            ),
            loading
                ? Container(
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width,
                    color: Colors.white.withOpacity(0.5),
                    child: Center(
                      child: LoadingAnimationWidget.threeRotatingDots(
                        color: const Color(0xFF80FE94), // Set your desired color
                        size: 30.0, // Set the size of the animation
                      ),
                    ),
                  )
                : const SizedBox.shrink()
          ],
        ),
      ),
    );
  }
}
