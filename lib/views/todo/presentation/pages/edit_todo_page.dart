import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_planner/views/components/gradient_button.dart';
import 'package:flutter_planner/views/components/app_bar_title.dart';
import 'package:flutter_planner/views/authentication/bloc/auth_bloc.dart';
import 'package:flutter_planner/views/authentication/presentation/login_page.dart';
import 'package:flutter_planner/views/todo/presentation/components/todo_form.dart';
import 'package:flutter_planner/views/todo/cubit/todo_cubit.dart';
import 'package:flutter_planner/models/todo_model.dart';

/*
________________________________________________________________________________
  
  Route name: /edit-todo
    Accessed by:
      Route /view-todo
        /view_todo_page.dart with one arguments of
          - <Todo> todo - used to access title and description
    
    Access to:
      Route /view-todo
        /view_todo_page.dart sending one arguments
          - <String> todo.id = the id of the todo that the user wants to view
________________________________________________________________________________

  Stateless class EditTodoPage
    Displays the selected todo with the ability to edit and update the state
________________________________________________________________________________

  State Manager: TodoCubit
    Events
      editTodo(todo.id, todoTitleController, todoDescriptionController);
       - Updates the todo's title and description field
________________________________________________________________________________
*/

class EditTodoPage extends StatelessWidget {
  final Todo? todo;
  EditTodoPage({super.key, required this.todo});

  // Declare text controllers
  //
  final todoTitleController = TextEditingController();
  final todoDescriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // Set textController values to the current value of todo
    //
    todoTitleController.text = todo!.name;
    todoDescriptionController.text = todo!.description;

    return Scaffold(
      appBar: AppBar(
        title: const AppBarTitle(
          title: "Edit Todo",
        ),
      ),
      body: BlocBuilder<AuthBloc, AuthState>(
        builder: (context, state) {
          if (state is AuthInitial) {
            return const LoginPage();
          }

          if (state is AuthLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (state is AuthFailure) {
            return const Center(
              child: Text("State is Auth Failure"),
            );
          }
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  // added from top
                  //
                  const SizedBox(height: 10),

                  // TodoForm
                  // holds tile and description textfields
                  // [titleController] - TextController for title field
                  // [descriptionController] - TextController for description field
                  // [enable] - bool that determins if the fields are editable
                  //
                  TodoForm(
                    enable: true,
                    titleController: todoTitleController,
                    descriptionController: todoDescriptionController,
                  ),

                  // added space
                  //
                  const SizedBox(height: 10),

                  // Calls TodoCubit and updates current state to the todo
                  // sends user back to view_todo_page.dart when finished
                  //
                  GradientButton(
                    onPressed: () {
                      // update todo by sending current values and todo id
                      //
                      BlocProvider.of<TodoCubit>(context).editTodo(
                        todo!.id,
                        todoTitleController.text.trim(),
                        todoDescriptionController.text.trim(),
                      );
                      Navigator.of(context).pop();
                    },
                    text: "Edit",
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
