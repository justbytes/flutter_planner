import 'package:flutter/material.dart';

/*
  Stateless class TodoTextField
    Uniformed text field widget

    Required parameters
      [controller] - TextController..
      [enabled] - bool to determine if the text field is editable
      [maxLines] - int determines the amount of lines needed
      [hinText] - String that containes the hint for the textfield
      [filled] - bool that determines if the textfield should have 
        a background color
      [color] - color of the background if [filled] is true  
*/

class TodoTextField extends StatelessWidget {
  final TextEditingController controller;
  final bool enabled;
  final int maxLines;
  final String hintText;
  final bool filled;
  final Color color;
  const TodoTextField({
    super.key,
    required this.controller,
    required this.enabled,
    required this.maxLines,
    required this.hintText,
    required this.filled,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      enabled: enabled,
      style: const TextStyle(color: Colors.black),
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle(color: Colors.grey[600]),
        border: const OutlineInputBorder(),
        fillColor: color,
        filled: filled,
      ),
      maxLines: maxLines,
    );
  }
}
