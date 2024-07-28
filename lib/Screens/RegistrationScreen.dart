import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';
import 'package:learn_py/ThemeData.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import '../Objects/GenericButton.dart';
import '../Objects/TextInputField.dart';
import '../main.dart';

//TODO: FIx the UI

// TODO:      If that email already has an account, send it to login

//TODO:       If user clicks on resend email verification, show an animation
class RegistrationScreen extends StatefulWidget {
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // TEXT CONTROLLERS FOR INPUT FIELDS
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController passwordComfirmationController =
      TextEditingController();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();

  // THIS VARIABLE STORES ANY WARNINGS THAT WE SHOW TO USER
  String passwordWarning = '';

  //STATE VARIABLES
  bool passComfirmError = false;
  bool passNotStrong = true;
  bool emptyFieldWarning = false;
  bool loading = false;

  void registerUser() async {
    // SET SCREEN TO LOADING
    loading = true;
    setState(() {});

    try {
      // REGISTER USER FOR FIREBASE AUTHENTICATION
      await _auth.createUserWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );

      // SETUP A FIRESTORE DOCUMENT WITH USER'S EMAIL AS DOC ID
      // THIS IS REQUIRED FOR FURTHER FUNCTIONALITY
      await FirebaseFirestore.instance
          .collection('users')
          .doc(emailController.text)
          .set({
        'FirstName': firstNameController.text,
        'LastName': lastNameController.text,
        'LastUnlockedQuiz': 1,
        'QuizScores': {},
        'ShowGuideSheet': {
          'DiscoveryScreen': true,
          'HomeScreen': true,
        }
      });

      // SEND EMAIL VERIFICATION TO USER
      await _auth.currentUser!.sendEmailVerification();
      print('Verification email sent successfully!');

      // ONCE DONE, EXECUTE THE FOLLOWING
      registrationComplete();
    } catch (e) {
      print('Error: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Registration failed. Please try again.')),
      );
    }

    // QUIT LOADING SCREEN
    loading = false;
    setState(() {});
  }

  void registrationComplete() {
    // BELOW CODE RETURNS USER BACK TO main.dart WHICH IN TURN SEND USER AGAIN TO EMAIL VERIFICATION
    Navigator.pop(context);
  }

  void checkPasswordStrength(String password) {
    bool weakPassword = false;
    passwordWarning = '';
    if (password != '') {
      passwordWarning += 'Your password must have\n';
      // Check if the password has at least 8 characters
      if (password.length < 8) {
        weakPassword = true;
        passwordWarning += 'Minimum of 8 characters\n';
      }

      // Check if the password contains at least one lowercase letter
      if (!password.contains(RegExp(r'[a-z]'))) {
        weakPassword = true;
        passwordWarning += 'At least 1 lower case letters\n';
      }

      // Check if the password contains at least one uppercase letter
      if (!password.contains(RegExp(r'[A-Z]'))) {
        weakPassword = true;
        passwordWarning += 'At least 1 upper case letters\n';
      }

      // Check if the password contains at least one digit
      if (!password.contains(RegExp(r'[0-9]'))) {
        weakPassword = true;
        passwordWarning += 'At least 1 digit\n';
      }

      // Check if the password contains at least one special character
      if (!password.contains(RegExp(r'[!@#\$%^&*(),.?":{}|<>]'))) {
        weakPassword = true;
        passwordWarning += 'At least 1 special character (eg: \$!#)\n';
      }
    }

    // If all criteria are met, the password is strong
    passNotStrong = weakPassword;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: themeData().backgroundColor,
      body: SafeArea(
        child: loading
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
              ) // LOADING ICON (FULL SCREEN)
            : Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: SingleChildScrollView(
                          child: Form(
                            autovalidateMode: AutovalidateMode.always,
                            key: _formKey,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Image.asset(
                                  'assets/Learn.py border T.png',
                                  height: 200,
                                  width: 200,
                                ), // LOGO ABOVE INPUT FIELDS
                                emptyFieldWarning
                                    ? Text(
                                        'Please fill all the fields below',
                                        style: TextStyle(color: Colors.red),
                                      ) // THIS WARNING ONLY SHOWS UP IF FIELDS ARE EMPTY AND USER CLICKS REGISTER BUTTON
                                    : SizedBox.shrink(),
                                TextInputField(
                                  label: 'First Name',
                                  isPassword: false,
                                  controller: firstNameController,
                                ), // FIRST NAME INPUT
                                SizedBox(height: 10),
                                TextInputField(
                                  label: 'Last Name',
                                  isPassword: false,
                                  controller: lastNameController,
                                ), // LAST NAME INPUT
                                SizedBox(height: 10),
                                TextInputField(
                                  label: 'Email',
                                  isPassword: false,
                                  controller: emailController,
                                ), // EMAIL INPUT
                                SizedBox(height: 10),
                                TextFormField(
                                  obscureText: true,
                                  controller: passwordController,
                                  textAlign: TextAlign.center,
                                  textAlignVertical: TextAlignVertical.center,
                                  decoration: InputDecoration(
                                    labelText: 'Create Password',
                                    alignLabelWithHint: true,
                                    filled: true,
                                    fillColor: Colors.white,
                                    labelStyle: TextStyle(
                                      color: Color(
                                          0xFF3C3C3C), // Set your desired color here
                                      fontSize:
                                          18.0, // Optional: adjust font size
                                      fontWeight: FontWeight
                                          .w400, // Optional: adjust font weight
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: passNotStrong &&
                                                passwordController
                                                    .text.isNotEmpty
                                            ? Color(0xFFFF0000)
                                            : Color(0xFFD9D9D9),
                                        width:
                                            3.0, // Adjust the border thickness here
                                      ),
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(15),
                                      borderSide: BorderSide(
                                          width: 2,
                                          color: passNotStrong &&
                                                  passwordController
                                                      .text.isNotEmpty
                                              ? Color(0xFFFF0000)
                                              : Color(0xFFD9D9D9)),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          width: 2,
                                          color: passNotStrong &&
                                                  passwordController
                                                      .text.isNotEmpty
                                              ? Color(0xFFFF0000)
                                              : Color(0xFF00B71D)),
                                      borderRadius: BorderRadius.circular(15.0),
                                    ),
                                  ),
                                  onChanged: (value) {
                                    checkPasswordStrength(value);
                                    setState(() {});
                                  },
                                ), // CREATE PASSWORD
                                !passNotStrong &&
                                        passwordController.text
                                            .isNotEmpty // IF PASSWORD IS STRONG OR THERE IS NO WARNING
                                    ? TextFormField(
                                        obscureText: true,
                                        controller:
                                            passwordComfirmationController,
                                        textAlign: TextAlign.center,
                                        textAlignVertical:
                                            TextAlignVertical.center,
                                        decoration: InputDecoration(
                                          labelText: 'Retype Password',
                                          alignLabelWithHint: true,
                                          filled: true,
                                          fillColor: Colors.white,
                                          labelStyle: TextStyle(
                                            color: Color(
                                                0xFF3C3C3C), // Set your desired color here
                                            fontSize:
                                                18.0, // Optional: adjust font size
                                            fontWeight: FontWeight
                                                .w400, // Optional: adjust font weight
                                          ),
                                          enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: passComfirmError
                                                  ? Color(0xFFFF0000)
                                                  : Color(0xFFD9D9D9),
                                              width:
                                                  2, // Adjust the border thickness here
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(15),
                                          ),
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(15),
                                            borderSide: BorderSide(
                                                width: 2,
                                                color: passComfirmError
                                                    ? Color(0xFFFF0000)
                                                    : Color(0xFFD9D9D9)),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                width: 2,
                                                color: passComfirmError
                                                    ? Color(0xFFFF0000)
                                                    : Color(0xFF00B71D)),
                                            borderRadius:
                                                BorderRadius.circular(15.0),
                                          ),
                                        ),
                                        onChanged: (value) {
                                          if (passwordController.text ==
                                              passwordComfirmationController
                                                  .text) {
                                            passComfirmError = false;
                                          } else {
                                            passComfirmError = true;
                                          }
                                          setState(() {});
                                        },
                                      ) // PASSWORD CONFIRMATION
                                    : Text(
                                        passwordWarning), // WARNING OF PASSWORD CRITERIA
                                passComfirmError
                                    ? Text(
                                        'Looks like they don\'t match :(',
                                        style: TextStyle(color: Colors.red),
                                      ) // WARNING TEXT OF PASSWORDS NOT MATCHING
                                    : SizedBox.shrink(),
                              ],
                            ), // LOGO + INPUT FIELDS
                          ), // LOGO + INPUT FIELDS
                        ), // LOGO + INPUT FIELDS
                      ), // LOGO + INPUT FIELDS
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          GenericButton(
                            label: 'Register',
                            function: () {
                              if (passComfirmError == false &&
                                  passNotStrong == false &&
                                  firstNameController.text.isNotEmpty &&
                                  lastNameController.text.isNotEmpty) {
                                // ALL THE RESTRICTIONS ARE FULFILLED AND READY TO REGISTER
                                registerUser();
                              } else {
                                emptyFieldWarning = true;
                                setState(() {});
                              }
                            },
                            type: passComfirmError == false &&
                                    passNotStrong == false &&
                                    firstNameController.text.isNotEmpty &&
                                    lastNameController.text.isNotEmpty
                                ? GenericButtonType.proceed
                                : GenericButtonType
                                    .semiProceed, // CHANGES BUTTON TYPE BY CHECKING ALL THE RESTRICTIONS
                          ), // REGISTER BUTTON
                          GenericButton(
                            label: 'Back',
                            function: () => Navigator.pop(context),
                            type: GenericButtonType
                                .generic, // Set your desired color
                          ), // BACK BUTTON
                        ],
                      ), // BUTTONS AT BOTTOM
                    ],
                  ), // ALL REGISTRATION ELEMENTS ARE HERE
                ), // ALL REGISTRATION ELEMENTS ARE HERE
              ), // ALL REGISTRATION ELEMENTS ARE HERE
      ),
    );
  }
}
