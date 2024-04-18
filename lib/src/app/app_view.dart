import 'package:flutter/material.dart';
import 'package:flutter_planner/router/app_router.dart';

class AppView extends StatelessWidget {
  const AppView({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Planner',
      theme: ThemeData.dark(useMaterial3: true),
      onGenerateRoute: AppRouter.generateRoute,
      initialRoute: '/',
    );
  }
}
