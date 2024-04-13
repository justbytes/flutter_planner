import 'package:flutter/material.dart';
import 'package:flutter_planner/todo/components/todo_text_field.dart';
import 'package:flutter_planner/todo/components/todo_title_text.dart';

/*
  Stateless class TodoForm
    holds tile and description cust TodoTextFields

    Required parameters
      [titleController] - TextController for title field
      [descriptionController] - TextController for description field
      [enable] - bool that determins if the fields are editable            
*/

class TodoForm extends StatelessWidget {
  final bool enable;
  final TextEditingController titleController;
  final TextEditingController descriptionController;

  const TodoForm({
    super.key,
    required this.titleController,
    required this.descriptionController,
    required this.enable,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // added space
        //
        const SizedBox(height: 10),

        // title of todo textfield
        //
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const TodoTitleText(text: "Title"),
            TodoTextField(
              controller: titleController,
              enabled: enable,
              filled: true,
              color: const Color.fromARGB(255, 242, 239, 239),
              maxLines: 1,
              hintText: "Enter todo title",
            ),
          ],
        ),

        // added space
        //
        const SizedBox(height: 10),

        // description of todo textfield
        //
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const TodoTitleText(text: "Description"),
            TodoTextField(
              controller: descriptionController,
              filled: true,
              color: const Color.fromARGB(255, 242, 239, 239),
              enabled: enable,
              maxLines: 10,
              hintText: "Enter todo description",
            ),
          ],
        ),
      ],
    );
  }
}
