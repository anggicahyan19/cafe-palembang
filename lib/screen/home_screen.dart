import 'package:cafe_palembang/model/cafe_palembang.dart';
import 'package:flutter/material.dart';
import 'package:cafe_palembang/data/cafe_palembang_data.dart';
import 'package:cafe_palembang/widget/item_card.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // TODO : 1. Buat appBar dengan judul wisata candi
      appBar: AppBar(title: Text('Cafe Palembang'),),
      // TODO : 2. Body dengan gridview.builder
      body: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2
          ),
          padding: EdgeInsets.all(8.0),
          itemCount: cafeList.length,
          itemBuilder: (context, index){
            Cafe cafe = cafeList[index];
            return ItemCard(cafe: cafe);
          }),
      // TODO : 3. Buat Itemcard sebagai return dari gridview.builder
    );
  }
}
