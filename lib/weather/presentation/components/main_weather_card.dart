import 'dart:ui';
import 'package:flutter/material.dart';

/* 
________________________________________________________________________________
Stateless class MainWeatherCard
  SizedBox that makes the main card that are made up of the current temp and
    current weather icon
  
  Takes 2 arguments
  sky - String containing the weather icon
  temp - String of the current temp
________________________________________________________________________________
*/

class MainWeatherCard extends StatelessWidget {
  final String sky;
  final num temp;
  const MainWeatherCard({super.key, required this.sky, required this.temp});

  @override
  Widget build(BuildContext context) {
    return // main card
        SizedBox(
      width: double.infinity,
      child: Card(
        elevation: 10,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: BackdropFilter(
            filter: ImageFilter.blur(
              sigmaX: 10,
              sigmaY: 10,
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Text(
                    '$temp F',
                    style: const TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Icon(
                    sky == 'Clouds' || sky == 'Rain'
                        ? Icons.cloud
                        : Icons.sunny,
                    size: 64,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    sky,
                    style: const TextStyle(
                      fontSize: 20,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
