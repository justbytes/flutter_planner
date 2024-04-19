import 'package:flutter/material.dart';
import 'package:flutter_planner/src/themes/pallete.dart';
import 'package:flutter_svg/svg.dart';

class SocialLogins extends StatelessWidget {
  const SocialLogins({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: ElevatedButton(
            onPressed: () {
              // Your sign-in logic here
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.transparent,
              shadowColor: Colors.transparent,
              surfaceTintColor: Colors.transparent,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(7),
                  side: const BorderSide(
                    color: Pallete.borderColor,
                    width: 3,
                  )),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SvgPicture.asset('assets/google_login.svg'),
                ),
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: ElevatedButton(
            onPressed: () {
              // Your sign-in logic here
            },
            style: ElevatedButton.styleFrom(
              shadowColor: Colors.transparent,
              surfaceTintColor: Colors.transparent, // No shadow
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(7),
                  side: const BorderSide(
                    color: Pallete.borderColor,
                    width: 3,
                  )),
            ),
            child: const Padding(
              padding: EdgeInsets.all(8.0),
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.apple, color: Colors.white), // Apple icon
                    Text(' Sign in with Apple',
                        style: TextStyle(color: Colors.white)),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
