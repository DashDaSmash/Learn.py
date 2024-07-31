import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:learn_py/ThemeData.dart';
import 'package:url_launcher/url_launcher.dart';
import '../Objects/GenericButton.dart';
import '../main.dart';

// ignore: must_be_immutable
class LiscenseAndCredits extends StatelessWidget {
  LiscenseAndCredits({super.key});

  List LicenseAndCreditsData = [
    // 'image': 'EMPTY' property is used in case image link is not provided
    {
      'title': 'App Icon',
      'image': 'assets/appIcon.png',
      'description': 'Created by me. All rights reserved.',
      'link':
          'https://www.deviantart.com/dashingsloth/art/Learn-py-app-icon-1081249906',
    },
    {
      'title': 'App Icon with Border',
      'image': 'assets/Learn.py border T.png',
      'description': 'Created by me. All rights reserved.',
      'link':
          'https://www.deviantart.com/dashingsloth/art/Learn-py-with-border-on-white-background-1081263649',
    },
    {
      'title': 'Splash screen gif',
      'image': 'assets/Learn.py.gif',
      'description': 'Created by me. All rights reserved.',
      'link':
          'https://www.deviantart.com/dashingsloth/art/Learn-py-app-icon-1081249906',
    },
    {
      'title': 'Donation Successful gif',
      'image': 'assets/donation.gif',
      'description':
          'Inspired by and irinabalashova\'s png art.\nGIF created by me.',
      'link':
          'https://www.deviantart.com/dashingsloth/art/Thanks-for-your-donations-gif-1081246927',
    },
    {
      'title': 'Inspired by Duolingo',
      'image': 'EMPTY',
      'description':
          ' “Duolingo - The world\'s best way to learn a language” | Duolingo. Duolingo - The world\'s best way to learn a language (accessed Jul.03,2024).',
      'link': 'https://www.duolingo.com/',
    },
    {
      'title': 'Resource used in quizzes and Directly linked in Notes screen',
      'image': 'EMPTY',
      'description':
          'University of Colombo, GCE Advanced Level ICT Python- English mediam - 2019 onwards New syllabus Advanced Level Sri Lankan - Studocu | Studocu. https://www.studocu.com/row/document/university-of-colombo/python-and-r/gce-advanced-level-ict-python-english-mediam/16544114 (accessed Jul.03,2024).',
      'link':
          'https://www.studocu.com/row/document/university-of-colombo/python-and-r/gce-advanced-level-ict-python-english-mediam/16544114',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        scrolledUnderElevation: 0.0,
        elevation: 0.0,
        automaticallyImplyLeading: false,
        centerTitle: true,
        backgroundColor: themeData().backgroundColor,
        title: Text(
          'License and Credits',
          style: TextStyle(
            color: Color(0xFF00FF29),
            fontSize: 30,
            fontWeight: FontWeight.bold,
            shadows: [
              Shadow(
                color: Colors.grey,
                offset: Offset(2, 2),
                blurRadius: 6,
              ),
            ],
          ),
        ),
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                for (int i = 0; i < LicenseAndCreditsData.length; i++)
                  // WITH THIS LOOP, WE USE SAME WIDGETS TO GENERATE AND SHOW DETAILS IN COLUMNS
                  Column(
                    children: [
                      i == 0 ? SizedBox(height: 50) : SizedBox.shrink(),
                      Text(
                        LicenseAndCreditsData[i]['title'],
                        style: themeData().genericBigTextStyle,
                        textAlign: TextAlign.center,
                      ), // TITLE
                      LicenseAndCreditsData[i]['image'] != 'EMPTY'
                          ? Image.asset(
                              LicenseAndCreditsData[i]['image'],
                              width: 200,
                              height: 200,
                            )
                          : SizedBox.shrink(), // IMAGE
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: Text(
                          LicenseAndCreditsData[i]['description'],
                          style: themeData().genericTextStyle,
                          textAlign: TextAlign.justify,
                        ),
                      ),
                      TextButton(
                        onPressed: () async {
                          if (await canLaunch(
                              LicenseAndCreditsData[i]['link'])) {
                            await launch(LicenseAndCreditsData[i]['link']);
                          } else {
                            print(
                                'Could not launch ${LicenseAndCreditsData[i]['link']}');
                          }
                        },
                        child: Text(
                          LicenseAndCreditsData[i]['link'],
                        ),
                        style: ButtonStyle(
                          overlayColor:
                              MaterialStateProperty.all(Color(0xFF80FE94)),
                        ),
                      ), // LINK
                      i != LicenseAndCreditsData.length - 1
                          ? Divider()
                          : SizedBox(height: 100),
                    ],
                  ), // ITEMS IN EACH SET OF DETAILS
              ],
            ),
          ), // THIS IS WHERE ALL THE CONTENT IS AT
          Positioned(
            child: Container(
              width: double.infinity,
              height: 50,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: [
                    themeData()
                        .backgroundColor
                        .withOpacity(0), // Transparent at the bottom
                    themeData().backgroundColor, // Green at the top
                  ],
                ),
              ),
            ),
          ), // FADING AT THE TOP
          Positioned(
              bottom: 0,
              child: Container(
                width: MediaQuery.sizeOf(context).width,
                height: 100,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.white.withOpacity(0.0),
                      Colors.white // Green at the top
                    ],
                  ),
                ),
              )), // FADING CONTAINER AT THE END
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
    );
  }
}
