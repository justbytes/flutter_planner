import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_planner/views/components/app_bar_title.dart';
import 'package:flutter_planner/views/authentication/bloc/auth_bloc.dart';
import 'package:flutter_planner/views/authentication/presentation/login_page.dart';
import 'package:flutter_planner/views/todo/presentation/components/todo_text.dart';
import 'package:flutter_planner/views/todo/cubit/todo_cubit.dart';
import 'package:flutter_planner/models/todo_model.dart';

/*
________________________________________________________________________________
  
  Route name: /todo
    Accessed by:
      Route /main-page
        main_page.dart with no arguments
    
    Access to:
      Route /finished-todo
        /finished_todo_page.dart sending no arguments

      Route /view-todo
        /view_todo_page.dart sending one arguments
          - <String> todo.id = the id of the todo that the user wants to view
    
      Route /add-todo
        /add_todo.dart sending no arguments
________________________________________________________________________________

  Stateless class TodoPage
    Displays all todos with the 'finished' value set to false - In progress todos

    Contains 2 Floating Action Buttons
      one for navigating to the finished todo page
      one for navigating and creating a new todo
________________________________________________________________________________

  State Manager: TodoCubit
________________________________________________________________________________
*/

class TodoPage extends StatelessWidget {
  const TodoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(builder: (context, state) {
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

      if (state is AuthSuccess || state is GoogleSuccess) {
        return Scaffold(
          appBar: AppBar(
            title: const AppBarTitle(
              title: "Todo List",
            ),
            centerTitle: true,
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

              return BlocBuilder<TodoCubit, List<Todo>>(
                builder: (context, todos) {
                  // filter any finished todo and return only todos that are still
                  // in progress
                  //
                  final unfinishedTodos =
                      todos.where((todo) => !todo.finished).toList();

                  // Display unfinished todos
                  //
                  return ListView.builder(
                      itemCount: unfinishedTodos.length,
                      itemBuilder: (context, index) {
                        final todo = unfinishedTodos[index];

                        // Returns the title for every todo in a ListTitle
                        //
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            decoration: BoxDecoration(
                              color: const Color.fromARGB(255, 242, 239, 239),
                              border: Border.all(width: 1),
                              borderRadius: BorderRadius.circular(5),
                            ),
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

          // FloatingActionButtons
          // One for navigating to the finished todo page
          // One for navigating and creating a new todo
          //
          floatingActionButton: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              // View finsihed todos
              //
              FloatingActionButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/finished-todo');
                },
                tooltip: 'View completed todos',
                heroTag: 'finished-todo-btn',
                child: const Icon(Icons.history),
              ),
              // Space
              //
              const SizedBox(
                height: 10,
              ),

              // Create a new todo
              //
              FloatingActionButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/add-todo');
                },
                tooltip: 'Add Todo',
                heroTag: 'add-todo-btnr',
                child: const Icon(Icons.add),
              ),
            ],
          ),
        );
      }
      // Displays current state is unkown
      //
      return const Center(
        child: Text("Looks like we're in some unknown state"),
      );
    });
  }
}
