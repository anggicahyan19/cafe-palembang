import 'package:flutter/material.dart';
import 'package:cafe_palembang/data/cafe_palembang_data.dart';
import '../model/cafe_palembang.dart';
import 'detail_screen.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  List<Cafe> _filteredCafe = [];
  String _searchQuery = '';
  final TextEditingController _searchController = TextEditingController();
  
  @override
  void initState() {
    super.initState();
    _filteredCafe = [];
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pencarian Cafe'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: Colors.brown[50],
              ),
              child: TextField(
                controller: _searchController,
                onChanged: (query) {
                  // Call the search function whenever the text changes
                  _searchCafe(query);
                },
                autofocus: false,
                decoration: InputDecoration(
                  hintText: 'Cari Cafe...',
                  prefixIcon: Icon(Icons.search),
                  border: InputBorder.none,
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.brown),
                  ),
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _filteredCafe.length,
              itemBuilder: (context, index) {
                final cafe = _filteredCafe[index];
                return Card(
                  margin: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                child: GestureDetector(
                onTap: () {
                _navigateToDetailScreen(cafe);
                },
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: EdgeInsets.all(8),
                        width: 100,
                        height: 100,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.asset(
                            cafe.imageAsset,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            cafe.name,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(cafe.location),
                        ],
                      ),
                    ],
                  ),
                ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  void _searchCafe(String query) {
    setState(() {
      _filteredCafe = cafeList
          .where((cafe) =>
          cafe.name.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }
  void _navigateToDetailScreen(Cafe cafe) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => DetailScreen(cafe: cafe),
      ),
    );
  }

}
