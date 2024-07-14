import 'package:flutter/material.dart';
import 'package:learn_py/Objects/GenericButton.dart';
import 'package:learn_py/Screens/LoginScreen.dart';
import 'package:package_info_plus/package_info_plus.dart';

//TODO: Also manually change app version in pubspec.yaml

class AboutScreen extends StatefulWidget {
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
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              Image.asset('assets/Learn.py border T.png'),
              Divider(),
              Text('App Version: $version'),
              Text('Build Number $buildNumber'),
            ],
          ),
          Column(
            children: [
              //BackButton
              GenericButton(
                label: 'Back',
                function: () => Navigator.pop(context),
                type: GenericButtonType.generic, // Set your desired color
              ),
              GenericButton(
                label: 'Buy developers a coffee',
                function: () => Navigator.of(context).pushNamed('/donate'),
                type: GenericButtonType.semiProceed,
              )
            ],
          ),
        ],
      ),
    );
  }
}
