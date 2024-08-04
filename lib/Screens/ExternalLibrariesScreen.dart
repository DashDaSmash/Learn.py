// EVEN THOUGH THIS SCREEN WAS PROPOSED TO BE DYNAMICALLY FETCHED USING GEMINI AI OR BING SEARCH, TO SUIT THE PROJECT DEADLINE, FINALLY I DECIDED TO LEAVE IT STATIC CONSTANT

import 'package:flutter/material.dart';
import 'package:learn_py/ThemeData.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../Objects/GenericButton.dart';
import '../main.dart';

class ExternalLibrariesScreen extends StatefulWidget {
  const ExternalLibrariesScreen({super.key});

  @override
  _ExternalLibrariesScreenState createState() =>
      _ExternalLibrariesScreenState();
}

class _ExternalLibrariesScreenState extends State<ExternalLibrariesScreen> {
  List exLibItems = [
    // ALL THE DETAILS ARE MANUALLY ENTERED HERE.
    // RECOMMENDED TO USE A PYTHON SCRIPT TO AUTOMATE IN FUTURE
    {
      'name': 'Tkinter',
      'link': 'https://docs.python.org/3/library/tkinter.html',
      'descriptiopn':
          'Tkinter is a Python binding to the Tk GUI toolkit. It is the standard Python interface to the Tk GUI toolkit, and is Python\'s de facto standard GUI',
    },
    {
      'name': 'Kivy',
      'link': 'https://kivy.org/',
      'descriptiopn':
          'Kivy is a free and open source Python framework for developing mobile apps and other multitouch application software with a natural user interface',
    },
    {
      'name': 'SciPy',
      'link': 'https://scipy.org/',
      'descriptiopn':
          'SciPy is a free and open-source Python library used for scientific computing and technical computing',
    },
    {
      'name': 'TensorFlow',
      'link': 'https://www.tensorflow.org/',
      'descriptiopn':
          'TensorFlow is a free and open-source software library for machine learning and artificial intelligence',
    },
    {
      'name': 'PyGame',
      'link': 'https://www.pygame.org/download.shtml',
      'descriptiopn':
          'Pygame is a cross-platform set of Python modules designed for writing video games. It includes computer graphics and sound libraries designed to be used with the Python programming language.',
    },
    {
      'name': 'OpenCV',
      'link': 'https://opencv.org/',
      'descriptiopn':
          'OpenCV is a library of programming functions mainly for real-time computer vision',
    },
    {
      'name': 'NumPy',
      'link': 'https://numpy.org/',
      'descriptiopn':
          'NumPy is a library for the Python programming language, adding support for large, multi-dimensional arrays and matrices, along with a large collection of high-level mathematical functions',
    },
    {
      'name': 'Pandas',
      'link': 'https://pandas.pydata.org/',
      'descriptiopn':
          'Pandas is a software library written for the Python programming language for data manipulation and analysis',
    },
    {
      'name': 'scikit-learn',
      'link': 'https://scikit-learn.org/stable/index.html',
      'descriptiopn':
          'scikit-learn is a free and open-source machine learning library for the Python programming language',
    },
    {
      'name': 'PyTorch',
      'link': 'https://pytorch.org/',
      'descriptiopn':
          'PyTorch is a machine learning library based on the Torch library, used for applications such as computer vision and natural language processing, originally developed by Meta AI and now part of the Linux Foundation umbrella',
    },
    {
      'name': 'Keras',
      'link': 'https://keras.io/',
      'descriptiopn':
          'Keras is an open-source library that provides a Python interface for artificial neural networks',
    },
    {
      'name': 'Theano',
      'link': 'https://pypi.org/project/Theano/',
      'descriptiopn':
          'Theano is a Python library and optimizing compiler for manipulating and evaluating mathematical expressions, especially matrix-valued ones',
    },
    {
      'name': 'LightGBM',
      'link': 'https://lightgbm.readthedocs.io/en/latest/index.html',
      'descriptiopn':
          'LightGBM, short for Light Gradient-Boosting Machine, is a free and open-source distributed gradient-boosting framework for machine learning, originally developed by Microsoft.',
    },
    {
      'name': 'Scrapy',
      'link': 'https://scrapy.org/',
      'descriptiopn':
          'Scrapy is a free and open-source web-crawling framework written in Python.',
    },
    {
      'name': 'Requests',
      'link': 'https://docs.python-requests.org/en/latest/index.html',
      'descriptiopn':
          'Requests is an HTTP client library for the Python programming language. Requests is one of the most downloaded Python libraries, with over 300 million monthly downloads.',
    },
    {
      'name': 'FastAPI',
      'link': 'https://fastapi.tiangolo.com/',
      'descriptiopn':
          'FastAPI is a web framework for building HTTP-based service APIs in Python 3.8+. It uses Pydantic and type hints to validate, serialize and deserialize data.',
    },
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: themeData().backgroundColor,
      appBar: AppBar(
        scrolledUnderElevation: 0.0,
        elevation: 0.0,
        automaticallyImplyLeading: false,
        centerTitle: true,
        backgroundColor: themeData().backgroundColor,
        title: const Text(
          'External Libraries',
          style: TextStyle(
            color: Color(0xFF00FF29),
            fontSize: 30,
            fontWeight: FontWeight.bold,
            shadows: [
              Shadow(
                color: Colors.grey,
                offset: Offset(2, 2),
                blurRadius: 6,
              ),
            ],
          ),
        ),
      ),
      body: Stack(
        children: [
          ListView.builder(
            itemCount: exLibItems.length,
            itemBuilder: (BuildContext context, int index) {
              return index == 0
                  ? Column(
                      children: [
                        const SizedBox(height: 20),
                        ListTile(
                          title: GestureDetector(
                            onTap: () async {
                              if (await canLaunchUrlString(
                                  exLibItems[index]['link'])) {
                                await launchUrlString(
                                    exLibItems[index]['link']);
                              }
                            },
                            child: Container(
                              child: Column(
                                children: [
                                  Text(
                                    exLibItems[index]['name'],
                                    style: themeData().genericBigTextStyle,
                                  ),
                                  Text(
                                    exLibItems[index]['descriptiopn'],
                                    style: themeData().genericTextStyle,
                                    textAlign: TextAlign.center,
                                  )
                                ],
                              ),
                              decoration: BoxDecoration(
                                color: const Color(
                                    0xFFB4FFC0), // Set your desired background color
                                borderRadius: BorderRadius.circular(
                                    10.0), // Rounded corners
                                boxShadow: const [
                                  BoxShadow(
                                    blurRadius: 5,
                                    color: Colors.black26,
                                    offset: Offset(2, 2), // Add a subtle shadow
                                  ),
                                ],
                                border: Border.all(
                                  color: const Color(0xFF00B71D),
                                  width: 2,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    )
                  : index == exLibItems.length - 1
                      ? Column(
                          children: [
                            ListTile(
                              title: GestureDetector(
                                onTap: () async {
                                  if (await canLaunchUrlString(
                                      exLibItems[index]['link'])) {
                                    await launchUrlString(
                                        exLibItems[index]['link']);
                                  }
                                },
                                child: Container(
                                  child: Column(
                                    children: [
                                      Text(
                                        exLibItems[index]['name'],
                                        style: themeData().genericBigTextStyle,
                                      ),
                                      Text(
                                        exLibItems[index]['descriptiopn'],
                                        style: themeData().genericTextStyle,
                                        textAlign: TextAlign.center,
                                      )
                                    ],
                                  ),
                                  decoration: BoxDecoration(
                                    color: const Color(
                                        0xFFB4FFC0), // Set your desired background color
                                    borderRadius: BorderRadius.circular(
                                        10.0), // Rounded corners
                                    boxShadow: const [
                                      BoxShadow(
                                        blurRadius: 5,
                                        color: Colors.black26,
                                        offset:
                                            Offset(2, 2), // Add a subtle shadow
                                      ),
                                    ],
                                    border: Border.all(
                                      color: const Color(0xFF00B71D),
                                      width: 2,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 50),
                          ],
                        )
                      : ListTile(
                          title: GestureDetector(
                            onTap: () async {
                              if (await canLaunchUrlString(
                                  exLibItems[index]['link'])) {
                                await launchUrlString(
                                    exLibItems[index]['link']);
                              }
                            },
                            child: Container(
                              child: Column(
                                children: [
                                  Text(
                                    exLibItems[index]['name'],
                                    style: themeData().genericBigTextStyle,
                                  ),
                                  Text(
                                    exLibItems[index]['descriptiopn'],
                                    style: themeData().genericTextStyle,
                                    textAlign: TextAlign.center,
                                  )
                                ],
                              ),
                              decoration: BoxDecoration(
                                color: const Color(
                                    0xFFB4FFC0), // Set your desired background color
                                borderRadius: BorderRadius.circular(
                                    10.0), // Rounded corners
                                boxShadow: const [
                                  BoxShadow(
                                    blurRadius: 5,
                                    color: Colors.black26,
                                    offset: Offset(2, 2), // Add a subtle shadow
                                  ),
                                ],
                                border: Border.all(
                                  color: const Color(0xFF00B71D),
                                  width: 2,
                                ),
                              ),
                            ),
                          ),
                        );
            },
          ), // ALL THE EXTERNAL LIBRARIES ARE HERE
          Positioned(
              top: 0,
              child: Container(
                width: MediaQuery.sizeOf(context).width,
                height: 30,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                    colors: [
                      themeData()
                          .backgroundColor
                          .withOpacity(0), // Transparent at the bottom
                      themeData().backgroundColor, // Green at the top
                    ],
                  ),
                ),
              )), // FADING CONTAINER AT THE TOP OF THE SCREEN
          Positioned(
              bottom: 0,
              child: Container(
                width: MediaQuery.sizeOf(context).width,
                height: 100,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      themeData()
                          .backgroundColor
                          .withOpacity(0), // Transparent at the bottom
                      themeData()
                          .backgroundColor
                          .withOpacity(0.8), // Green at the top
                    ],
                  ),
                ),
              )), // FADING CONTAINER AT THE END
          Positioned(
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
          ), // BACK BUTTON
        ],
      ),
    );
  }
}
