import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_planner/views/authentication/presentation/components/social_loigns.dart';
import 'package:flutter_planner/views/components/gradient_button.dart';
import 'package:flutter_planner/views/authentication/bloc/auth_bloc.dart';
import 'package:flutter_planner/views/components/login_field.dart';

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
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const Text(
                  'Sign up.',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 50,
                  ),
                ),
                Column(
                  children: [
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
                    ObscureField(
                      hintText: 'Password',
                      controller: passwordController,
                    ),
                    const SizedBox(height: 15),
                    ObscureField(
                      hintText: 'Confirm Password',
                      controller: confirmPasswordController,
                    ),
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Divider(),
                        ],
                      ),
                    ),
                    GradientButton(
                      onPressed: () {
                        bool valid = _validateFields(
                          usernameController.text.trim(),
                          emailController.text.trim(),
                          passwordController.text.trim(),
                          confirmPasswordController.text.trim(),
                        );
                        if (valid) {
                          context.read<AuthBloc>().add(AuthSignupRequested(
                                email: emailController.text.trim(),
                                password: passwordController.text.trim(),
                                username: usernameController.text.trim(),
                              ));
                        } else {
                          passwordController.text = '';
                          confirmPasswordController.text = '';
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: const Text("Sign Up Erorr"),
                                  content: const Text(
                                    "Fill out the entire form and ensure your passwords match.",
                                  ),
                                  actions: <Widget>[
                                    TextButton(
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                        child: const Text("Ok"))
                                  ],
                                );
                              });
                        }
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
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Divider(),
                        ],
                      ),
                    ),
                    SocialLogins(
                      onGooglePressed: () {
                        context.read<AuthBloc>().add(GoogleLoginRequested());
                      },
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// Bool Function with a nested conditional
// Outer conditial checks to ensure none of the fields are an empty string
// Innter conditial checks that the passwords match
// returns a bool of true if form was valid meaning no empty strings and matching passwords
//
bool _validateFields(
    String email, String displayName, String password, String confirmPassword) {
  if (email != '' &&
      displayName != '' &&
      password != '' &&
      confirmPassword != '') {
    if (password == confirmPassword) {
      return true;
    } else {
      return false;
    }
  } else {
    return false;
  }
}
