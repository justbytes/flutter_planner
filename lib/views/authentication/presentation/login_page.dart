import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_planner/views/home/home_page.dart';
import 'package:flutter_planner/views/authentication/bloc/auth_bloc.dart';
import 'package:flutter_planner/views/authentication/presentation/components/login.dart';
import 'package:flutter_planner/views/authentication/presentation/components/signup.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginPage> {
  bool showLoginPage = true;

  void togglePages() {
    setState(() {
      showLoginPage = !showLoginPage;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthFailure) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text(
              state.error,
            )));
          }

          if (state is AuthSuccess || state is GoogleSuccess) {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (context) => const HomePage(),
              ),
              (route) => false,
            );
          }
        },
        builder: (context, state) {
          if (state is AuthLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (showLoginPage) {
            return Login(
              onTap: togglePages,
            );
          } else {
            return Signup(
              onTap: togglePages,
            );
          }
        },
      ),
    );
  }
}
