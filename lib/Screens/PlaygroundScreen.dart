import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:learn_py/Objects/GenericButton.dart';
import 'package:learn_py/ThemeData.dart';
import 'package:learn_py/main.dart';

class PlaygroundScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text('CodeExec API Example')),
        body: MyWidget(),
      ),
    );
  }
}

class MyWidget extends StatefulWidget {
  @override
  _MyWidgetState createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  String pythonOutput = '';

  Future<void> fetchPythonOutput() async {
    final url = Uri.parse(
        'https://judge0-ce.p.rapidapi.com/submissions/2e979232-92fd-4012-97cf-3e9177257d10?base64_encoded=true&fields=*');
    final response = await http.get(url, headers: {
      'X-RapidAPI-Host': 'judge0-ce.p.rapidapi.com',
      'X-RapidAPI-Key': '7e829678ffmshaf03401a25b431bp173832jsn2e9e10d601ce',
    });

    if (response.statusCode == 200) {
      setState(() {
        pythonOutput = response.body;
      });
      print('Python Output: $pythonOutput');
    } else {
      print('Error fetching Python output: ${response.statusCode}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: fetchPythonOutput,
              child: Text('Execute Python Code'),
            ),
            SizedBox(height: 20),
            Text(pythonOutput),
          ],
        ),
        Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          color: Colors.white.withOpacity(0.5),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox.shrink(),
              Center(
                child: Text(
                  'This page is still under development',
                  style: themeData().genericTextStyle,
                  textAlign: TextAlign.center,
                ),
              ),
              GenericButton(
                  label: 'Close',
                  function: () => Navigator.pop(context),
                  type: GenericButtonType.proceed)
            ],
          ),
        )
      ],
    );
  }
}
