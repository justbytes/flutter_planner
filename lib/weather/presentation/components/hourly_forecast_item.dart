import 'package:flutter/material.dart';

/* 
________________________________________________________________________________
Stateless class HourlyForecastItem
  List item that contains the time, temp, and weather icon of an hourly forecast
  
  Takes 2 arguments
  sky - String containing the weather icon
  temp - String of the current temp
  time - String of the current time formatted to h:mm a
________________________________________________________________________________
*/

class HourlyForecastItem extends StatelessWidget {
  final String time;
  final String temperature;
  final String sky;

  const HourlyForecastItem({
    super.key,
    required this.time,
    required this.temperature,
    required this.sky,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      child: Container(
        width: 100,
        padding: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: [
            Text(
              time,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 8),
            Icon(
              sky == 'Clouds' || sky == 'Rain' ? Icons.cloud : Icons.sunny,
              size: 32,
            ),
            const SizedBox(height: 8),
            Text(temperature),
          ],
        ),
      ),
    );
  }
}
