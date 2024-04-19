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

          if (state is AuthSuccess) {
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

          // return SingleChildScrollView(
          //   child: ConstrainedBox(
          //     constraints: BoxConstraints(
          //       minHeight: MediaQuery.of(context).size.height,
          //     ),
          //     child: IntrinsicHeight(
          //       child: Center(
          //         child: Column(
          //           mainAxisAlignment: MainAxisAlignment.center,
          //           children: [
          //             const Text(
          //               'Sign in.',
          //               style: TextStyle(
          //                 fontWeight: FontWeight.bold,
          //                 fontSize: 50,
          //               ),
          //             ),
          //             const SizedBox(height: 50),
          //             LoginField(
          //               hintText: 'Email',
          //               controller: emailController,
          //             ),
          //             const SizedBox(height: 15),
          //             LoginField(
          //               hintText: 'Password',
          //               controller: passwordController,
          //             ),
          //             const SizedBox(height: 20),
          //             GradientButton(
          //               onPressed: () {
          //                 context.read<AuthBloc>().add(AuthLoginRequested(
          //                       email: emailController.text.trim(),
          //                       password: passwordController.text.trim(),
          //                     ));
          //               },
          //               text: 'Login',
          //             ),
          //             const SizedBox(height: 20),
          //             const Text(
          //               'or',
          //               style: TextStyle(
          //                 fontSize: 17,
          //               ),
          //             ),
          //             const SizedBox(height: 50),
          //             SignInButton(
          //               Buttons.google,
          //               text: "Sign up with Google",
          //               onPressed: () {},
          //             ),
          //             const SizedBox(height: 5),
          //             SignInButton(
          //               Buttons.apple,
          //               onPressed: () {},
          //             ),
          //           ],
          //         ),
          //       ),
          //     ),
          //   ),
          // );
        },
      ),
    );
  }
}
