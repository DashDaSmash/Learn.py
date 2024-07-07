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
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  String _firstName = '';
  String _lastName = '';
  String _email = '';

  Future<void> _registerUser() async {
    if (_formKey.currentState!.validate()) {
      try {
        final newUser = await _auth.createUserWithEmailAndPassword(
          email: _email,
          password: 'temporaryPassword', // Generate a temporary password
        );

        // Store additional user data in Firestore
        await _firestore.collection('users').doc(newUser.user!.uid).set({
          'firstName': _firstName,
          'lastName': _lastName,
          'isEmailVerified': false,
        });

        // Send verification email
        await newUser.user!.sendEmailVerification();
      } catch (e) {
        print('Error: $e');
        // Handle registration errors (e.g., email already exists)
        // Show an error message to the user
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Registration failed. Please try again.')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Registration')),
      body: Padding(
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
              ElevatedButton(
                  onPressed: () {
                    _registerUser;
                    Navigator.of(context, rootNavigator: true)
                        .pushNamed('/password');
                  },
                  child: Text('Register')),
            ],
          ),
        ),
      ),
    );
  }
}
