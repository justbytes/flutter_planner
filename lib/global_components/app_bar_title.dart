import 'package:flutter/material.dart';

/*
  Stateless class AppBarTitle
    A unifromed AppBar 

    Required parameters
      [text] - String for the title of the page         
*/

class AppBarTitle extends StatelessWidget {
  final String title;
  const AppBarTitle({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 28,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
