import 'package:flutter/material.dart';
import 'package:flutter_planner/home_page.dart';

import 'package:flutter_planner/login/presentation/login_page.dart';
import 'package:flutter_planner/models/todo_model.dart';
import 'package:flutter_planner/todo/add_todo_page.dart';
import 'package:flutter_planner/todo/edit_todo_page.dart';
import 'package:flutter_planner/todo/finished_todo_page.dart';
import 'package:flutter_planner/todo/todo_page.dart';
import 'package:flutter_planner/todo/view_todo_page.dart';
import 'package:flutter_planner/weather/presentation/pages/weather_page.dart';

class AppRouter {
  static Route<Widget> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case "/":
        return MaterialPageRoute(builder: (_) => const LoginPage());
      case "/home":
        return MaterialPageRoute(builder: (_) => const HomePage());
      case '/todo':
        return MaterialPageRoute(builder: (_) => const TodoPage());
      case '/add-todo':
        return MaterialPageRoute(builder: (_) => const AddTodoPage());
      case '/finished-todo':
        return MaterialPageRoute(builder: (_) => const FinishedTodoPage());
      case '/edit-todo':
        print(" from routerrrrrrrrrrrrrrrrrr${settings.arguments}");
        final Todo? todo = settings.arguments as Todo?;
        return MaterialPageRoute(builder: (_) => EditTodoPage(todo: todo));
      case '/view-todo':
        final todoId = settings.arguments as String;
        return MaterialPageRoute(builder: (_) => ViewTodoPage(todoId: todoId));
      case '/weather':
        return MaterialPageRoute(
          builder: (_) => const WeatherPage(),
        );
      default:
        return _errorRoute();
    }
  }

  static Route<Widget> _errorRoute() {
    return MaterialPageRoute<Widget>(builder: (_) {
      return Scaffold(
        appBar: AppBar(title: const Text('Error')),
        body: const Center(
          child: Text('ERROR 404: Route was not found!!!'),
        ),
      );
    });
  }
}
