import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_planner/todo/components/todo_text_field.dart';
import 'package:flutter_planner/todo/components/todo_title_text.dart';
import 'package:flutter_planner/cubit/todo_cubit.dart';
import 'package:flutter_planner/models/todo_model.dart';

class EditTodoPage extends StatelessWidget {
  EditTodoPage({
    super.key,
  });

  final _todoTitleController = TextEditingController();

  final _todoDescriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final todo = ModalRoute.of(context)!.settings.arguments as Todo;

    _todoTitleController.text = todo.name;
    _todoDescriptionController.text = todo.description;

    return Scaffold(
      backgroundColor: Colors.purple[300],
      appBar: AppBar(
        backgroundColor: Colors.purple[600],
        title: const Text('Todo',
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
                    controller: _todoTitleController,
                    enabled: true,
                    maxLines: 1,
                    hintText: "Enter Title",
                    filled: true,
                    color: const Color.fromARGB(255, 242, 239, 239),
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
                    controller: _todoDescriptionController,
                    enabled: true,
                    maxLines: 10,
                    hintText: "Enter Description",
                    filled: true,
                    color: const Color.fromARGB(255, 242, 239, 239),
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
                      BlocProvider.of<TodoCubit>(context).editTodo(
                        todo.id,
                        _todoTitleController.text.trim(),
                        _todoDescriptionController.text.trim(),
                      );
                      Navigator.of(context).pop();
                    },
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.zero,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                    child: const Text('Edit')),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
