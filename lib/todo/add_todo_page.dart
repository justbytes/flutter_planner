import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_planner/todo/components/todo_text_field.dart';
import 'package:flutter_planner/todo/components/todo_title_text.dart';
import 'package:flutter_planner/todo/cubit/todo_cubit.dart';

class AddTodoPage extends StatefulWidget {
  const AddTodoPage({super.key});

  @override
  State<AddTodoPage> createState() => _AddTodoPageState();
}

class _AddTodoPageState extends State<AddTodoPage> {
  final todoTitleController = TextEditingController();
  final todoDescriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.purple[300],
      appBar: AppBar(
        backgroundColor: Colors.purple[600],
        title: const Text('Add Todo',
            style: TextStyle(
              fontSize: 36,
              color: Color.fromARGB(255, 242, 239, 239),
              fontWeight: FontWeight.bold,
            )),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              // added space
              const SizedBox(height: 10),

              // title of todo textfield
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const TodoTitleText(text: "Title"),
                  TodoTextField(
                    controller: todoTitleController,
                    enabled: true,
                    filled: true,
                    color: const Color.fromARGB(255, 242, 239, 239),
                    maxLines: 1,
                    hintText: "Enter todo title",
                  ),
                ],
              ),

              // added space
              const SizedBox(height: 10),

              // description of todo textfield
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const TodoTitleText(text: "Description"),
                  TodoTextField(
                    controller: todoDescriptionController,
                    filled: true,
                    color: const Color.fromARGB(255, 242, 239, 239),
                    enabled: true,
                    maxLines: 10,
                    hintText: "Enter todo description",
                  ),
                ],
              ),

              // added space
              const SizedBox(height: 10),

              // button to add new todo to state
              SizedBox(
                width: 100,
                height: 50,
                child: ElevatedButton(
                    onPressed: () {
                      BlocProvider.of<TodoCubit>(context).addTodo(
                        todoTitleController.text.trim(),
                        todoDescriptionController.text.trim(),
                      );
                      Navigator.of(context).pop();
                    },
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.zero,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                    child: const Text('Add')),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
