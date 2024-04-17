import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_planner/app.dart';
import 'package:flutter_planner/app_bloc_observer.dart';
import 'package:flutter_planner/cache/cache.dart';
import 'package:flutter_planner/login/data/repository/auth_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_planner/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = AppBlocObserver();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  final prefInstance = await SharedPreferences.getInstance();
  final cacheClient = CacheClient(prefInstance);
  final authRepo = AuthRepository(cache: cacheClient);
  await authRepo.user.first;

  runApp(App(authRepository: authRepo));
}
