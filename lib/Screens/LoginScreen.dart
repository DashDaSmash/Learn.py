import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:learn_py/Objects/GenericButton.dart';
import 'package:learn_py/Objects/TextInputField.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import '../Objects/SignInWithGoogle.dart';
import '../Objects/SignInWithEmail.dart';
import '../main.dart';

// TODO:      Add Comments

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool areCredentialsWrong = false;
  bool loading = false;

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  void _handleSignInWithEmail() async {
    loading = true;
    setState(() {});

    await signInWithEmail(emailController.text, passwordController.text);

    areCredentialsWrong = true;
    passwordController = TextEditingController();
    loading = false;
    setState(() {});
  }

  void _forgotPassword() async {
    loading = true;
    setState(() {});
    await FirebaseAuth.instance
        .sendPasswordResetEmail(email: emailController.text);
    print('Requesting pasword change for ${emailController.text}');
    loading = false;
    setState(() {});
  }

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
          padding: const EdgeInsets.all(8.0),
          child: Stack(
            children: [
              Form(
                autovalidateMode: AutovalidateMode.always,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Flexible(
                        child: Image.asset('assets/Learn.py border T.png')),
                    TextInputField(
                        label: 'Email',
                        isPassword: false,
                        controller: emailController), // EMAIL INPUT
                    SizedBox(height: 10),
                    TextInputField(
                        label: 'Password',
                        isPassword: true,
                        controller: passwordController), // PASSWORD INPUT
                    SizedBox(height: 30),
                    GenericButton(
                      label: 'Sign in',
                      function: _handleSignInWithEmail,
                      type: GenericButtonType.semiProceed,
                    ),
                    //TODO: if user can't sign in and not registered either, show them register with guide screen
                    areCredentialsWrong // IF EMAIL/PASSWORD IS WRONG, IT ALLOWS USER TO CLICK FORGOT PASSWORD
                        ? GenericButton(
                            label: 'Forgot password',
                            function: _forgotPassword,
                            type: GenericButtonType
                                .semiWarning) // FORGOT PASSWORD
                        : SizedBox.shrink(),
                    SizedBox(height: 10),
                    Divider(
                      color: Color(0xFF80FE94),
                    ),
                    SizedBox(height: 10),
                    GenericButton(
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
                          color: Color(0xFF80FE94), // Set your desired color
                          size: 30.0, // Set the size of the animation
                        ),
                      ),
                    )
                  : SizedBox.shrink()
            ],
          )),
    );
  }
}
