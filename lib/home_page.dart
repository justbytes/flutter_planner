import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_planner/global_components/app_bar_title.dart';
import 'package:flutter_planner/global_components/reverse_gradient_button.dart';
import 'package:flutter_planner/login/bloc/auth_bloc.dart';
import 'package:flutter_planner/global_components/gradient_button.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const AppBarTitle(
          title: "Home",
        ),
        centerTitle: true,
      ),
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          // if (state is AuthInitial) {
          //   Navigator.pushAndRemoveUntil(
          //     context,
          //     MaterialPageRoute(
          //       builder: (context) => const LoginPage(),
          //     ),
          //     (route) => false,
          //   );
          // }
        },
        builder: (context, state) {
          if (state is AuthSuccess) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Welcome, User ${state.user.user?.email}',
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  GradientButton(
                    onPressed: () {
                      Navigator.pushNamed(context, "/todo");
                    },
                    text: 'What Todo',
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  ReverseGradientButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/weather');
                    },
                    text: 'Weather Center',
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  GradientButton(
                    onPressed: () {
                      context.read<AuthBloc>().add(AuthLogoutRequested());
                    },
                    text: 'Log Out',
                  ),
                ],
              ),
            );
          }
          if (state is AuthLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (state is AuthFailure) {
            return const Center(
              child: Text("There was an error"),
            );
          }
          if (state is AuthInitial) {
            return const Center(
              child: Text("State is Auth Initial"),
            );
          }
          return const Center(
            child: Text("Looks like we're in some unknown state"),
          );
        },
      ),
    );
  }
}
