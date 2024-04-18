import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_planner/views/components/gradient_button.dart';
import 'package:flutter_planner/views/authentication/bloc/auth_bloc.dart';
import 'package:flutter_planner/views/components/login_field.dart';
import 'package:sign_in_button/sign_in_button.dart';

class Signup extends StatelessWidget {
  final void Function()? onTap;
  const Signup({super.key, this.onTap});

  @override
  Widget build(BuildContext context) {
    final TextEditingController emailController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();
    final TextEditingController usernameController = TextEditingController();
    final TextEditingController confirmPasswordController =
        TextEditingController();
    return SingleChildScrollView(
      child: ConstrainedBox(
        constraints: BoxConstraints(
          minHeight: MediaQuery.of(context).size.height,
        ),
        child: IntrinsicHeight(
          child: Center(
            child: Column(
              children: [
                const Text(
                  'Sign up.',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 50,
                  ),
                ),
                const SizedBox(height: 50),
                LoginField(
                  hintText: 'Username',
                  controller: usernameController,
                ),
                const SizedBox(height: 15),
                LoginField(
                  hintText: 'Email',
                  controller: emailController,
                ),
                const SizedBox(height: 15),
                LoginField(
                  hintText: 'Password',
                  controller: passwordController,
                ),
                const SizedBox(height: 15),
                LoginField(
                  hintText: 'Confirm Password',
                  controller: confirmPasswordController,
                ),
                const SizedBox(height: 20),
                GradientButton(
                  onPressed: () {
                    context.read<AuthBloc>().add(AuthSignupRequested(
                          email: emailController.text.trim(),
                          password: passwordController.text.trim(),
                          username: usernameController.text.trim(),
                        ));
                  },
                  text: 'Sign Up',
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Already have an account? ",
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.primary),
                    ),
                    GestureDetector(
                      onTap: onTap,
                      child: Text(
                        "Login here",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                    )
                  ],
                ),
                const SizedBox(height: 20),
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Divider(),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                SignInButton(
                  Buttons.google,
                  text: "Sign up with Google",
                  onPressed: () {},
                ),
                const SizedBox(height: 5),
                SignInButton(
                  Buttons.apple,
                  onPressed: () {},
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
