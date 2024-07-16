import 'package:flutter/material.dart';
import 'package:learn_py/Screens/LoginScreen.dart';
import '../Objects/GenericButton.dart';

class QuizCatalogScreen extends StatelessWidget {
  const QuizCatalogScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Column(
            children: [
              GenericButton(
                label: 'Quiz 1',
                function: () => Navigator.of(context, rootNavigator: true)
                    .pushNamed('/quiz', arguments: 1),
                type: GenericButtonType.generic,
              ),
              GenericButton(
                label: 'Quiz 2',
                function: () => Navigator.of(context, rootNavigator: true)
                    .pushNamed('/quiz', arguments: 2),
                type: GenericButtonType.generic,
              ),
            ],
          ),
          Positioned(
            //TODO: button customization
            bottom: 16, // Adjust the position as needed
            left: 16, // Adjust the position as needed
            right: 16, // Adjust the position as needed
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
