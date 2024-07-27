import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:url_launcher/url_launcher.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class NewsScreen extends StatefulWidget {
  @override
  _NewsScreenState createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {
  final String apiKey = '94ce7564ba2d4c898efbffb21c45da0a';
  List<dynamic> articles = [];

  @override
  void initState() {
    super.initState();
    fetchNews();
  }

  Future<void> fetchNews() async {
    final response = await http.get(
      Uri.parse(
          'https://newsapi.org/v2/everything?q=python&apiKey=$apiKey&sortBy=publishedAt&language=en'),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      setState(() {
        articles = data['articles'];
      });
    } else {
      print('Error fetching news: ${response.statusCode}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return articles.isEmpty
        ? Center(
            child: LoadingAnimationWidget.threeRotatingDots(
            color: Color(0xFF80FE94), // Set your desired color
            size: 30.0, // Set the size of the animation
          ))
        : ListView.builder(
            itemCount: articles.length,
            itemBuilder: (context, index) {
              final article = articles[index];
              return index ==
                      0 // IF THE NOTE IS THE FIRST ONE, ADD EMPTY SPACE AT TOP
                  ? Column(
                      children: [
                        SizedBox(height: 20),
                        Container(
                          margin: EdgeInsets.all(5.0), // Add vertical spacing
                          decoration: BoxDecoration(
                            color: Color(
                                0xFFB4FFC0), // Set your desired background color
                            borderRadius:
                                BorderRadius.circular(10.0), // Rounded corners
                            boxShadow: [
                              BoxShadow(
                                blurRadius: 5,
                                color: Colors.black26,
                                offset: Offset(2, 2), // Add a subtle shadow
                              ),
                            ],
                            border: Border.all(
                              color: Color(0xFF00B71D),
                              width: 2,
                            ),
                          ),
                          child: ListTile(
                            title: Text(
                              article['title'],
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500,
                                  color: Color(0xFF00CE2D)),
                            ),
                            subtitle: Text(
                              article['description'],
                              style: TextStyle(fontSize: 18),
                            ),
                            onTap: () async {
                              final articleUrl = article[
                                  'url']; // Assuming the article URL is available
                              if (await canLaunch(articleUrl)) {
                                await launch(articleUrl);
                              } else {
                                print('Could not launch $articleUrl');
                              }
                            },
                          ),
                        ),
                      ],
                    )
                  : Container(
                      margin: EdgeInsets.all(5.0), // Add vertical spacing
                      decoration: BoxDecoration(
                        color: Color(
                            0xFFB4FFC0), // Set your desired background color
                        borderRadius:
                            BorderRadius.circular(10.0), // Rounded corners
                        boxShadow: [
                          BoxShadow(
                            blurRadius: 5,
                            color: Colors.black26,
                            offset: Offset(2, 2), // Add a subtle shadow
                          ),
                        ],
                        border: Border.all(
                          color: Color(0xFF00B71D),
                          width: 2,
                        ),
                      ),
                      child: ListTile(
                        title: Text(
                          article['title'],
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                              color: Color(0xFF00CE2D)),
                        ),
                        subtitle: Text(
                          article['description'],
                          style: TextStyle(fontSize: 18),
                        ),
                        onTap: () async {
                          final articleUrl = article[
                              'url']; // Assuming the article URL is available
                          if (await canLaunch(articleUrl)) {
                            await launch(articleUrl);
                          } else {
                            print('Could not launch $articleUrl');
                          }
                        },
                      ),
                    );
            });
  }
}
