import 'package:flutter/material.dart';

class BottomNavigationBarWidget extends StatefulWidget {
  final int selectedIndex;
  final Function(int) onTap;

  const BottomNavigationBarWidget({
    super.key,
    required this.selectedIndex,
    required this.onTap,
  });

  @override
  State<BottomNavigationBarWidget> createState() =>
      _BottomNavigationBarWidgetState();
}

class _BottomNavigationBarWidgetState extends State<BottomNavigationBarWidget> {
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      backgroundColor: Colors.white,
      currentIndex: widget.selectedIndex,
      items: [
        BottomNavigationBarItem(
            icon: Image.asset('assets/images/home_tab.png',
                width: 24, height: 24),
            label: 'HOME'),
        BottomNavigationBarItem(
            icon: Image.asset('assets/images/applications_tab.png',
                width: 24, height: 24),
            label: 'APPLICATION'),
        BottomNavigationBarItem(
            icon: Image.asset('assets/images/visa_tab.png',
                width: 24, height: 24),
            label: 'VISA'),
      ],
      selectedLabelStyle: const TextStyle(fontSize: 12),
      unselectedLabelStyle: const TextStyle(fontSize: 10),
      onTap: widget.onTap,
    );
  }
}

void onDestinationTap(String country) {
  // TODO: Implement navigation to country-specific page
  print('Tapped on $country');
}

void onOpportunityTap(String opportunity) {
  // TODO: Implement navigation to opportunity-specific page
  print('Tapped on $opportunity');
}

void onBottomNavTap(int index) {
  // TODO: Handle navigation
}
