import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_planner/views/components/app_bar_title.dart';
import 'package:flutter_planner/views/components/reverse_gradient_button.dart';
import 'package:flutter_planner/views/authentication/bloc/auth_bloc.dart';
import 'package:flutter_planner/views/components/gradient_button.dart';

class HomePage extends StatelessWidget {
  const HomePage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const AppBarTitle(
          title: "Home",
        ),
        centerTitle: true,
      ),
      body: BlocBuilder<AuthBloc, AuthState>(
        builder: (context, state) {
          // Displays UI for a User logged in with Google Provider
          //
          if (state is GoogleSuccess) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Welcome, User ${state.user.user?.displayName}',
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
                      Navigator.pushNamed(context, '/');
                    },
                    text: 'Log Out',
                  ),
                ],
              ),
            );
          }

          // Displays UI for User logged in with Email & Password
          if (state is AuthSuccess) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Welcome, User ${state.user?.displayName}',
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
                      Navigator.pushNamed(context, '/');
                    },
                    text: 'Log Out',
                  ),
                ],
              ),
            );
          }

          // Displays a progress spinning bar
          //
          if (state is AuthLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          // Diplays statement to inform of an Auth Error
          // [TODO]: get the specific error when AuthFailure occurs
          //
          if (state is AuthFailure) {
            return const Center(
              child: Text("There was an Auth Error"),
            );
          }

          // Display Unauthorized screen to block unauthorized users
          //
          if (state is AuthInitial) {
            return const Center(
              child: Text("Unauthorized"),
            );
          }

          // Displays current state is unkown
          //
          return const Center(
            child: Text("Looks like we're in some unknown state"),
          );
        },
      ),
    );
  }
}
