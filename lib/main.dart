import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:learn_py/Screens/DiscoverScreen.dart';
import 'package:learn_py/Screens/NotesScreen.dart';
import 'package:learn_py/Screens/PasswordSetupScreen.dart';
import 'package:learn_py/Screens/QuizCatalogScreen.dart';
import 'package:learn_py/Screens/QuizScreen.dart';
import 'package:learn_py/Screens/PlaygroundScreen.dart';
import 'package:learn_py/Screens/ExternalLibrariesScreen.dart';
import 'package:learn_py/Screens/AboutScreen.dart';
import 'package:learn_py/Screens/RegistrationScreen.dart';
import 'package:learn_py/Screens/QuizGradingScreen.dart';
import 'Screens/HomeScreen.dart';
import 'Screens/LoginScreen.dart';
import 'Screens/ProfileScreen.dart';
import 'Screens/Paypal.dart';
import 'Screens/LicenseAndCreditsScreen.dart';

//TODO: Guide user after registration

enum GenericButtonType { generic, proceed, semiProceed, warning, semiWarning }

String userEmail = '';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    MaterialApp(
      initialRoute: '/', // Start with the FirstScreen
      routes: {
        '/': (context) => MyApp(),
        '/login': (context) => LoginScreen(),
        '/home': (context) => HomeScreen(),
        '/profile': (context) => ProfileScreen(),
        '/discover': (context) => DiscoverScreen(),
        '/notes': (context) => NotesScreen(),
        '/quiz': (context) {
          final args = ModalRoute.of(context)?.settings.arguments;
          final quizId = args as int;
          return QuizScreen(quizId: quizId);
        },
        '/quizCatalog': (context) => QuizCatalogScreen(),
        '/playground': (context) => PlaygroundScreen(),
        '/external': (context) => ExternalLibrariesScreen(),
        '/about': (context) => AboutScreen(),
        '/registration': (context) => RegistrationScreen(),
        '/password': (context) => PasswordSetupScreen(),
        '/grading': (context) {
          final args = ModalRoute.of(context)?.settings.arguments;
          if (args is Map<String, int>) {
            final score = args['score'];
            final quizId = args['quizId'];
            return QuizGradingScreen(score: score!, quizId: quizId!);
          } else {
            // Handle invalid arguments
            return Container(); // Replace with appropriate widget
          }
        },
        '/donate': (context) => PaypalPayment(),
        '/credits': (context) => LiscenseAndCredits(),
      },
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My App',
      home: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.active) {
            final user = snapshot.data;
            if (user == null) {
              // User is not logged in. Show the login screen.
              return LoginScreen();
            } else {
              print('User email: ${user.email}');
              userEmail = user.email!;
              // User is logged in. Navigate to the home page.
              return HomeScreen();
            }
          }
          // While the connection state is not active, show a loading indicator.
          return CircularProgressIndicator();
        },
      ),
    );
  }
}
