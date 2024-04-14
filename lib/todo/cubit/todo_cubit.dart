import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_planner/models/todo_model.dart';
import 'package:uuid/uuid.dart';

/*
  TodoCubit handles the state of the todos
*/

class TodoCubit extends Cubit<List<Todo>> {
  TodoCubit() : super([]);

  // find and return a Todo by its id
  //
  Todo? getTodoById(String id) {
    try {
      return state.firstWhere((todo) => todo.id == id);
    } catch (e) {
      return null;
    }
  }

  // Add a new todo
  //
  void addTodo(String title, String description) {
    // UUID to create a unique id for a todo
    //
    const uuid = Uuid();

    // Check for empty title
    //
    if (title.isEmpty) {
      addError("Title cannot be empty");
      return;
    }

    // create new todo using the TodoModel
    //
    final todo = Todo(
        id: uuid.v4(),
        name: title,
        description: description,
        createdAt: DateTime.now(),
        finished: false);

    // add new todo to previous state
    //
    emit([todo, ...state]);
  }

  // Edit a todo by id
  //
  void editTodo(String id, String title, String description) {
    int todoIndex = state.indexWhere((todo) => todo.id == id);

    if (todoIndex != -1) {
      // Make a list of todos
      //
      final List<Todo> updatedTodos = List.from(state);

      // Update todo with new title and description
      //
      updatedTodos[todoIndex] = updatedTodos[todoIndex].copyWith(
        name: title,
        description: description,
      );

      // Emit the updated todo list as the new state
      //
      emit(updatedTodos);
    }
  }

  // Mark the todo finished
  //
  void finishTodo(String id, bool finish) {
    bool finished = !finish;

    // Id of todo
    //
    int todoIndex = state.indexWhere((todo) => todo.id == id);

    if (todoIndex != -1) {
      // Make a list of todos
      //
      final List<Todo> updatedTodos = List.from(state);

      // updated the todo with the new finished value
      //
      updatedTodos[todoIndex] =
          updatedTodos[todoIndex].copyWith(finished: finished);

      // Emit the updated todo list as the new state
      //
      emit(updatedTodos);
    }
  }
}
