import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import 'package:learn_py/Objects/GuideSheet.dart';
import 'package:learn_py/ThemeData.dart';
import 'package:url_launcher/url_launcher_string.dart';
import '../Objects/GeminiAI.dart';
import '../Objects/GenericButton.dart';
import '../main.dart';

class NotesScreen extends StatefulWidget {
  const NotesScreen({super.key});

  @override
  State<NotesScreen> createState() => _DiscoverScreenState();
}

class _DiscoverScreenState extends State<NotesScreen> {
  List<String> imageUrls = [];
  List<String> imageNames = [];
  bool doneFetichingImages = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFECFFF0),
      body: Stack(
        children: [
          SafeArea(
            child: Column(
              children: [
                Expanded(
                  flex: 2,
                  // child: Placeholder(),
                  child: Column(
                    children: [
                      const Text(
                        'Hungry for knowledge bytes!?!',
                        style: TextStyle(
                            color: Color(0xFF3C3C3C),
                            fontSize: 20,
                            fontWeight: FontWeight.w500),
                      ),
                      Expanded(
                        child: Container(
                          margin: const EdgeInsets.all(10),
                          // height: 300,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: const [
                              BoxShadow(
                                color: Color(0xFFBDCEC1),
                                blurRadius: 5,
                                spreadRadius: 2,
                                offset: Offset(0, 2),
                              ),
                            ],
                            border: Border.all(
                              color: const Color(0xFF00B71D),
                              width: 2,
                            ),
                          ),
                          child: Center(
                            child: Stack(
                              children: [
                                const GeminiAI(
                                  prompt:
                                      'Give me a new tip for Python programming',
                                ),
                                Positioned(
                                  bottom: 0,
                                  child: Container(
                                    height: 30,
                                    decoration: BoxDecoration(
                                      borderRadius: const BorderRadius.only(
                                          bottomLeft: Radius.circular(10),
                                          bottomRight: Radius.circular(10)),
                                      gradient: LinearGradient(
                                        begin: Alignment.topCenter,
                                        end: Alignment.bottomCenter,
                                        colors: [
                                          Colors.white.withOpacity(
                                              0), // Transparent at the bottom
                                          Colors.white, // Green at the top
                                        ],
                                      ),
                                    ),
                                  ),
                                ) // FADING EFFECT
                              ],
                            ),
                          ),
                        ),
                      ), // AI BOX
                    ],
                  ),
                ), // TIPS WITH GEMINI AI
                const SizedBox(height: 10),
                const Text(
                  'Resources',
                  style: TextStyle(
                    color: Color(0xFF3C3C3C),
                    fontWeight: FontWeight.w500,
                    fontSize: 20,
                  ),
                ),
                Expanded(
                  flex: 3,
                  // child: Placeholder(),
                  child: SizedBox(
                    width: double.infinity,
                    // child: Placeholder(),
                    child: Stack(
                      children: [
                        StreamBuilder<QuerySnapshot>(
                          stream: FirebaseFirestore.instance
                              .collection('notes')
                              .snapshots(),
                          builder: (context, snapshot) {
                            if (!snapshot.hasData) {
                              return LoadingAnimationWidget.threeRotatingDots(
                                color: const Color(
                                    0xFF80FE94), // Set your desired color
                                size: 30.0, // Set the size of the animation
                              ); // Show loading indicator
                            }

                            final notes =
                                snapshot.data!.docs; // List of documents

                            return ListView.builder(
                              itemCount: notes.length,
                              itemBuilder: (context, index) {
                                // doneFetichingImages ? () {} : _fetchNotesImages();
                                final note = notes[index];
                                final title = note['Title'];
                                final content =
                                    note['Content'].replaceAll(r'\n', '\n');

                                return index ==
                                        notes.length -
                                            1 //IF ITS THE LAST NOTE, ADD EMPTY SPACE AT BOTTOM
                                    ? Column(
                                        children: [
                                          GestureDetector(
                                              onTap: () async {
                                                final resourceUrl = note[
                                                    'ResourceLink']; // Assuming the article URL is available
                                                if (await canLaunchUrlString(
                                                    resourceUrl)) {
                                                  await launchUrlString(
                                                      resourceUrl);
                                                }
                                              },
                                              child: Container(
                                                margin: const EdgeInsets.all(
                                                    5.0), // Add vertical spacing
                                                decoration: BoxDecoration(
                                                  color: const Color(
                                                      0xFFB4FFC0), // Set your desired background color
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10.0), // Rounded corners
                                                  boxShadow: const [
                                                    BoxShadow(
                                                      blurRadius: 5,
                                                      color: Colors.black26,
                                                      offset: Offset(2,
                                                          2), // Add a subtle shadow
                                                    ),
                                                  ],
                                                  border: Border.all(
                                                    color:
                                                        const Color(0xFF00B71D),
                                                    width: 2,
                                                  ),
                                                ),
                                                child: ListTile(
                                                  title: Column(
                                                    children: [
                                                      Text(
                                                        title,
                                                        style: const TextStyle(
                                                            fontSize: 20,
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            color: Color(
                                                                0xFF00CE2D)),
                                                      ),
                                                    ],
                                                  ),
                                                  subtitle: Text(
                                                    content,
                                                    style: const TextStyle(
                                                        fontSize: 18),
                                                  ),
                                                ),
                                              )),
                                          const SizedBox(height: 60),
                                        ],
                                      )
                                    : index ==
                                            0 // IF THE NOTE IS THE FIRST ONE, ADD EMPTY SPACE AT TOP
                                        ? Column(
                                            children: [
                                              const SizedBox(height: 30),
                                              GestureDetector(
                                                  onTap: () async {
                                                    final resourceUrl = note[
                                                        'ResourceLink']; // Assuming the article URL is available
                                                    if (await canLaunchUrlString(
                                                        resourceUrl)) {
                                                      await canLaunchUrlString(
                                                          resourceUrl);
                                                    }
                                                  },
                                                  child: Container(
                                                    margin: const EdgeInsets
                                                        .all(
                                                        5.0), // Add vertical spacing
                                                    decoration: BoxDecoration(
                                                      color: const Color(
                                                          0xFFB4FFC0), // Set your desired background color
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10.0), // Rounded corners
                                                      boxShadow: const [
                                                        BoxShadow(
                                                          blurRadius: 5,
                                                          color: Colors.black26,
                                                          offset: Offset(2,
                                                              2), // Add a subtle shadow
                                                        ),
                                                      ],
                                                      border: Border.all(
                                                        color: const Color(
                                                            0xFF00B71D),
                                                        width: 2,
                                                      ),
                                                    ),
                                                    child: ListTile(
                                                      title: Column(
                                                        children: [
                                                          Text(
                                                            title,
                                                            style: const TextStyle(
                                                                fontSize: 20,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                                color: Color(
                                                                    0xFF00CE2D)),
                                                          ),
                                                          // Image.network(
                                                          //   imageUrl,
                                                          //   height: 160,
                                                          //   width: 160,
                                                          // ),
                                                        ],
                                                      ),
                                                      subtitle: Text(
                                                        content,
                                                        style: const TextStyle(
                                                            fontSize: 18),
                                                      ),
                                                    ),
                                                  )),
                                            ],
                                          )
                                        : GestureDetector(
                                            onTap: () async {
                                              final resourceUrl = note[
                                                  'ResourceLink']; // Assuming the article URL is available
                                              if (await canLaunchUrlString(
                                                  resourceUrl)) {
                                                await launchUrlString(
                                                    resourceUrl);
                                              }
                                            },
                                            child: Container(
                                              margin: const EdgeInsets.all(
                                                  5.0), // Add vertical spacing
                                              decoration: BoxDecoration(
                                                color: const Color(
                                                    0xFFB4FFC0), // Set your desired background color
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        10.0), // Rounded corners
                                                boxShadow: const [
                                                  BoxShadow(
                                                    blurRadius: 5,
                                                    color: Colors.black26,
                                                    offset: Offset(2,
                                                        2), // Add a subtle shadow
                                                  ),
                                                ],
                                                border: Border.all(
                                                  color:
                                                      const Color(0xFF00B71D),
                                                  width: 2,
                                                ),
                                              ),
                                              child: ListTile(
                                                title: Column(
                                                  children: [
                                                    Text(
                                                      title,
                                                      style: const TextStyle(
                                                          fontSize: 20,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          color: Color(
                                                              0xFF00CE2D)),
                                                    ),
                                                    // Image.network(
                                                    //   imageUrl,
                                                    //   height: 160,
                                                    //   width: 160,
                                                    // ),
                                                  ],
                                                ),
                                                subtitle: Text(
                                                  content,
                                                  style: const TextStyle(
                                                      fontSize: 18),
                                                ),
                                              ),
                                            ));
                              },
                            );
                          },
                        ), // NOTES
                        Positioned(
                          child: Container(
                            width: double.infinity,
                            height: 50,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.bottomCenter,
                                end: Alignment.topCenter,
                                colors: [
                                  themeData().backgroundColor.withOpacity(
                                      0), // Transparent at the bottom
                                  themeData()
                                      .backgroundColor, // Green at the top
                                ],
                              ),
                            ),
                          ),
                        ), // FADING EFFECT
                      ],
                    ),
                  ),
                ), // NOTES PART OF THE SCREEN
              ],
            ),
          ),
          Positioned(
            bottom: 8, // Adjust the position as needed
            left: 8, // Adjust the position as needed
            right: 8, // Adjust the position as needed
            child: //BackButton
                //BackButton
                GenericButton(
              label: 'Back',
              function: () => Navigator.pop(context),
              type: GenericButtonType.generic, // Set your desired color
            ),
          ), // BACK BUTTON
          GuideSheet(currentScreen: 'NotesScreen'),
        ],
      ),
    );
  }
}
