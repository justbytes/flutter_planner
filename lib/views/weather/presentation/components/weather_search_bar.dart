import 'package:flutter/material.dart';
import 'package:flutter_planner/views/components/gradient_button.dart';
import 'package:flutter_planner/views/components/login_field.dart';
import 'package:flutter_planner/src/themes/pallete.dart';

class WeatherSearchBar extends StatelessWidget {
  final TextEditingController cityController;
  final TextEditingController stController;
  final void Function() onPressed;

  const WeatherSearchBar({
    super.key,
    required this.cityController,
    required this.stController,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 50,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [
            Pallete.gradient1,
            Pallete.gradient2,
            Pallete.gradient3,
          ],
          begin: Alignment.bottomLeft,
          end: Alignment.topRight,
        ),
        borderRadius: BorderRadius.circular(7),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.transparent,
              shadowColor: Colors.transparent,
            ),
            child: Text(
              "Weather for ${cityController.text}, ${stController.text}. Click to change",
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            onPressed: () {
              showModalBottomSheet<void>(
                context: context,
                builder: (BuildContext context) {
                  // MediaQuery to detect keyboard presence and adjust padding
                  final EdgeInsets padding = MediaQuery.of(context).viewInsets;
                  return Padding(
                    padding: EdgeInsets.only(bottom: padding.bottom),
                    child: SingleChildScrollView(
                      child: Container(
                        height: 300, // You might want to adjust this height
                        color: Pallete.backgroundColor,
                        child: Center(
                          child: Column(
                            mainAxisSize:
                                MainAxisSize.min, // Important for scrolling
                            children: <Widget>[
                              const Text(
                                "Search",
                                style: TextStyle(
                                  fontSize: 28,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 20),
                              LoginField(
                                hintText: "City",
                                controller: cityController,
                              ),
                              const SizedBox(height: 10),
                              LoginField(
                                hintText: "State",
                                controller:
                                    stController, // Make sure this is for state
                              ),
                              const SizedBox(height: 20),
                              GradientButton(
                                onPressed: onPressed,
                                text: "change city",
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
