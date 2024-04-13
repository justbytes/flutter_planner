import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_planner/global_components/app_bar_title.dart';
import 'package:flutter_planner/todo/components/todo_form.dart';
import 'package:flutter_planner/todo/components/todo_option_buttons.dart';
import 'package:flutter_planner/todo/cubit/todo_cubit.dart';
import 'package:flutter_planner/models/todo_model.dart';
import 'package:intl/intl.dart';

/*
________________________________________________________________________________
  
  Route name: /view-todo
    Accessed by:
      Route /todo
        /todo_page.dart with one argument of:
          - <String> todo.id 
    
      Route /finished-todo
        /finished_todo_page.dart with one argument of:
          - <String> todo.id - the id of the selected todo

    Access to:
      Route /todo
        /todo_page.dart sending no arguments
      
      Route /edit-todo
        /edit-todo.dart sending one argument of:
          - <Todo> todo - to edit a todo
________________________________________________________________________________

  Statless class ViewTodoPage
    Displays the individual todo that was selected by the user from the 
      todo_page.dart
    
    Dispays the title, description, date created of a todo

    Users can access and navigate to the edit todo or mark todo as finished
________________________________________________________________________________

  State Manager: TodoCubit
    Events
      - finishTodo(todo.id, todo.finished)
        Sets the state of a todo's "finished" = true
________________________________________________________________________________

  Future Development [TODO]:
    - MAKE HARD DELETE BUTTON 
       might be required after sqlite integration
________________________________________________________________________________
*/

class ViewTodoPage extends StatelessWidget {
  const ViewTodoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const AppBarTitle(
          title: "Todo",
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: BlocBuilder<TodoCubit, List<Todo>>(
            builder: (context, state) {
              // Id of the target todo
              //
              final todoId =
                  ModalRoute.of(context)!.settings.arguments as String;

              // Get the todo by id
              //
              final todo = context.read<TodoCubit>().getTodoById(todoId);

              // Set the textController values to the todo values
              //
              final TextEditingController titleController =
                  TextEditingController(text: todo!.name);
              final TextEditingController descriptionController =
                  TextEditingController(text: todo.description);

              // Format the date of the todo to MM-DD-YYYY
              //
              DateTime dateTime = DateTime.parse(todo.createdAt.toString());
              String formattedDate = DateFormat('MM-dd-yyyy').format(dateTime);

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // added space from top of page
                  //
                  const SizedBox(height: 10),

                  // TodoForm
                  // holds tile and description textfields
                  // [titleController] - TextController for title field
                  // [descriptionController] - TextController for description field
                  // [enable] - bool that determins if the fields are editable
                  //
                  TodoForm(
                    titleController: titleController,
                    descriptionController: descriptionController,
                    enable: false,
                  ),

                  // added space
                  //
                  const SizedBox(height: 10),

                  // TodoOptionButtons
                  // A row that holds the editoral options of the todo and displays the date created
                  // [editOnPressed] - VoidCallback that handles the editing of a todo
                  // [finishOnPressed] - VoidCallback that handles the finishing of a todo
                  // [finishText] - Conditonal that displays either finished or revert based
                  //  .
                  //off the state of the todo
                  // [date] - Date that the todo was created, MM-DD-YYYY
                  //
                  TodoOptionButtons(
                    finishText: todo.finished ? "Revert" : "Finished",
                    date: formattedDate,
                    // Sends user to edit_todo.dart to edit the todo
                    //
                    editOnPressed: () {
                      Navigator.pushNamed(context, '/edit-todo',
                          arguments: todo);
                    },
                    // Sets todo's 'finished' to appropriate state
                    // sends user back to todo_page.dart
                    //
                    finishOnPressed: () {
                      BlocProvider.of<TodoCubit>(context)
                          .finishTodo(todo.id, todo.finished);
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
