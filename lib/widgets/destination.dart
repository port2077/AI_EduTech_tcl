import 'package:flutter/material.dart';

class DestinationCard extends StatelessWidget {
  const DestinationCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Destinations',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500)),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildDestinationCard(
                  'UK', 'assets/images/uk_flag.png', Colors.pink[50]!),
              _buildDestinationCard(
                  'USA', 'assets/images/us_flag.png', Colors.green[50]!),
              _buildDestinationCard(
                  'Canada', 'assets/images/canada_flag.png', Colors.blue[50]!),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDestinationCard(String country, String imagePath, Color color) {
    return Container(
      width: 104,
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Image.asset(imagePath, width: 50, height: 30),
          ),
          const SizedBox(height: 8),
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              country,
              style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
            ),
          ),
        ],
      ),
    );
  }
}
