import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:url_launcher/url_launcher.dart';
import '../Objects/GeminiAI.dart';
import '../Objects/GenericButton.dart';
import 'package:flutter/services.dart';

import '../main.dart';

class NotesScreen extends StatefulWidget {
  const NotesScreen({Key? key}) : super(key: key);

  @override
  State<NotesScreen> createState() => _DiscoverScreenState();
}

class _DiscoverScreenState extends State<NotesScreen> {
  List<String> imageUrls = [];
  List<String> imageNames = [];
  bool doneFetichingImages = false;

  // Future<void> _fetchNotesImages() async {
  //   final storageRef = FirebaseStorage.instance.ref();
  //   try {
  //     for (String imageName in imageNames)
  //       final imageUrl =
  //           await storageRef.child('notes/$imageName.jpg').getDownloadURL();
  //     // imageUrls.add(imageUrl);
  //   } catch (e) {
  //     print('Error fetching images: $e');
  //     imageUrls.add('');
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFECFFF0),
      body: SafeArea(
        child: Stack(
          children: [
            Column(
              children: [
                Expanded(
                  flex: 2,
                  // child: Placeholder(),
                  child: Column(
                    children: [
                      Text(
                        'Hungry for knowledge bytes!?!',
                        style: TextStyle(
                            color: Color(0xFF3C3C3C),
                            fontSize: 20,
                            fontWeight: FontWeight.w500),
                      ),
                      Expanded(
                        child: Container(
                          margin: EdgeInsets.all(10),
                          // height: 300,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                color: Color(0xFFBDCEC1),
                                blurRadius: 5,
                                spreadRadius: 2,
                                offset: Offset(0, 2),
                              ),
                            ],
                            border: Border.all(
                              color: Color(0xFF00B71D),
                              width: 2,
                            ),
                          ),
                          child: Center(
                            child: GeminiAI(
                              prompt:
                                  'Give me a new tip for Python programming',
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 10),
                Text(
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
                  child: Container(
                    width: double.infinity,
                    // child: Placeholder(),
                    child: StreamBuilder<QuerySnapshot>(
                        stream: FirebaseFirestore.instance
                            .collection('notes')
                            .snapshots(),
                        builder: (context, snapshot) {
                          if (!snapshot.hasData) {
                            return CircularProgressIndicator(); // Show loading indicator
                          }

                          final notes =
                              snapshot.data!.docs; // List of documents

                          return ListView.builder(
                            itemCount: notes.length,
                            itemBuilder: (context, index) {
                              // doneFetichingImages ? () {} : _fetchNotesImages();
                              final note = notes[index];
                              final title = note['Title'];
                              final content = note['Content']
                                  .replaceAll(r'\n', '\n')
                                  .replaceAll(r'\t', '\t\t\t\t\t\t\t');

                              return GestureDetector(
                                  onTap: () async {
                                    final resourceUrl = note[
                                        'ResourceLink']; // Assuming the article URL is available
                                    if (await canLaunch(resourceUrl)) {
                                      await launch(resourceUrl);
                                    } else {
                                      print('Could not launch $resourceUrl');
                                    }
                                  },
                                  child: Container(
                                    margin: EdgeInsets.all(
                                        5.0), // Add vertical spacing
                                    decoration: BoxDecoration(
                                      color: Color(
                                          0xFFB4FFC0), // Set your desired background color
                                      borderRadius: BorderRadius.circular(
                                          10.0), // Rounded corners
                                      boxShadow: [
                                        BoxShadow(
                                          blurRadius: 5,
                                          color: Colors.black26,
                                          offset: Offset(
                                              2, 2), // Add a subtle shadow
                                        ),
                                      ],
                                      border: Border.all(
                                        color: Color(0xFF00B71D),
                                        width: 2,
                                      ),
                                    ),
                                    child: ListTile(
                                      title: Column(
                                        children: [
                                          Text(
                                            title,
                                            style: TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.w500,
                                                color: Color(0xFF00CE2D)),
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
                                        style: TextStyle(fontSize: 18),
                                      ),
                                    ),
                                  ));
                            },
                          );
                        }),
                  ),
                ),
              ],
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
            ),
          ],
        ),
      ),
    );
  }
}
