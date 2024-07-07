import 'package:flutter/material.dart';
import '../Objects/GenericButton.dart';

class QuizCatalogScreen extends StatelessWidget {
  const QuizCatalogScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          GenericButton(
            label: 'Quiz 1',
            function: () => Navigator.of(context, rootNavigator: true)
                .pushNamed('/quiz', arguments: 1),
            labelTextColor: Color(0xFF000000),
            backgroundColor: Color(0xFFD9D9D9),
            strokeColor: Color(0xFFA3A3A3),
          )
        ],
      ),
    );
  }
}
