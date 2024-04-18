import 'package:flutter/material.dart';
import 'package:flutter_planner/views/components/sizeable_gradient_button.dart';
import 'package:flutter_planner/views/todo/presentation/components/todo_title_text.dart';

/*
  Stateless class TodoOptionButtons
    A row that holds the editoral options of the todo and displays the
      the date created

    Required parameters
      [editOnPressed] - VoidCallback that handles the editing of a todo
      [finishOnPressed] - VoidCallback that handles the finishing of a todo
      [finishText] - Conditonal that displays either finished or revert based 
        off the state of the todo 
      [date] - Date that the todo was created, MM-DD-YYYY           
*/

class TodoOptionButtons extends StatelessWidget {
  // Declare variables
  //
  final VoidCallback editOnPressed;
  final VoidCallback finishOnPressed;
  final String finishText;
  final String date;

  const TodoOptionButtons({
    super.key,
    required this.finishText,
    required this.date,
    required this.editOnPressed,
    required this.finishOnPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        // Displays the date the todo was created
        // uses the formatted date of MM-DD-YYYY
        //
        Column(
          children: [
            const TodoTitleText(text: "Created on"),
            Text(
              date,
              style: const TextStyle(fontSize: 20),
            ),
          ],
        ),

        // Edit button - sends user to edit_todo.dart to edit todo
        //
        SizeableGradientButton(
          onPressed: editOnPressed,
          text: "Edit",
          width: 100,
          height: 50,
        ),

        // Finished button - sets the todo's finished parameter to true
        // sends user back to todo_page.dart
        //
        SizeableGradientButton(
          onPressed: finishOnPressed,
          text: finishText,
          width: 110,
          height: 50,
        ),
      ],
    );
  }
}
