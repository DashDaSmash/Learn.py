// VALUES FOR CURRENT SCREEN STRING:
//                  DiscoveryScreen

//TODO: make sure at add all guide screens to user registration

//TODO: Add an option to toggle guide sheet on again

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:learn_py/Objects/GenericButton.dart';

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
        print('#########################');
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
              padding: const EdgeInsets.only(
                  left: 10, right: 10, top: 100, bottom: 150),
              child: Align(
                alignment: guideDataSet['textPosition'][currentPage],
                child: Text(
                  guideDataSet['text'][currentPage],
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 30,
                      color: Colors.white,
                      shadows: [
                        Shadow(
                          color: Colors.grey,
                          offset: Offset(2, 2),
                          blurRadius: 10,
                        ),
                      ]),
                ),
              ), // ALIGNMENT OF TEXT
            ), // GUIDE TEXT
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      // FOLLOWING MAKES SURE BACK BUTTON IS NOT SHOWN IN FIRST PAGE OF GUIDE SHEET
                      currentPage != 1
                          ? Expanded(
                              child: GenericButton(
                                  label: 'Back',
                                  function: () {
                                    currentPage--;
                                    guideSheetStamp(guideDataSet);
                                    setState(() {});
                                  },
                                  type: GenericButtonType.generic),
                            )
                          : SizedBox.shrink(),
                      // THIS MAKES SURE WE SHOW 'NEXT' ONLY UNTIL THE PAGE BEFORE LAST
                      currentPage < totalPages!
                          ? Expanded(
                              child: GenericButton(
                                  label: 'Next',
                                  function: () {
                                    currentPage++;
                                    guideSheetStamp(guideDataSet);
                                    setState(() {});
                                  },
                                  type: GenericButtonType.semiProceed),
                            )
                          : SizedBox.shrink(),
                      // 'CONTINUE' BUTTON IS ONLY SHOWN ON LAST PAGE OF GUIDE SCREEN
                      currentPage == totalPages
                          ? Expanded(
                              child: GenericButton(
                                  label: 'Continue',
                                  function: () {
                                    guideComplete();
                                  },
                                  type: GenericButtonType.proceed),
                            )
                          : SizedBox.shrink(),
                    ],
                  ),
                )
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

    final userRef =
        FirebaseFirestore.instance.collection('users').doc(userEmail);

    await userRef.update({'ShowGuideSheet': fireStoreGuideSheetMap});
    setState(() {});
  } // THIS UPDATES FIRESTORE DATABASE SO GUIDE SHEET DOESNT SHOW UP AGAIN

  @override
  void initState() {
    super.initState();
    // FOLLOWING CALL MAKES SURE WE HAVE THE FIRESTORE MAP
    MyApp().fetchVisitedScreens();
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
      1: 'Quiz name and Progress bar:\nYou will see progress as you go...',
      2: 'Question....\nAnd options to select of course',
      3: 'You can quit here\n\nbut don\'t you dare\n(ง •̀_•́)ง',
    },
  };
  Map ProfileScreen = {
    // DATA RELATED TO Profile Screen
    'totalPages': 3,
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
      3: 'This is...\nIt\'s just self explanatory\n(ノ-_-)ノ ミ ┴┴'
    },
    //TODO: Quizcatalog--------->   You can click on unlocked quizzes. I'll explain more on the way....
  };
}
