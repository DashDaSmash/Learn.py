import 'package:flutter/material.dart';

class AnswerCheckSlideUpPanel extends StatefulWidget {
  @override
  _AnswerCheckSlideUpPanelState createState() =>
      _AnswerCheckSlideUpPanelState();
}

class _AnswerCheckSlideUpPanelState extends State<AnswerCheckSlideUpPanel> {
  bool _isPanelVisible = false;

  void _togglePanelVisibility() {
    setState(() {
      _isPanelVisible = !_isPanelVisible;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Slide-Up Panel Example'),
      ),
      body: Stack(
        children: [
          // Your main content goes here
          Center(
            child: Text('Your main content'),
          ),
          // Slide-up panel
          AnimatedContainer(
            duration: Duration(milliseconds: 300),
            height:
                _isPanelVisible ? MediaQuery.of(context).size.height / 2 : 0,
            alignment: Alignment.bottomCenter,
            child: SlideTransition(
              position: Tween<Offset>(
                begin: Offset(0, 1),
                end: Offset(0, 0),
              ).animate(CurvedAnimation(
                parent: ModalRoute.of(context)!.animation!,
                curve: Curves.easeInOut,
              )),
              child: Container(
                color: Colors.pink,
                child: Column(
                  children: [
                    // Your panel content goes here
                    Text('Slide-up panel content'),
                    ElevatedButton(
                      onPressed: _togglePanelVisibility,
                      child: Text(_isPanelVisible ? 'Slide Down' : 'Slide Up'),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
