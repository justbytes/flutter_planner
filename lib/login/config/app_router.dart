import 'package:flutter/material.dart';
import 'package:flutter_planner/home_page.dart';

import 'package:flutter_planner/login/presentation/login_page.dart';
import 'package:flutter_planner/todo/add_todo_page.dart';
import 'package:flutter_planner/todo/edit_todo_page.dart';
import 'package:flutter_planner/todo/finished_todo_page.dart';
import 'package:flutter_planner/todo/todo_page.dart';
import 'package:flutter_planner/todo/view_todo_page.dart';
import 'package:flutter_planner/weather/presentation/pages/weather_page.dart';

class AppRouter {
  static Route<Widget> generateRoute(RouteSettings settings) {
    print("Settings from app router ${settings}");
    switch (settings.name) {
      case "/":
        return MaterialPageRoute(builder: (_) => const LoginPage());

      case "/home":
        return MaterialPageRoute(builder: (_) => const HomePage());
      case '/todo':
        return MaterialPageRoute(builder: (_) => const TodoPage());
      case '/add-todo':
        return MaterialPageRoute(builder: (_) => const AddTodoPage());
      case '/edit-todo':
        return MaterialPageRoute(builder: (_) => EditTodoPage());
      case '/finished-todo':
        return MaterialPageRoute(builder: (_) => const FinishedTodoPage());
      case '/view-todo':
        return MaterialPageRoute(builder: (_) => const ViewTodoPage());
      case '/weather':
        return MaterialPageRoute(
            builder: (_) => const WeatherPage(), settings: settings);
      default:
        return _errorRoute();
    }
  }

  static Route<Widget> _errorRoute() {
    return MaterialPageRoute<Widget>(builder: (_) {
      return Scaffold(
        appBar: AppBar(title: Text('Error')),
        body: const Center(
          child: Text('ERROR: Route was not found!!!'),
        ),
      );
    });
  }
}
