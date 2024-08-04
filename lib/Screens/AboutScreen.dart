import 'package:flutter/material.dart';

import 'package:package_info_plus/package_info_plus.dart';

import 'package:learn_py/Objects/GenericButton.dart';
import 'package:learn_py/Objects/GuideSheet.dart';
import 'package:learn_py/ThemeData.dart';
import '../main.dart';

//TODO: Also manually change app version in pubspec.yaml

class AboutScreen extends StatefulWidget {
  const AboutScreen({super.key});

  @override
  State<AboutScreen> createState() => _AboutScreenState();
}

class _AboutScreenState extends State<AboutScreen> {
  String version = '';
  String buildNumber = '';

  Future<void> fetchBuildNumber() async {
    final info = await PackageInfo.fromPlatform();
    setState(() {
      version = info.version;
      buildNumber = info.buildNumber;
    });
  }

  @override
  void initState() {
    super.initState();
    fetchBuildNumber();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: themeData().backgroundColor,
      body: Stack(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.all(30.0),
                child: Image.asset('assets/Learn.py border T.png'),
              ), // LOGO
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    const Divider(
                      color: Colors.transparent,
                    ),
                    const Divider(
                      color: Colors.black12,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'App Version:',
                          style: themeData().genericTextStyle,
                        ),
                        Text(
                          version,
                          style: themeData().genericTextStyle,
                        ),
                      ],
                    ), // APP VERSION
                    const Divider(
                      color: Colors.black12,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Build Number:',
                          style: themeData().genericTextStyle,
                        ),
                        Text(
                          buildNumber,
                          style: themeData().genericTextStyle,
                        ),
                      ],
                    ), // BUILD NUMBER
                    const Divider(
                      color: Colors.black12,
                    ),
                    GestureDetector(
                      onTap: () =>
                          {Navigator.of(context).pushNamed('/credits')},
                      child: Text(
                        'License and credits',
                        style: themeData().genericBigTextStyle,
                      ),
                    ), // LICENSE AND CREDITS
                    const Divider(
                      color: Colors.black12,
                    ),
                    const SizedBox(
                      height: 80,
                    ),
                  ],
                ),
              ), // SYSTEM INFORMATION
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    GenericButton(
                      label: 'Buy developers a coffee',
                      function: () =>
                          Navigator.of(context).pushNamed('/donate'),
                      type: GenericButtonType.semiProceed,
                    ), // DONATION BUTTON
                    GenericButton(
                      label: 'Back',
                      function: () => Navigator.pop(context),
                      type: GenericButtonType.generic, // Set your desired color
                    ), // BACK BUTTON
                  ],
                ),
              ), // BUTTONS
            ],
          ),
          GuideSheet(currentScreen: 'AboutScreen'),
        ],
      ),
    );
  }
}
