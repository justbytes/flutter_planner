import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_planner/cubit/todo_cubit.dart';
import 'package:flutter_planner/todo/add_todo_page.dart';
import 'package:flutter_planner/todo/finished_todo_page.dart';
import 'package:flutter_planner/todo/todo_page.dart';
import 'package:flutter_planner/todo/edit_todo_page.dart';
import 'package:flutter_planner/todo/view_todo_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TodoCubit(),
      child: MaterialApp(
        title: 'Flutter Planner',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        initialRoute: '/',
        routes: {
          '/': (_) => const TodoPage(),
          '/add-todo': (_) => const AddTodoPage(),
          '/edit-todo': (_) => EditTodoPage(),
          '/view-todo': (_) => const ViewTodoPage(),
          '/finished-todo': (_) => const FinishedTodoPage(),
        },
      ),
    );
  }
}
