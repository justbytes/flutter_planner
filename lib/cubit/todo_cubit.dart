import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_planner/models/todo_model.dart';
import 'package:uuid/uuid.dart';

class TodoCubit extends Cubit<List<Todo>> {
  TodoCubit() : super([]);

  Todo? getTodoById(String id) {
    try {
      return state.firstWhere((todo) => todo.id == id);
    } catch (e) {
      // Return null if todo with the given id is not found
      return null;
    }
  }

  void addTodo(String title, String description) {
    // UUID to create a unique id for a todo
    const uuid = Uuid();

    // Check for empty title
    if (title.isEmpty) {
      addError("Title cannot be empty");
      return;
    }

    // create new todo
    final todo = Todo(
        id: uuid.v4(),
        name: title,
        description: description,
        createdAt: DateTime.now(),
        finished: false);

    // add new todo to previous state
    emit([todo, ...state]);
  }

  void editTodo(String id, String title, String description) {
    // Find the index of the Todo to update
    int todoIndex = state.indexWhere((todo) => todo.id == id);

    // Check to see if todo exists
    if (todoIndex != -1) {
      // Copy the current state to a new list to modify
      final List<Todo> updatedTodos = List.from(state);

      // Update the todo item at the found index
      updatedTodos[todoIndex] = updatedTodos[todoIndex].copyWith(
        name: title,
        description: description,
      );

      // Emit the updated todo list as the new state
      emit(updatedTodos);
    }
  }

  // Mark the todo finished
  void finishTodo(String id, bool finish) {
    // finished is the opposite of whatever the current state to add the
    // todo back if its not done
    bool finished = !finish;

    // get a specific todo by the id
    int todoIndex = state.indexWhere((todo) => todo.id == id);

    // if todo exists
    if (todoIndex != -1) {
      // Copy the current state to a new list to modify
      final List<Todo> updatedTodos = List.from(state);

      // Update the todo item at the found index
      updatedTodos[todoIndex] =
          updatedTodos[todoIndex].copyWith(finished: finished);

      // Emit the updated todo list as the new state
      emit(updatedTodos);
    }
  }

  @override
  void onChange(Change<List<Todo>> change) {
    super.onChange(change);
    if (kDebugMode) {
      print('TodoCubit - $change');
    }
  }

  @override
  void onError(Object error, StackTrace stackTrace) {
    super.onError(error, stackTrace);
    if (kDebugMode) {
      print('TodoCubit - $error');
    }
  }
}
