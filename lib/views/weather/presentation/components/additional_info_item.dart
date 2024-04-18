import 'package:flutter/material.dart';

/* 
________________________________________________________________________________
Stateless AdditionalInfoItem
  Custom component that can hold weather data values with a label and icon
  
  Takes 3 arguments
  icon - String containing the weather icon
  label - String that descrbies the data value i.e pressure, humidity..
  value - String the weather data value 
________________________________________________________________________________
*/

class AdditionalInfoItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  const AdditionalInfoItem({
    super.key,
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(
          icon,
          size: 32,
        ),
        const SizedBox(height: 8),
        Text(label),
        const SizedBox(height: 8),
        Text(
          value,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        )
      ],
    );
  }
}
