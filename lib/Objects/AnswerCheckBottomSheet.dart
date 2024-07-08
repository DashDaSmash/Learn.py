import 'package:flutter/material.dart';
import 'GenericButton.dart';

class AnswerCheckBottomSheet extends StatelessWidget {
  final bool isCorrect;

  AnswerCheckBottomSheet({required this.isCorrect});

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (BuildContext context) {
        return ElevatedButton(
          onPressed: () {
            showModalBottomSheet<void>(
              context: context,
              builder: (_) {
                if (isCorrect == true) {
                  return Container(
                    height: MediaQuery.of(context).size.height * 0.5,
                    width: MediaQuery.of(context).size.width,
                    child: Column(
                      children: [
                        Expanded(child: Center(child: Text('Awesome!'))),
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text('Hello, this is your bottom sheet!'),
                              ElevatedButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: Text('Close'),
                              ),
                              GenericButton(
                                label: 'Next',
                                function: () {},
                                labelTextColor: Colors.white,
                                backgroundColor: Colors.black,
                                strokeColor: Colors.purpleAccent,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                } else {
                  return Container(
                    height: MediaQuery.of(context).size.height * 0.5,
                    width: MediaQuery.of(context).size.width,
                    child: Column(
                      children: [
                        Expanded(child: Center(child: Text('Oops!'))),
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text('Hello, this is your bottom sheet!'),
                              ElevatedButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: Text('Close'),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                }
              },
            );
          },
          child: Text('Show Bottom Sheet'),
        );
      },
    );
  }
}
