import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_planner/cubit/todo_cubit.dart';
import 'package:flutter_planner/models/todo_model.dart';

class TodoPage extends StatelessWidget {
  const TodoPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.purple[300],
      appBar: AppBar(
          backgroundColor: Colors.purple[600],
          title: const Text(
            'Todo List',
            style: TextStyle(
              fontSize: 36,
              color: Color.fromARGB(255, 242, 239, 239),
              fontWeight: FontWeight.bold,
            ),
          )),
      body: BlocBuilder<TodoCubit, List<Todo>>(
        builder: (context, todos) {
          final unfinishedTodos =
              todos.where((todo) => !todo.finished).toList();
          return ListView.builder(
              itemCount: unfinishedTodos.length,
              itemBuilder: (context, index) {
                final todo = unfinishedTodos[index];

                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 242, 239, 239),
                        border: Border.all(width: 1),
                        borderRadius: BorderRadius.circular(5)),
                    child: ListTile(
                      title: Text(todo.name),
                      onTap: () {
                        Navigator.pushNamed(context, '/view-todo',
                            arguments: todo.id);
                      },
                    ),
                  ),
                );
              });
        },
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: () {
              Navigator.pushNamed(context, '/finished-todo');
            },
            tooltip: 'View completed todos',
            child: const Icon(Icons.history),
          ),
          const SizedBox(
            height: 10,
          ),
          FloatingActionButton(
            onPressed: () {
              Navigator.pushNamed(context, '/add-todo');
            },
            tooltip: 'Add Todo',
            child: const Icon(Icons.add),
          ),
        ],
      ),
    );
  }
}
