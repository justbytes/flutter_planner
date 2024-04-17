import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_planner/login/bloc/auth_bloc.dart';
import 'package:flutter_planner/todo/components/todo_text.dart';
import 'package:flutter_planner/todo/cubit/todo_cubit.dart';
import 'package:flutter_planner/models/todo_model.dart';

/*
________________________________________________________________________________
  
  Route name: /finished-todo
    Accessed by:
      Route /todo-page
        todo_page.dart with no arguments
    
    Access to:
      Route /todo
        /finished_todo_page.dart sending no arguments

      Route /view-todo
        /view_todo_page.dart sending one arguments
          - <String> todo.id = the id of the todo that the user wants to view
________________________________________________________________________________

  Stateless class FinishedTodoPage
    Displays all todos with the 'finished' value set to true - Finished todos
________________________________________________________________________________

  State Manager: TodoCubit
________________________________________________________________________________
*/

class FinishedTodoPage extends StatelessWidget {
  const FinishedTodoPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Finished Todos',
            style: TextStyle(
              fontSize: 36,
              color: Color.fromARGB(255, 242, 239, 239),
              fontWeight: FontWeight.bold,
            )),
      ),
      body: BlocBuilder<AuthBloc, AuthState>(
        builder: (context, state) {
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
          return BlocBuilder<TodoCubit, List<Todo>>(
            builder: (context, todos) {
              final finishedTodos =
                  todos.where((todo) => todo.finished).toList();
              return ListView.builder(
                  itemCount: finishedTodos.length,
                  itemBuilder: (context, index) {
                    final todo = finishedTodos[index];

                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 242, 239, 239),
                            border: Border.all(width: 1),
                            borderRadius: BorderRadius.circular(5)),
                        child: ListTile(
                          title: TodoText(
                            text: todo.name,
                          ),
                          onTap: () {
                            Navigator.pushNamed(context, '/view-todo',
                                arguments: todo.id);
                          },
                        ),
                      ),
                    );
                  });
            },
          );
        },
      ),
    );
  }
}
