import 'package:flutter/material.dart';

class HomeScreenButton extends StatelessWidget {
  final int flex;
  final Color color;
  final Color strokeColor;
  final String text;
  final IconData icon;
  final String orientation; // 'horizontal' or 'vertical'
  final String route;

  HomeScreenButton({
    required this.flex,
    required this.color,
    required this.strokeColor,
    required this.text,
    required this.icon,
    required this.orientation,
    required this.route,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: flex,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GestureDetector(
          onTap: () =>
              Navigator.of(context, rootNavigator: true).pushNamed(route),
          child: Container(
              height: double.infinity,
              width: double.infinity,
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: strokeColor, width: 2),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.3), // Shadow color
                    spreadRadius: 5, // Spread radius
                    blurRadius: 10, // Blur radius
                    offset: Offset(0, 4), // Shadow offset (x, y)
                  ),
                ],
              ),
              child: Center(
                  child: orientation == 'horizontal'
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                              Icon(
                                icon,
                                size: 50,
                                color: Color(0xFF3C3C3C),
                              ),
                              SizedBox(width: 10, height: 10),
                              Text(
                                text,
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w900,
                                  color: Color(0xFF3C3C3C),
                                ),
                              )
                            ])
                      : Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                              Icon(
                                icon,
                                size: 50,
                                color: Color(0xFF3C3C3C),
                              ),
                              SizedBox(width: 10, height: 10),
                              Text(
                                text,
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w900,
                                  color: Color(0xFF3C3C3C),
                                ),
                              )
                            ]))),
        ),
      ),
    );
  }
}
