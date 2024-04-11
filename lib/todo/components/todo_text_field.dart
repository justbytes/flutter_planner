import 'package:flutter/material.dart';

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
      decoration: InputDecoration(
        hintText: hintText,
        border: const OutlineInputBorder(),
        fillColor: color,
        filled: filled,
      ),
      maxLines: maxLines,
    );
  }
}
