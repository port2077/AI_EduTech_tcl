import 'package:flutter/material.dart';

class CustomSearchBar extends StatelessWidget {
  const CustomSearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 48,
      child: TextField(
        decoration: InputDecoration(
          hintText: 'Search your Courses, Universities and Country',
          hintStyle: const TextStyle(color: Colors.grey, fontSize: 14),
          prefixIcon:
              Image.asset('assets/images/search.png', width: 24, height: 24),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          contentPadding:
              const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
        ),
      ),
    );
  }
}
