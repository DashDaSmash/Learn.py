// VALUES FOR CURRENT SCREEN STRING:
//                  DiscoveryScreen

//TODO: make sure at add all guide screens to user registration

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:learn_py/Objects/GenericButton.dart';
import 'package:learn_py/ThemeData.dart';

import '../main.dart';

// ignore: must_be_immutable
class GuideSheet extends StatefulWidget {
  String currentScreen = 'DiscoveryScreen';
  Widget guideSheetWidget = SizedBox.shrink();

  GuideSheet({required this.currentScreen});

  @override
  State<GuideSheet> createState() => _GuideSheetState();
}

class _GuideSheetState extends State<GuideSheet> {
  int? totalPages;
  int currentPage = 1;

  void assignVariables(var guideDataSet) {
    totalPages = guideDataSet['totalPages'];
  } // THIS SETS UP totalPages VARIABLE

  void checkGuideSheetForCurrentScreen() {
    // REPEAT WITH SCREENS
    for (String key in fireStoreGuideSheetMap.keys) {
      // CHECK IF THIS SCREEN IS WHAT IS BEING DISPLAYED RN
      // AND ALSO IF WE SHOULD SHOW GUIDE SHEET
      if (key == widget.currentScreen && fireStoreGuideSheetMap[key]) {
        // CHECK FOR SEPARATE VALUES
        if (widget.currentScreen == 'DiscoveryScreen') {
          assignVariables(guideData().DiscoveryScreen);
          guideSheetStamp(guideData().DiscoveryScreen);
        } else if (widget.currentScreen == 'QuizScreen') {
          assignVariables(guideData().QuizScreen);
          guideSheetStamp(guideData().QuizScreen);
        } else if (widget.currentScreen == 'ProfileScreen') {
          assignVariables(guideData().ProfileScreen);
          guideSheetStamp(guideData().ProfileScreen);
        } else if (widget.currentScreen == 'QuizCatalogScreen') {
          assignVariables(guideData().QuizCatalogScreen);
          guideSheetStamp(guideData().QuizCatalogScreen);
        } else if (widget.currentScreen == 'AboutScreen') {
          assignVariables(guideData().AboutScreen);
          guideSheetStamp(guideData().AboutScreen);
        } else if (widget.currentScreen == 'NotesScreen') {
          assignVariables(guideData().NotesScreen);
          guideSheetStamp(guideData().NotesScreen);
        }
      }
    }
  } // TO CHECK IF WE SHOULD SHOW GUIDE SHEET FOR THIS SCREEN

  void guideSheetStamp(var guideDataSet) {
    print('Guide sheet stamp is called');
    // THE FOLLOWING WIDGET IS TO COVER THE ENTIRE SCREEN SO WE CAN LAY OUT CHILDREN WIDGET
    widget.guideSheetWidget = GestureDetector(
      onTap: () {
        if (currentPage < totalPages!) {
          currentPage++;
          guideSheetStamp(guideDataSet);
          setState(() {});
        } else {
          guideComplete();
        }
      },
      child: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Stack(
          children: [
            ColorFiltered(
              colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.5),
                  BlendMode.srcOut), // BLENDING WITH SOURCE OUT
              child: Stack(
                // LAYERS WITH BLENDING ENABLED
                children: [
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.black,
                        backgroundBlendMode: BlendMode.dstOut),
                  ), // DARK BACKGROUND
                  FractionalTranslation(
                    translation: Offset(
                        guideDataSet['spotlightOffsetFraction'][currentPage]
                            ['horizontal'],
                        guideDataSet['spotlightOffsetFraction'][currentPage][
                            'vertical']), // OFFSET VALUES ARE TAKEN FROM guideData()
                    child: OverflowBox(
                      // WE SET OVERFLOWBOX TO THE SIZE THAT WE MAKE OUR SPOTLIGHT TO
                      maxWidth: MediaQuery.of(context).size.width *
                          guideDataSet['spotlightSizeFraction'][currentPage]
                              ['width'],
                      maxHeight: MediaQuery.of(context).size.height *
                          guideDataSet['spotlightSizeFraction'][currentPage]
                              ['height'],
                      child: ClipOval(
                        // THIS CREATES A OVAL SHAPED SPOTLIGHT
                        // CHILD CREATES THE EXACT DIMENSIONS DEFINED IN guideData() CLASS
                        child: Container(
                          height: MediaQuery.of(context).size.height *
                              guideDataSet['spotlightSizeFraction'][currentPage]
                                  ['height'],
                          width: MediaQuery.of(context).size.width *
                              guideDataSet['spotlightSizeFraction'][currentPage]
                                  ['width'],
                          // guideDataSet['spotlightSizeFraction'][currentPage]
                          //     [guideSpotlightSize.width],
                          color: Colors.red,
                        ),
                      ),
                    ), // THIS FACILITATES THE SPOTLIGHT TO BE LARGER THAN ACTUAL SCREEN
                  ), // SPOTLIGHT
                ],
              ),
            ), // SPOTLIGHT
            Padding(
              // THIS PADDING ALLOWS TEXT TO BE ON A COMFORTABLE PLACE
              // TO BE CHANGED IN FUTURE
              padding:
                  guideDataSet['textPosition'][currentPage] == Alignment.center
                      ? const EdgeInsets.only(
                          left: 60, right: 60, top: 100, bottom: 150)
                      : const EdgeInsets.only(
                          left: 10, right: 10, top: 100, bottom: 150),
              child: Align(
                alignment: guideDataSet['textPosition'][currentPage],
                child: Text(
                  guideDataSet['text'][currentPage],
                  textAlign: TextAlign.center,
                  style: themeData().guideScreenBigTextStyle,
                ),
              ), // ALIGNMENT OF TEXT
            ), // GUIDE TEXT
            if (guideDataSet['containsWidgets'])
              if (guideDataSet['pagesContainingWidgets'].contains(currentPage))
                Padding(
                  // THIS PADDING ALLOWS WIDGET TO BE ON A COMFORTABLE PLACE
                  // TO BE CHANGED IN FUTURE
                  padding: const EdgeInsets.only(
                      left: 60, right: 60, top: 100, bottom: 150),
                  child: Align(
                    alignment: guideDataSet['spotlightPosition'][currentPage],
                    child: guideDataSet['widgets'][currentPage],
                  ), // ALIGNMENT OF WIDGET
                ), // GUIDE WIDGETS
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    if (currentPage != 1)
                      ClipOval(
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(
                              color: Colors.greenAccent.shade700,
                              width: 2.0,
                            ),
                            shape: BoxShape.circle,
                          ),
                          child: IconButton(
                            color: Colors.black,
                            icon: Icon(Icons.chevron_left_rounded, size: 30),
                            onPressed: () {
                              currentPage--;
                              guideSheetStamp(guideDataSet);
                              setState(() {});
                            },
                          ),
                        ),
                      )
                    else
                      SizedBox.shrink(),
                    if (currentPage < totalPages!)
                      ClipOval(
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(
                              color: Colors.greenAccent.shade700,
                              width: 2.0,
                            ),
                            shape: BoxShape.circle,
                          ),
                          child: IconButton(
                            color: Color(0xFF00CE2D),
                            icon: Icon(Icons.chevron_right_rounded, size: 30),
                            onPressed: () {
                              currentPage++;
                              guideSheetStamp(guideDataSet);
                              setState(() {});
                            },
                          ),
                        ),
                      ),
                    if (currentPage == totalPages)
                      ClipOval(
                        child: Container(
                          decoration: BoxDecoration(
                            color: Color(0xFF80FE94),
                            border: Border.all(
                              color: Colors.greenAccent.shade700,
                              width: 2.0,
                            ),
                            shape: BoxShape.circle,
                          ),
                          child: IconButton(
                            color: Colors.black54,
                            icon: Icon(Icons.check_rounded, size: 30),
                            onPressed: () {
                              guideComplete();
                            },
                          ),
                        ),
                      ),
                  ],
                ),
              ],
            ), // BUTTONS
          ],
        ), // GUIDE SHEET + SPOTLIGHT + BUTTONS
      ),
    );
    setState(() {});
  } // THIS WIDGET IS USED TO DYNAMICALLY SHOW GUIDE SHEETS

  Future<void> guideComplete() async {
    print('Guide is complete now');
    widget.guideSheetWidget = SizedBox.shrink();

    fireStoreGuideSheetMap[widget.currentScreen] = false;
    print(fireStoreGuideSheetMap);
    setState(() {});

    final userRef =
        FirebaseFirestore.instance.collection('users').doc(userEmail);

    await userRef.update({'ShowGuideSheet': fireStoreGuideSheetMap});
    print('done uploading ┏(-_-)┛┗(-_- )┓');
  } // THIS UPDATES FIRESTORE DATABASE SO GUIDE SHEET DOESNT SHOW UP AGAIN

  @override
  void initState() {
    super.initState();
    // FOLLOWING CALL MAKES SURE WE HAVE THE FIRESTORE MAP
  }

  @override
  Widget build(BuildContext context) {
    checkGuideSheetForCurrentScreen();
    print('Build has been called');
    // THIS IS THE VARIABLE WIDGET WE USE TO STORE GUIDE SHEET
    // THE REASON WHY WE USE A VARIABLE INSTEAD OF BUILDING COMPLETELY IS TO REDUCE WORKFLOW AND COMPLEXITY
    return widget.guideSheetWidget;
  }
}

class guideData {
  // THIS CLASS IS ONLY TO STORE CONSTANT DATA ABOUT GUIDE SHEETS
  Map DiscoveryScreen = {
    // DATA RELATED TO Discovery Screen
    'totalPages': 2,
    'containsWidgets': false,
    'spotlightPosition': {
      1: Alignment.topCenter,
      2: Alignment.bottomCenter,
    },
    'spotlightSizeFraction': {
      1: {'height': 1, 'width': 3},
      2: {'height': 1, 'width': 3}
    },
    'spotlightOffsetFraction': {
      1: {'vertical': -0.5, 'horizontal': 0.0},
      2: {'vertical': 0.3, 'horizontal': 0.0},
    },
    'textPosition': {
      1: Alignment.bottomCenter,
      2: Alignment.topCenter,
    },
    'text': {
      1: 'A little motivation for you...\n(powered with Gemini AI\n٩(◕‿◕｡)۶',
      2: 'Latest news about Python',
    },
  };
  Map QuizScreen = {
    // DATA RELATED TO Quiz Screen
    'totalPages': 3,
    'containsWidgets': false,
    'spotlightPosition': {
      1: Alignment.topLeft,
      2: Alignment.bottomCenter,
      3: Alignment.bottomCenter,
    },
    'spotlightSizeFraction': {
      1: {'height': 0.2, 'width': 0.8},
      2: {'height': 1, 'width': 2},
      3: {'height': 0.5, 'width': 1},
    },
    'spotlightOffsetFraction': {
      1: {'vertical': -0.45, 'horizontal': -0.2},
      2: {'vertical': 0.6, 'horizontal': 0.0},
      3: {'vertical': -0.45, 'horizontal': 0.4},
    },
    'textPosition': {
      1: Alignment.center,
      2: Alignment.topCenter,
      3: Alignment.center,
    },
    'text': {
      1: 'Quiz name and Progress bar\n\nYou will see some progress in a moment',
      2: 'Question\n\nAnd options to select of course....',
      3: 'You can quit here\n\nbut don\'t you dare\n(ง •̀_•́)ง',
    },
  };
  Map ProfileScreen = {
    // DATA RELATED TO Profile Screen
    'totalPages': 3,
    'containsWidgets': false,
    'spotlightPosition': {
      1: Alignment.topLeft,
      2: Alignment.bottomCenter,
      3: Alignment.bottomCenter,
    },
    'spotlightSizeFraction': {
      1: {'height': 1, 'width': 2},
      2: {'height': 0.5, 'width': 2},
      3: {'height': 0.2, 'width': 1},
    },
    'spotlightOffsetFraction': {
      1: {'vertical': -0.6, 'horizontal': 0.0},
      2: {'vertical': 0.04, 'horizontal': 1.0},
      3: {'vertical': 0.4, 'horizontal': 0.0},
    },
    'textPosition': {
      1: Alignment.bottomCenter,
      2: Alignment.topLeft,
      3: Alignment.center,
    },
    'text': {
      1: 'Looks like you?\nNah?\n Click on it to change',
      2: 'These are your scores',
      3: 'This is...\n\nIt\'s just self explanatory\n(ノ-_-)ノ ミ ┴┴'
    },
  };
  Map QuizCatalogScreen = {
    // DATA RELATED TO Quiz Catalog Screen
    'totalPages': 2,
    'containsWidgets': true,
    'pagesContainingWidgets': [1],
    'spotlightPosition': {
      1: Alignment.center,
      2: Alignment.topCenter,
    },
    'spotlightSizeFraction': {
      1: {'height': 0, 'width': 0},
      2: {'height': 0.5, 'width': 2},
    },
    'spotlightOffsetFraction': {
      1: {'vertical': 0.0, 'horizontal': 0.0},
      2: {'vertical': -0.5, 'horizontal': 0.0},
    },
    'textPosition': {
      1: Alignment.topCenter,
      2: Alignment.center,
    },
    'text': {
      1: 'Here\'s how they look,',
      2: 'You can click on unlocked quizzes.\n\nI\'ll explain more as we go....\n٩(◕‿◕｡)۶',
    },
    'widgets': {
      1: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Quiz to do ↴', style: themeData().guideScreenSmallTextStyle),
          GenericButton(
            icon: Icon(
              Icons.arrow_forward_outlined,
              color: Colors.white,
            ),
            label: 'quiz004',
            function: () {},
            type: GenericButtonType.proceed,
          ),
          SizedBox(height: 20),
          Text('Quizzes you have done already ↴',
              style: themeData().guideScreenSmallTextStyle),
          GenericButton(
            icon: Icon(
              Icons.check,
              color: Colors.green,
            ),
            label: 'quiz005',
            function: () {},
            type: GenericButtonType.semiProceed,
          ),
          SizedBox(height: 20),
          Text('Quizzes that are locked yet ↴',
              style: themeData().guideScreenSmallTextStyle),
          GenericButton(
            icon: Icon(
              Icons.lock_outline_rounded,
              color: Colors.black54,
            ),
            label: 'quiz006',
            function: () {},
            type: GenericButtonType.generic,
          ),
        ],
      ),
    }
  };
  Map AboutScreen = {
    // DATA RELATED TO Quiz Catalog Screen
    'totalPages': 1,
    'containsWidgets': false,
    'spotlightPosition': {
      1: Alignment.bottomCenter,
    },
    'spotlightSizeFraction': {
      1: {'height': 0.1, 'width': 0.9},
    },
    'spotlightOffsetFraction': {
      1: {'vertical': 0.4, 'horizontal': 0.0},
    },
    'textPosition': {
      1: Alignment.center,
    },
    'text': {
      1: 'You\'re welcome\n\n♡⸜(ˆᗜˆ˵ )⸝♡',
    },
  };
  Map NotesScreen = {
    // DATA RELATED TO Notes Screen
    'totalPages': 2,
    'containsWidgets': false,
    'spotlightPosition': {
      1: Alignment.topCenter,
      2: Alignment.bottomCenter,
    },
    'spotlightSizeFraction': {
      1: {'height': 1, 'width': 2},
      2: {'height': 1, 'width': 2},
    },
    'spotlightOffsetFraction': {
      1: {'vertical': -0.5, 'horizontal': 0.0},
      2: {'vertical': 0.4, 'horizontal': 0.0},
    },
    'textPosition': {
      1: Alignment.bottomCenter,
      2: Alignment.topCenter,
    },
    'text': {
      1: 'Python tips and tricks',
      2: 'Click on these notes to view them',
    },
  };
}
