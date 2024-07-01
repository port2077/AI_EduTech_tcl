import 'package:flutter/material.dart';
import 'package:tcl_global/widgets/destination.dart';
import 'package:tcl_global/widgets/navigation.dart';
import 'package:tcl_global/widgets/searchbar.dart';

import '../widgets/opportunities_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: _buildAppBar(),
      body: const SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const CustomSearchBar(),
              const SizedBox(height: 20),
              //_buildSectionTitle(context, 'Destinations'),
              //const SizedBox(height: 10),
              const DestinationCard(),
              const SizedBox(height: 20),
              //_buildSectionTitle(context, 'Explore your opportunities'),
              //const SizedBox(height: 10),
              const OpportunitiesCard(),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBarWidget(
        selectedIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
          onBottomNavTap(index);
        },
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: const Color(0xFFF5F5F5),
      centerTitle: true,
      title: const Text(
        'AI EduTech',
        style: TextStyle(
          fontFamily: 'Poppins',
          fontSize: 20,
          fontWeight: FontWeight.w900,
          height: 1.25,
        ),
        textAlign: TextAlign.center,
      ),
      // actions: [
      //   GestureDetector(
      //     onTap: () {
      //       // TODO: Navigate to profile page
      //     },
      //     child: const CircleAvatar(
      //       child: Text('U'),
      //       backgroundColor: Colors.grey,
      //     ),
      //   ),
      // ],
    );
  }
}
