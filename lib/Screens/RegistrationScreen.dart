import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class RegistrationScreen extends StatefulWidget {
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  TextEditingController _passwordController = TextEditingController();
  bool _isPasswordStrongEnough = false;
  String _firstName = '';
  String _lastName = '';
  String _email = '';

  Future<void> _registerUser() async {
    try {
      await _auth.createUserWithEmailAndPassword(
        email: _email,
        password: _passwordController.text,
      );

      await FirebaseFirestore.instance.collection('users').doc(_email).set({
        'FirstName': _firstName,
        'LastName': _lastName,
        'LastUnlockedQuiz': 1,
        'QuizScores': {},
      });

      // Send verification email (uncomment if needed)
      // await newUser.user!.sendEmailVerification();
      registrationComplete();
    } catch (e) {
      print('Error: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Registration failed. Please try again.')),
      );
    }
  }

  void registrationComplete() {
    Navigator.pop(context);
    Navigator.of(context, rootNavigator: true).pushNamed('/home');
  }

  bool _checkPasswordStrength(String password) {
    // Implement your password strength logic here.
    // For example, check for minimum length, uppercase, lowercase, digits, etc.
    // Return true if the password is strong enough, otherwise false.
    return password.length >= 8; // Example: Minimum length of 8 characters.
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Registration')),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  decoration: InputDecoration(labelText: 'First Name'),
                  validator: (value) {
                    if (value!.isEmpty) return 'Please enter your first name';
                    return null;
                  },
                  onChanged: (value) => _firstName = value,
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Last Name'),
                  validator: (value) {
                    if (value!.isEmpty) return 'Please enter your last name';
                    return null;
                  },
                  onChanged: (value) => _lastName = value,
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Email'),
                  validator: (value) {
                    if (value!.isEmpty || !value.contains('@'))
                      return 'Please enter a valid email address';
                    return null;
                  },
                  onChanged: (value) => _email = value,
                ),
                TextFormField(
                  controller: _passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: 'Enter Password',
                  ),
                  onChanged: (value) {
                    setState(() {
                      _isPasswordStrongEnough = _checkPasswordStrength(value);
                    });
                  },
                ),
                ElevatedButton(
                  onPressed: _registerUser,
                  child: Text('Register'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
