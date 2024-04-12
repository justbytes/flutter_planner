import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_planner/app_bloc_observer.dart';
import 'package:flutter_planner/todo/cubit/todo_cubit.dart';
import 'package:flutter_planner/home_page.dart';
import 'package:flutter_planner/login/bloc/auth_bloc.dart';
import 'package:flutter_planner/login/login_page.dart';
import 'package:flutter_planner/todo/add_todo_page.dart';
import 'package:flutter_planner/todo/finished_todo_page.dart';
import 'package:flutter_planner/todo/todo_page.dart';
import 'package:flutter_planner/todo/edit_todo_page.dart';
import 'package:flutter_planner/todo/view_todo_page.dart';
import 'package:flutter_planner/weather/bloc/weather_bloc.dart';
import 'package:flutter_planner/weather/data/data_provider/weather_data_provider.dart';
import 'package:flutter_planner/weather/data/repository/weather_repository.dart';
import 'package:flutter_planner/weather/presentation/pages/weather_page.dart';

void main() {
  Bloc.observer = AppBlocObserver();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => WeatherRepository(
        WeatherDataProvider(),
      ),
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => TodoCubit(),
          ),
          BlocProvider(
            create: (context) => AuthBloc(),
          ),
          BlocProvider(
            create: (context) => WeatherBloc(
              context.read<WeatherRepository>(),
            ),
          ),
        ],
        child: MaterialApp(
          title: 'Flutter Planner',
          theme: ThemeData.dark(useMaterial3: true),
          initialRoute: '/',
          routes: {
            '/': (_) => const WeatherPage(),
            '/home': (_) => const HomePage(),
            '/todo': (_) => const TodoPage(),
            '/add-todo': (_) => const AddTodoPage(),
            '/edit-todo': (_) => EditTodoPage(),
            '/view-todo': (_) => const ViewTodoPage(),
            '/finished-todo': (_) => const FinishedTodoPage(),
          },
        ),
      ),
    );
  }
}
