import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_planner/src/app/app_view.dart';
import 'package:flutter_planner/views/authentication/bloc/auth_bloc.dart';
import 'package:flutter_planner/router/app_router.dart';

import 'package:flutter_planner/views/authentication/data/repository/auth_repository.dart';
import 'package:flutter_planner/views/todo/cubit/todo_cubit.dart';
import 'package:flutter_planner/views/weather/bloc/weather_bloc.dart';
import 'package:flutter_planner/views/weather/data/data_provider/weather_data_provider.dart';
import 'package:flutter_planner/views/weather/data/repository/weather_repository.dart';

class App extends StatelessWidget {
  final AuthRepository _authRepository;
  const App({
    super.key,
    required AuthRepository authRepository,
  }) : _authRepository = authRepository;

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(
          create: (context) => _authRepository,
        ),
        RepositoryProvider(
          create: (context) => WeatherRepository(
            WeatherDataProvider(),
          ),
        ),
      ],
      child: MultiBlocProvider(providers: [
        BlocProvider(
          create: (context) => AuthBloc(
            context.read<AuthRepository>(),
          ),
        ),
        BlocProvider(
          create: (context) => TodoCubit(),
        ),
        BlocProvider(
          create: (context) => WeatherBloc(
            context.read<WeatherRepository>(),
          ),
        ),
      ], child: const AppView()),
    );
  }
}
