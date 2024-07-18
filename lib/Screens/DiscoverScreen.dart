import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import '../Objects/GeminiAI.dart';
import '../Objects/News.dart';
import '../Objects/GenericButton.dart';
import 'package:flutter/services.dart';

import '../main.dart';
//TODO: show why you need to learn in here and tips and tricks in notes page

class DiscoverScreen extends StatefulWidget {
  const DiscoverScreen({Key? key}) : super(key: key);

  @override
  State<DiscoverScreen> createState() => _DiscoverScreenState();
}

class _DiscoverScreenState extends State<DiscoverScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFECFFF0),
      body: SafeArea(
        child: Stack(
          //TODO: add loading icons
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
                              prompt: 'Give me a tip for Python coding',
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  'What\'s new...',
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
                    child: NewsScreen(),
                  ),
                ),
              ],
            ),
            Positioned(
              //TODO: button customization
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

// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/widgets.dart';
// import '../Objects/GeminiAI.dart';
// import '../Objects/News.dart';
// import '../Objects/GenericButton.dart';
// import 'package:flutter/services.dart';
//
// class DiscoverScreen extends StatefulWidget {
//   const DiscoverScreen({Key? key}) : super(key: key);
//
//   @override
//   State<DiscoverScreen> createState() => _DiscoverScreenState();
// }
//
// class _DiscoverScreenState extends State<DiscoverScreen> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Color(0xFFECFFF0),
//       body: SafeArea(
//         child: Stack(
//           //TODO: add loading icons
//           children: [
//             Column(
//               children: [
//                 Expanded(
//                   flex: 2,
//                   child: Column(
//                     children: [
//                       Text(
//                         'Hungry for knowledge bytes!?!',
//                         style: TextStyle(
//                           color: Color(0xFF3C3C3C),
//                           fontSize: 18,
//                         ),
//                       ),
//                       Expanded(
//                         child: Container(
//                           margin: EdgeInsets.all(10),
//                           // height: 300,
//                           width: double.infinity,
//                           decoration: BoxDecoration(
//                             color: Colors.white,
//                             borderRadius: BorderRadius.circular(10),
//                             boxShadow: [
//                               BoxShadow(
//                                 color: Color(0xFFBDCEC1),
//                                 blurRadius: 5,
//                                 spreadRadius: 2,
//                                 offset: Offset(0, 2),
//                               ),
//                             ],
//                             border: Border.all(
//                               color: Color(0xFF00B71D),
//                               width: 2,
//                             ),
//                           ),
//                           child: SingleChildScrollView(
//                             child: Placeholder(),
//                             // child: GeminiAI(
//                             //   prompt: 'Give me a tip about Python language',
//                             // ),
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//                 FractionallySizedBox(
//                   widthFactor: 0.6,
//                   child: Divider(
//                     color: Color(0xFF00B71D),
//                   ),
//                 ),
//                 Expanded(
//                   flex: 3,
//                   child: Expanded(
//                     child: Container(
//                       width: double.infinity,
//                       child: Placeholder(),
//                       // child: NewsScreen(),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//             Positioned(
//               //TODO: button customization
//               bottom: 16, // Adjust the position as needed
//               left: 16, // Adjust the position as needed
//               right: 16, // Adjust the position as needed
//               child: GenericButton(
//                 label: 'Back',
//                 function: () => Navigator.pop(context),
//                 labelTextColor: Colors.white,
//                 backgroundColor: Colors.green, // Set your desired color
//                 strokeColor: Colors.black, // Set your desired color
//                 icon: Icons.add, // Replace with your icon
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
