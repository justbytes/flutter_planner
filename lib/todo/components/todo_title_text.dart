import 'package:flutter/material.dart';

/*
  Stateless class TodoTitleText
    uniformed title 

    Required parameters
      [text] String of the desired title           
*/

class TodoTitleText extends StatelessWidget {
  final String text;

  const TodoTitleText({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
