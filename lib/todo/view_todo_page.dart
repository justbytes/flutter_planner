import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_planner/todo/components/todo_title_text.dart';
import 'package:flutter_planner/todo/cubit/todo_cubit.dart';
import 'package:flutter_planner/models/todo_model.dart';
// Import your TodoCubit
import 'package:intl/intl.dart';

class ViewTodoPage extends StatelessWidget {
  const ViewTodoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.purple[300],
      appBar: AppBar(
        backgroundColor: Colors.purple[600],
        title: const Text("Todo",
            style: TextStyle(
              fontSize: 36,
              color: Color.fromARGB(255, 242, 239, 239),
              fontWeight: FontWeight.bold,
            )),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: BlocBuilder<TodoCubit, List<Todo>>(
            builder: (context, state) {
              // Assuming you have the todo ID. For example, let's say the ID is 1.
              final todoId =
                  ModalRoute.of(context)!.settings.arguments as String;
              final todo = context.read<TodoCubit>().getTodoById(todoId);

              final TextEditingController titleController =
                  TextEditingController(text: todo!.name);
              final TextEditingController descriptionController =
                  TextEditingController(text: todo.description);

              DateTime dateTime = DateTime.parse(todo.createdAt.toString());
              String formattedDate = DateFormat('MM-dd-yyyy').format(dateTime);

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // added space
                  const SizedBox(height: 10),

                  // title of todo textfield
                  const TodoTitleText(text: "Title"),
                  TextField(
                    controller: titleController,
                    decoration: const InputDecoration(
                      filled: true,
                      fillColor: Color.fromARGB(255, 242, 239, 239),
                      enabled: false,
                      border: OutlineInputBorder(),
                    ),
                  ),

                  // added space
                  const SizedBox(height: 10),

                  // description of todo textfield
                  const TodoTitleText(text: "Description"),
                  TextField(
                    controller: descriptionController,
                    decoration: const InputDecoration(
                      filled: true,
                      fillColor: Color.fromARGB(255, 242, 239, 239),
                      enabled: false,
                      border: OutlineInputBorder(),
                    ),
                    maxLines: 10,
                  ),

                  // added space
                  const SizedBox(height: 10),

                  // button to add new todo to state
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                        children: [
                          const Text(
                            "Created on",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                          Text(
                            formattedDate,
                            style: const TextStyle(fontSize: 20),
                          ),
                        ],
                      ),
                      SizedBox(
                        width: 100,
                        height: 50,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.pushNamed(context, '/edit-todo',
                                arguments: todo);
                          },
                          style: ElevatedButton.styleFrom(
                            // Reducing padding to ensure the button content fits well
                            padding: EdgeInsets.zero,
                            // Use a square shape
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                  5), // This ensures the button is square
                            ),
                          ),
                          child: const Text("Edit"),
                        ),
                      ),
                      SizedBox(
                        width: 100,
                        height: 50,
                        child: ElevatedButton(
                          onPressed: () {
                            BlocProvider.of<TodoCubit>(context)
                                .finishTodo(todo.id, todo.finished);
                            Navigator.of(context).pop();
                          },
                          style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.zero,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5),
                            ),
                          ),
                          child:
                              Text(todo.finished ? "Not Finished" : "Finished"),
                        ),
                      ),
                    ],
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
