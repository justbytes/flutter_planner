import 'package:flutter/material.dart';

/*
  Stateless class TodoText
    uniformed text widget

    Required parameters
      [text] - String of text to be displayed           
*/

class TodoText extends StatelessWidget {
  final String text;
  const TodoText({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(
        color: Colors.black,
      ),
    );
  }
}
