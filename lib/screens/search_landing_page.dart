import 'package:flutter/material.dart';
import 'package:tcl_global/widgets/navigation.dart';
import 'package:tcl_global/widgets/searchbar.dart';

class SearchLandingPage extends StatefulWidget {
  @override
  _SearchLandingPageState createState() => _SearchLandingPageState();
}

class _SearchLandingPageState extends State<SearchLandingPage> {
  List<String> recentSearches = [];

  void addSearch(String search) {
    setState(() {
      if (recentSearches.length >= 6) {
        recentSearches.removeAt(0);
      }
      recentSearches.add(search);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: _buildAppBar(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const CustomSearchBar(),
            const SizedBox(height: 20),
            Text(
              'Searching For......',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildCategoryButton('Courses (24)'),
                _buildCategoryButton('Universities (122)'),
                _buildCategoryButton('Countries (4)'),
              ],
            ),
            const SizedBox(height: 20),
            Text(
              'Recent Searches',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: recentSearches.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(recentSearches[index]),
                    trailing: IconButton(
                      icon: Icon(Icons.close),
                      onPressed: () {
                        setState(() {
                          recentSearches.removeAt(index);
                        });
                      },
                    ),
                    onTap: () {
                      // TODO: Implement navigation to search result page
                      print('Tapped on ${recentSearches[index]}');
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBarWidget(
        selectedIndex: 0,
        onTap: (index) {
          // TODO: Handle bottom navigation tap
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
    );
  }

  Widget _buildCategoryButton(String title) {
    return ElevatedButton(
      onPressed: () {
        // TODO: Implement navigation to category-specific page
        print('Tapped on $title');
      },
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.black,
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      child: Text(title),
    );
  }
}
