import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:another_flutter_splash_screen/another_flutter_splash_screen.dart';
import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import 'package:learn_py/Screens/DiscoverScreen.dart';
import 'package:learn_py/Screens/NotesScreen.dart';
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

// FOLLOWING DATA TYPE IS USED TO IDENTIFY WHAT KIND OF BUTTON SHOULD BE PLACED
// THERE ARE PRESETS FOR EACH TYPE IN ThemeData()
enum GenericButtonType { generic, proceed, semiProceed, warning, semiWarning }

String userEmail = '';
String displayName = '';
Map<String, dynamic> fireStoreGuideSheetMap = {};

void main() async {
  // EVEN THOUGH THIS IS NOT THE BEST PRACTICE, WE RUN APP BEFORE ALL THE WIDGETS ARE BOUND.
  // THE REASON IS THAT WE HAVE A SPLASH SCREEN WHICH HAS ITS WIDGETS BOUND ALREADY.
  // BY THE TIME SPLASH SCREEN FINISHES, WE EXPECT THE APP TO BE READY AS IT IS INITIALIZED IN BACKGROUND.
  runApp(
    MaterialApp(
      initialRoute: '/', // Start with the FirstScreen
      routes: {
        '/': (context) => const SplashScreen(),
        '/login': (context) => const LoginScreen(),
        '/emailVerify': (context) => const EmailVerificationScreen(),
        '/home': (context) => const HomeScreen(),
        '/profile': (context) => const ProfileScreen(),
        '/discover': (context) => const DiscoverScreen(),
        '/notes': (context) => const NotesScreen(),
        '/quiz': (context) {
          final args = ModalRoute.of(context)?.settings.arguments;
          final quizId = args as int;
          return QuizScreen(quizId: quizId);
        },
        '/quizCatalog': (context) => const QuizCatalogScreen(),
        '/playground': (context) => const PlaygroundScreen(),
        '/external': (context) => const ExternalLibrariesScreen(),
        '/about': (context) => const AboutScreen(),
        '/registration': (context) => const RegistrationScreen(),
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
        '/donate': (context) => const PaypalPayment(),
        '/credits': (context) => LiscenseAndCredits(),
      },
    ),
  );
  WidgetsFlutterBinding.ensureInitialized();
  // THIS APP IS MADE TO WORK IN PORTRAIT MODE AT ALL TIMES
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My App',
      // THE FOLLOWING CODE LISTENS TO STREAM FOR ANY CHANGES IN FIREBASE AUTHENTICATION
      home: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.active) {
            final user = snapshot.data;
            if (user == null) {
              // NOT LOGGED IN
              return const LoginScreen();
            } else if (user.emailVerified) {
              userEmail = user.email!;
              // LOGGED IN WITH VERIFIED EMAIL
              return const HomeScreen();
            } else {
              // LOGGED IN BUT EMAIL NOT VERIFIED YET
              return const EmailVerificationScreen();
            }
          }

          // WHEN CONNECTION IS NOT ACTIVE SHOW LOADING SCREEN
          return Center(
            child: LoadingAnimationWidget.threeRotatingDots(
              color: const Color(0xFF80FE94),
              size: 30.0,
            ),
          );
        },
      ),
    );
  }
}

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  // THIS SCREEN IS SHOWN BEFORE USER GO TO HOME SCREEN.
  // BEFORE THIS, A FAKE SPLASH SCREEN IS SHOWN
  @override
  Widget build(BuildContext context) {
    return FlutterSplashScreen.gif(
      gifPath: 'assets/Learn.py.gif',
      backgroundColor: Colors.white,
      gifWidth: 500,
      gifHeight: 500,
      useImmersiveMode: true,
      nextScreen: const MyApp(),
      asyncNavigationCallback: () async {
        await Future.delayed(const Duration(milliseconds: 4000));
        await Firebase.initializeApp();
        // APP CHECK IS NOT FULLY CONFIGURED YET
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
