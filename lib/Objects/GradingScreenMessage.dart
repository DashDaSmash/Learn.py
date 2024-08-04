// ignore_for_file: file_names

import 'package:flutter/material.dart';

class TextEnlargementAnimation extends StatefulWidget {
  final bool userPassedQuiz;
  const TextEnlargementAnimation({super.key, required this.userPassedQuiz});

  @override
  _TextEnlargementAnimationState createState() =>
      _TextEnlargementAnimationState();
}

class _TextEnlargementAnimationState extends State<TextEnlargementAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );
    _animation = CurvedAnimation(
      parent: _controller,
      curve: widget.userPassedQuiz ? Curves.elasticOut : Curves.bounceOut,
    );
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: AnimatedBuilder(
        animation: _animation,
        builder: (context, child) {
          if (widget.userPassedQuiz) {
            final fontSize =
                95.0 + (_animation.value * 10.0); // STARTS FROM 95pts
            return Text(
              'Good\n     job!',
              style: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.w700,
                color: Colors.white,
                shadows: const [
                  Shadow(
                    color: Colors.black54,
                    offset: Offset(8, 8),
                    blurRadius: 20,
                  ),
                  Shadow(
                    color: Color(0xFF008615),
                    offset: Offset(2, 2),
                    blurRadius: 2,
                  ),
                ],
              ),
            );
          } //PASSED SCREEN
          else {
            return Transform.translate(
              offset: Offset(0,
                  MediaQuery.of(context).size.width * 0.1 * _animation.value),
              child: const Text(
                'Let\'s\n  try\n again...',
                // style: themeData().GradingScreenMessageTextStyle(fontSize: fontSize),
                style: TextStyle(
                  fontSize: 70,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                  shadows: [
                    Shadow(
                      color: Colors.black54,
                      offset: Offset(8, 8),
                      blurRadius: 20,
                    ),
                    Shadow(
                      color: Colors.red,
                      offset: Offset(2, 2),
                      blurRadius: 2,
                    ),
                  ],
                ),
              ),
            );
          } // FAILED SCREEN
        },
      ),
    );
  }
}
