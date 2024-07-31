import 'package:another_flutter_splash_screen/another_flutter_splash_screen.dart';
import 'package:firebase_app_check/firebase_app_check.dart';
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
import 'Screens/EmailVerificationScreen.dart';

//TODO: Guide user after registration

//TODO:    CHnage app icon and splash screen

enum GenericButtonType { generic, proceed, semiProceed, warning, semiWarning }

String userEmail = '';
String displayName = '';
Map<String, dynamic> fireStoreGuideSheetMap = {};

void main() async {
  runApp(
    MaterialApp(
      initialRoute: '/', // Start with the FirstScreen
      routes: {
        '/': (context) => SplashScreen(),
        '/login': (context) => LoginScreen(),
        '/emailVerify': (context) => EmailVerificationScreen(),
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
  WidgetsFlutterBinding.ensureInitialized();
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
            } else if (user.emailVerified) {
              print('User email: ${user.email}');
              userEmail = user.email!;
              // User is logged in. Navigate to the home page.

              // Show content for verified users
              return HomeScreen();
            } else {
              // Show content for unverified users
              return EmailVerificationScreen();
            }
          }

          // While the connection state is not active, show a loading indicator.
          return CircularProgressIndicator();
        },
      ),
    );
  }
}

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FlutterSplashScreen.gif(
      gifPath: 'assets/Learn.py.gif', // Path to your GIF
      backgroundColor: Colors.white,
      gifWidth: 500, // Width of the GIF
      gifHeight: 500, // Height of the GIF
      useImmersiveMode: true,
      nextScreen: MyApp(), // Your next screen after the splash
      asyncNavigationCallback: () async {
        await Future.delayed(Duration(milliseconds: 4000));
        await Firebase.initializeApp();
        await FirebaseAppCheck.instance.activate(
          // You can also use a `ReCaptchaEnterpriseProvider` provider instance as an
          // argument for `webProvider`

          webProvider: ReCaptchaV3Provider('recaptcha-v3-site-key'),
          // Default provider for Android is the Play Integrity provider. You can use the "AndroidProvider" enum to choose
          // your preferred provider. Choose from:
          // 1. Debug provider
          // 2. Safety Net provider
          // 3. Play Integrity provider
          androidProvider: AndroidProvider.debug,
          // Default provider for iOS/macOS is the Device Check provider. You can use the "AppleProvider" enum to choose
          // your preferred provider. Choose from:
          // 1. Debug provider
          // 2. Device Check provider
          // 3. App Attest provider
          // 4. App Attest provider with fallback to Device Check provider (App Attest provider is only available on iOS 14.0+, macOS 14.0+)
          appleProvider: AppleProvider.appAttest,
        );
      },
      // duration: const Duration(milliseconds: 4200), // Duration of the splash
      onInit: () async {
        // Optional initialization callback
        debugPrint("Splash screen initialized");
      },
      onEnd: () async {
        // Optional callback when splash ends
        debugPrint("Splash screen ended");
      },
    );
  }
}
