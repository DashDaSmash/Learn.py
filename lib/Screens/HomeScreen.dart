import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:learn_py/Objects/HomeScreenButtons.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import '../ThemeData.dart';
import '../main.dart';

//TODO:    MAKE HORIZONTAL VIEW AS WELL
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isDonefetchingGuideSheetMap = false;

  Future<void> setupUserDocumentInFirebase() async {
    User? currentUser = FirebaseAuth.instance.currentUser;

    if (displayName == '')
      try {
        displayName = currentUser!.displayName!;
      } catch (e) {}

    final DocumentReference docRef =
        FirebaseFirestore.instance.collection('users').doc(currentUser!.email);

    docRef.get().then((DocumentSnapshot snapshot) async {
      if (snapshot.exists) {
        print('User exists!');
        fetchVisitedScreens();
      } else {
        print('It\'s a new user');
        // SETUP A FIRESTORE DOCUMENT WITH USER'S EMAIL AS DOC ID
        // THIS IS REQUIRED FOR FURTHER FUNCTIONALITY
        Map<String, dynamic> fireStoreGuideSheetMap = {
          'Name': displayName,
          'LastUnlockedQuiz': 1,
          'QuizScores': {},
          'ShowGuideSheet': {
            'AboutScreen': true,
            'DiscoveryScreen': true,
            'HomeScreen': true,
            'ProfileScreen': true,
            'QuizCatalogScreen': true,
            'QuizScreen': true,
            'NotesScreen': true,
          }
        };

        await FirebaseFirestore.instance
            .collection('users')
            .doc(currentUser.email)
            .set(fireStoreGuideSheetMap);

        isDonefetchingGuideSheetMap = true;
        setState(() {});
      }
    });
  }

  Future<void> fetchVisitedScreens() async {
    final userRef =
        FirebaseFirestore.instance.collection('users').doc(userEmail);
    final userDoc = await userRef.get();

    // STORE DATA IN A MAP
    fireStoreGuideSheetMap = userDoc.data()?['ShowGuideSheet'];

    isDonefetchingGuideSheetMap = true;
    setState(() {});
  } // FETCH ALL DATA ABOUT CURRENT USER'S GUIDE SHEETS

  @override
  void initState() {
    super.initState();
    setupUserDocumentInFirebase();
  }

  @override
  Widget build(BuildContext context) {
    // Implement your home page UI here.
    return Stack(
      children: [
        Scaffold(
          backgroundColor: themeData().backgroundColor,
          appBar: AppBar(
            backgroundColor: themeData().backgroundColor,
            automaticallyImplyLeading: false,
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
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              // mainAxisAlignment: MainAxisAlignment.stretch,
              children: [
                Expanded(
                  child: Column(
                    children: [
                      HomeScreenButton(
                          flex: 5,
                          color: Color(0xFFB4FFC0),
                          strokeColor: Color(0xFF58BF68),
                          text: 'Discover',
                          icon: CupertinoIcons.sparkles,
                          orientation: 'vertical',
                          route: '/discover'),
                      HomeScreenButton(
                          flex: 6,
                          color: Color(0xFFEEEEEE),
                          strokeColor: Color(0xFFA3A3A3),
                          text: 'Notes',
                          icon: Icons.note_alt_rounded,
                          orientation: 'vertical',
                          route: '/notes'),
                      HomeScreenButton(
                          flex: 4,
                          color: Color(0xFFB4FFC0),
                          strokeColor: Color(0xFF58BF68),
                          text: 'Profile',
                          icon: CupertinoIcons.profile_circled,
                          orientation: 'vertical',
                          route: '/profile'),
                    ],
                  ),
                ),
                Expanded(
                    child: Column(
                  children: [
                    HomeScreenButton(
                        flex: 3,
                        color: Color(0xFFD9D9D9),
                        strokeColor: Color(0xFFA3A3A3),
                        text: 'Quiz',
                        icon: CupertinoIcons.text_badge_star,
                        orientation: 'horizontal',
                        route: '/quizCatalog'),
                    HomeScreenButton(
                        flex: 5,
                        color: Color(0xFF80FE94),
                        strokeColor: Color(0xFF58BF68),
                        text: "Playground",
                        icon: CupertinoIcons.play,
                        orientation: 'vertical',
                        route: '/playground'),
                    HomeScreenButton(
                        flex: 4,
                        color: Color(0xFFD9D9D9),
                        strokeColor: Color(0xFFA3A3A3),
                        text: "External\nlibraries",
                        icon: Icons.extension_rounded,
                        orientation: 'vertical',
                        route: '/external'),
                    HomeScreenButton(
                        flex: 2,
                        color: Color(0xFFFFFFFF),
                        strokeColor: Color(0xFF00CE2D),
                        text: "About",
                        icon: Icons.info_outline_rounded,
                        orientation: 'horizontal',
                        route: '/about')
                  ],
                )),
              ],
            ),
          ),
          // body: GestureDetector(
          //   onTap: () =>
          //       Navigator.of(context, rootNavigator: true).pushNamed('/profile'),
          //   child: Container(
          //     color: Colors.green,
          //     width: 100,
          //     height: 100,
          //   ),
          // ),
          //
          //
          // body: Center(
          //   child: ElevatedButton(
          //     onPressed: signOut,
          //     child: Text('Sign Out'),
          //   ),
          // ),
        ),
        isDonefetchingGuideSheetMap
            ? SizedBox.shrink()
            : Container(
                color: Colors.white.withOpacity(0.5),
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: Center(
                    child: LoadingAnimationWidget.threeRotatingDots(
                  color: Color(0xFF80FE94), // Set your desired color
                  size: 50.0, // Set the size of the animation
                )),
              )
      ],
    );
  }
}
