import 'package:cafe_palembang/data/cafe_palembang_data.dart';
import 'package:cafe_palembang/screen/home_screen.dart';
import 'package:cafe_palembang/screen/profile_screen.dart';
import 'package:cafe_palembang/screen/sign_in_screen.dart';
import 'package:cafe_palembang/screen/sign_up_screen.dart';
import 'package:cafe_palembang/screen/detail_screen.dart';
import 'package:cafe_palembang/screen/search_screen.dart';
import 'package:cafe_palembang/screen/favorite_screen.dart';
import 'package:encrypt/encrypt.dart' as encrypt;
import 'package:logger/logger.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Cafe Palembang',
      theme: ThemeData(
        appBarTheme: const AppBarTheme(
          iconTheme: IconThemeData(color: Colors.brown),
          titleTextStyle: TextStyle(
            color: Colors.brown,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.brown).copyWith(
          primary: Colors.brown,
          surface: Colors.brown[50],
        ),
        useMaterial3: true,
      ),
      home: MainScreen(),
      initialRoute: '/',
      routes: {
        '/homescreen': (context) => const HomeScreen(),
        '/signin': (context) => const SignInScreen(),
        '/signup': (context) =>  SignUpScreen(),
        '/favorite' :(context) => FavoriteScreen(),
      },
    );
  }
}

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  // TODO : 1. Deklerasikan variabel
  int _currentIndex = 0;
  final List<Widget> _children = [
    const HomeScreen(),
    const SearchScreen(),
    FavoriteScreen(),
    const ProfileScreen(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // TODO : 2. Buat Properti body berupa widget yang ditampilkan
      body: _children[_currentIndex],
      // TODO : 3. Buat properti bottomNavigationBar dengan nilai theme
      bottomNavigationBar: Theme(
        data: Theme.of(context).copyWith(
            canvasColor: Colors.brown[50]
        ),
        child: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (index){
            setState(() {
              _currentIndex = index;
            });
          },
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home, color: Colors.brown,),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.search, color: Colors.brown,),
              label: 'Search',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.favorite, color: Colors.brown,),
              label: 'Favorite',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person, color: Colors.brown,),
              label: 'Profile',
            ),
          ],
          selectedItemColor: Colors.brown,
          unselectedItemColor: Colors.brown[100],
          showUnselectedLabels: true,
        ),
      ),
      // TODO : 4. Buat data dan child dari theme
    );

  }
}
