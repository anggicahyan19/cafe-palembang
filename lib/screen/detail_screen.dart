import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:cafe_palembang/model/cafe_palembang.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '';
class  DetailScreen extends StatefulWidget {
  final Cafe cafe;
  DetailScreen ({super.key, required this.cafe});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  bool isFavorite = false;
  bool isSignedIn = false;

  @override
  void initState(){
    super.initState();
    _checkSignInStatus();
    _loadFavoriteStatus();
  }

  void _checkSignInStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool signedIn = prefs.getBool('isSignedIn') ?? false;
    setState(() {
      isSignedIn = signedIn;
    });
  }

  void _loadFavoriteStatus() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool favorite = prefs.getBool('favorite_${widget.cafe.name}') ?? false;
    setState(() {
      isFavorite= favorite;
    });
  }

  void _showImageGallery(int initialIndex) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ImageGallery(
          imageUrls: widget.cafe.imageUrls,
          initialIndex: initialIndex,
        ),
      ),
    );
  }
  Future<void> _toggleFavorite() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // memeriksa apakah pengguna sudah sign in
    if (!isSignedIn) {
      // jika belum sign in, arahkan ke halaman sign in
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Navigator.pushReplacementNamed(context, '/signin');
      });
      return;
    }
    List<String> favorite = prefs.getStringList('favorite') ?? [];

    // Check if the cafe is already in favorites
    if (isFavorite) {
      favorite.remove(widget.cafe.name);
    } else {
      favorite.add(widget.cafe.name);
    }

    // Save the updated list of favorites
    prefs.setStringList('favorite', favorite);

    setState(() {
      isFavorite = !isFavorite;
    });

    if(!isFavorite){
      Navigator.of(context).pop(widget.cafe.name);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            //detailheader
            Stack(
              children:[
                //image utama
                Hero(
                  tag: widget.cafe.imageAsset,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal :16),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Image.asset('${widget.cafe.imageAsset}',
                        width: double.infinity,
                        height: 200,
                        fit: BoxFit.cover,),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 32,
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.brown[100]?.withOpacity(0.8),
                      shape: BoxShape.circle,
                    ),
                    child: IconButton(
                        onPressed: (){
                          Navigator.pop(context);
                        },
                        icon: const Icon(
                          Icons.arrow_back,
                        )

                    ),
                  ),

                ),


              ],
            ),
            //detailinfo
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 16,),
                  //info atas
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        widget.cafe.name,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      IconButton(
                        onPressed: (){
                          _toggleFavorite();
                        },
                        icon: Icon(isSignedIn && isFavorite
                            ? Icons.favorite
                            : Icons.favorite_border,
                        color: isSignedIn && isFavorite ? Colors.red : null,),
                      ),
                    ],
                  ),
                  //info tegah
                  SizedBox(height: 16,),
                  Row(children: [
                    Icon(Icons.place, color: Colors.red,),
                    SizedBox(width: 8,),
                    SizedBox(width: 70,
                      child: Text('Lokasi', style: TextStyle(
                          fontWeight: FontWeight.bold),),),
                    Text(': ${widget.cafe.location}',),
                  ],),
                  Row(children: [
                    Icon(Icons.lock_clock, color: Colors.lightGreen,),
                    SizedBox(width: 8,),
                    SizedBox(width: 70,
                      child: Text('Open', style: TextStyle(
                          fontWeight: FontWeight.bold),),),
                    Text(': ${widget.cafe.open}',),
                  ],),
                  Row(children: [
                    Icon(Icons.calendar_month, color: Colors.blue,),
                    SizedBox(width: 8,),
                    SizedBox(width: 70,
                      child: Text('Dibangun', style: TextStyle(
                          fontWeight: FontWeight.bold),),),
                    Text(': ${widget.cafe.built}'),
                  ],),
                  SizedBox(height: 16,),
                  Divider(color: Colors.brown.shade100,),
                  SizedBox(height: 16,),
                  //info bawah
                  SizedBox(height: 16,),
                  Row(
                    children: [
                      Text(
                        'Deskripsi', style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                      ),
                    ],
                  ),
                  SizedBox(height: 16,),
                  Container(
                    height: 100,
                    child: Text('${widget.cafe.description}'
                     ),
                  ),
                ],
              ),
            ),
            //detail gallery
            Padding(
              padding: const EdgeInsets.all(15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Divider(color: Colors.brown.shade100,),
                  Text('Galeri', style: TextStyle(
                    fontSize: 16, fontWeight: FontWeight.bold,
                  ),),
                  SizedBox(height: 10,),
                  SizedBox(
                    height: 100,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: widget.cafe.imageUrls.length,
                      itemBuilder: (context, index){
                        return Padding
                          (padding: EdgeInsets.only(right: 8),
                          child: GestureDetector(
                            onTap: () {
                              _showImageGallery(index);
                            },
                            child: Container(
                              decoration: BoxDecoration(),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: CachedNetworkImage(
                                  imageUrl: widget.cafe.imageUrls[index],
                                  width: 120,
                                  height: 120,
                                  fit: BoxFit.cover,
                                  placeholder: (context, url) => Container(
                                    width: 120,
                                    height: 120,
                                    color: Colors.brown[50],
                                  ),
                                  errorWidget: (context, url, error) => Icon(Icons.error),
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  SizedBox(height: 4,),
                  Text('Tap untuk memperbesar', style: TextStyle(
                    fontSize: 12, color: Colors.black54,
                  ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
class ImageGallery extends StatelessWidget {
  final List<String> imageUrls;
  final int initialIndex;

  const ImageGallery({
    Key? key,
    required this.imageUrls,
    required this.initialIndex,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PhotoViewGallery.builder(
        itemCount: imageUrls.length,
        builder: (context, index) {
          return PhotoViewGalleryPageOptions(
            imageProvider: CachedNetworkImageProvider(imageUrls[index]),
            minScale: PhotoViewComputedScale.contained,
            maxScale: PhotoViewComputedScale.covered * 2,
          );
        },
        scrollPhysics: BouncingScrollPhysics(),
        backgroundDecoration: BoxDecoration(
          color: Colors.black,
        ),
        pageController: PageController(initialPage: initialIndex),
      ),
    );
  }
}