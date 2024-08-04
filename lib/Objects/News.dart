// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class NewsScreen extends StatefulWidget {
  const NewsScreen({super.key});

  @override
  _NewsScreenState createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {
  // FROM newsAPI
  final String apiKey = '94ce7564ba2d4c898efbffb21c45da0a';
  List<dynamic> articles = [];

  @override
  void initState() {
    super.initState();
    fetchNews();
  }

  Future<void> fetchNews() async {
    // FETCH NEWS
    final response = await http.get(
      Uri.parse(
          'https://newsapi.org/v2/everything?q=python&apiKey=$apiKey&sortBy=publishedAt&language=en'),
    );

    if (response.statusCode == 200) {
      // FOR SUCCESSFUL CALLBACKS, DECODE DATA AND STORE IN A LIST
      final data = json.decode(response.body);
      setState(() {
        articles = data['articles'];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return articles.isEmpty
        // LOADING ICON IS SHOWN UNTIL NEWS IS DONE FETCHING
        ? Center(
            child: LoadingAnimationWidget.threeRotatingDots(
              color: const Color(0xFF80FE94), // Set your desired color
              size: 30.0, // Set the size of the animation
            ),
          )
        // ALL THE NEWS ITEMS ARE SHOWN IN SEPARATE CONTAINERS AND ALSO CLICKABLE
        : ListView.builder(
            itemCount: articles.length,
            itemBuilder: (context, index) {
              final article = articles[index];
              return index ==
                      0 // IF THE NOTE IS THE FIRST ONE, ADD EMPTY SPACE AT TOP
                  ? Column(
                      children: [
                        const SizedBox(height: 20),
                        Container(
                          margin: const EdgeInsets.all(5.0), // Add vertical spacing
                          decoration: BoxDecoration(
                            color: const Color(
                                0xFFB4FFC0), // Set your desired background color
                            borderRadius:
                                BorderRadius.circular(10.0), // Rounded corners
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
                          child: ListTile(
                            title: Text(
                              article['title'],
                              style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500,
                                  color: Color(0xFF00CE2D)),
                            ),
                            subtitle: Text(
                              article['description'],
                              style: const TextStyle(fontSize: 18),
                            ),
                            onTap: () async {
                              final articleUrl = article[
                                  'url']; // Assuming the article URL is available
                              if (await canLaunch(articleUrl)) {
                                await launch(articleUrl);
                              }
                            },
                          ),
                        ),
                      ],
                    )
                  : Container(
                      margin: const EdgeInsets.all(5.0), // Add vertical spacing
                      decoration: BoxDecoration(
                        color: const Color(
                            0xFFB4FFC0), // Set your desired background color
                        borderRadius:
                            BorderRadius.circular(10.0), // Rounded corners
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
                      child: ListTile(
                        title: Text(
                          article['title'],
                          style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                              color: Color(0xFF00CE2D)),
                        ),
                        subtitle: Text(
                          article['description'],
                          style: const TextStyle(fontSize: 18),
                        ),
                        onTap: () async {
                          final articleUrl = article[
                              'url']; // Assuming the article URL is available
                          if (await canLaunch(articleUrl)) {
                            await launch(articleUrl);
                          } else {
                          }
                        },
                      ),
                    );
            });
  }
}
