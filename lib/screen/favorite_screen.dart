import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../data/cafe_palembang_data.dart';
import '../model/cafe_palembang.dart';
import 'detail_screen.dart';

class FavoriteScreen extends StatefulWidget {
  @override
  _FavoriteScreenState createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  List<String> favorite = [];

  GlobalKey<AnimatedListState> listKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    _loadFavoriteStatus();
  }

  Future<void> _loadFavoriteStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> _loadFavoriteStatus = prefs.getStringList('favorite') ?? [];
    setState(() {
      favorite = _loadFavoriteStatus;
    });
  }

  void _navigateToDetailScreen(String cafeName) {
    // Find the corresponding Cafe object based on the cafeName
    Cafe cafe = cafeList.firstWhere((cafe) => cafe.name == cafeName);

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => DetailScreen(cafe: cafe),
      ),
    );
  }

  void removeCafeFromList(String cafeName) {
    int index = favorite.indexOf(cafeName);
    if (index != -1) {
      setState(() {
        favorite.removeAt(index);
        listKey.currentState?.removeItem(
          index,
              (context, animation) => buildItem(context, index, animation),
        );
      });
    }
  }

  Widget buildItem(BuildContext context, int index, Animation<double> animation) {
    return SizeTransition(
      sizeFactor: animation,
      child: ListTile(
        title: Text(favorite[index]),
        // Other ListTile properties
      ),
    );
  }

  Widget _buildCafeCard(String cafeName) {
    // Find the corresponding Cafe object based on the cafeName
    Cafe cafe = cafeList.firstWhere((cafe) => cafe.name == cafeName);

    return Card(
      margin: EdgeInsets.all(8),
      child: ListTile(
        contentPadding: EdgeInsets.all(8),
        title: Text(cafe.name),
        subtitle: Text(cafe.location),
        onTap: () {
          // Navigate to DetailScreen when tapped
          _navigateToDetailScreen(cafeName);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Favorites'),
      ),
      body: ListView.builder(
        itemCount: favorite.length,
        itemBuilder: (context, index) {
          return _buildCafeCard(favorite[index]);
        },
      ),
    );
  }
}
