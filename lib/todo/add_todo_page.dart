import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_planner/global_components/gradient_button.dart';
import 'package:flutter_planner/global_components/app_bar_title.dart';
import 'package:flutter_planner/login/bloc/auth_bloc.dart';
import 'package:flutter_planner/login/presentation/login_page.dart';
import 'package:flutter_planner/todo/components/todo_form.dart';
import 'package:flutter_planner/todo/cubit/todo_cubit.dart';

/*
________________________________________________________________________________
  
  Route name: /add-todo
    Accessed by:
      Route /todo
        /todo_page.dart with no arguments
    
    Access to:
      Route /todo
        /todo_page.dart with no arguments
________________________________________________________________________________

  Stateless class AddTodoPage
    Displays textfields and a button to add todo's to state
________________________________________________________________________________

  State Manager: TodoCubit
    Events
      editTodo(todo.id, todoTitleController, todoDescriptionController);
       - Updates the todo's title and description field
________________________________________________________________________________
*/

class AddTodoPage extends StatefulWidget {
  const AddTodoPage({super.key});

  @override
  State<AddTodoPage> createState() => _AddTodoPageState();
}

class _AddTodoPageState extends State<AddTodoPage> {
  // Declare text controllers
  //
  final todoTitleController = TextEditingController();
  final todoDescriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const AppBarTitle(
          title: "Todo List",
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
                  // added space from top
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
                    descriptionController: todoDescriptionController,
                    titleController: todoTitleController,
                  ),

                  // added space
                  //
                  const SizedBox(height: 10),

                  // Calls TodoCubit and adds current values to state as a todo
                  // sends user back to todo_page.dart when finished
                  //
                  GradientButton(
                    onPressed: () {
                      // add todo to state
                      //
                      BlocProvider.of<TodoCubit>(context).addTodo(
                        todoTitleController.text.trim(),
                        todoDescriptionController.text.trim(),
                      );
                      Navigator.of(context).pop();
                    },
                    text: "Add",
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
