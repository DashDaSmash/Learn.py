import 'package:flutter/material.dart';

class NotesScreen extends StatefulWidget {
  const NotesScreen({super.key});

  @override
  State<NotesScreen> createState() => _NotesScreenState();
}

class _NotesScreenState extends State<NotesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IntrinsicHeight(
        child: Row(
          children: [
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                width: 100,
                height: 100,
                color: Colors.red,
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                width: 100,
                height: 200,
                color: Colors.green,
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                width: 150,
                height: 150,
                color: Colors.blueAccent,
              ),
            )
          ],
        ),
      ),
    );
  }
}
