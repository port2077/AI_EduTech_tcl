import 'package:flutter/material.dart';

class OpportunitiesCard extends StatelessWidget {
  const OpportunitiesCard({super.key});

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
          const Text('Explore your opportunities',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500)),
          const SizedBox(height: 16),
          IntrinsicHeight(
            child: Row(
              children: [
                _buildOpportunityCard('26', 'Recommended Courses'),
                const SizedBox(width: 8),
                _buildOpportunityCard('12', 'Affordable Courses'),
              ],
            ),
          ),
          const SizedBox(height: 8),
          IntrinsicHeight(
            child: Row(
              children: [
                _buildOpportunityCard('34', 'Online Courses'),
                const SizedBox(width: 8),
                _buildOpportunityCard('45', 'Top Universities'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOpportunityCard(String number, String title) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.blue[50],
          borderRadius: BorderRadius.circular(4),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(number,
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold)),
                Image.asset('assets/images/arrow_icon.png',
                    width: 18, height: 18),
              ],
            ),
            const SizedBox(height: 2),
            Text(title, style: const TextStyle(fontSize: 12)),
          ],
        ),
      ),
    );
  }
}
