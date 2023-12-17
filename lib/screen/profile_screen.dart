import 'package:flutter/material.dart';
import 'package:cafe_palembang/widget/profile_info_item.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  ProfileScreenState createState() => ProfileScreenState();
}

class ProfileScreenState extends State<ProfileScreen> {
  // TODO: 1. Deklarasikan variabel yang dibutuhkan
  bool isSignedIn = false;
  String fullName = '';
  String userName = '';
  int favoriteCafeCount = 0;
  late Color iconColor;

  // TODO: 5. Implementasi fungsi signIn
  void signIn() {
    // setState(() {
    //   isSignedIn = true;
    //   userName = username;
    //   this.fullName = fullName;
    //   this.favoriteCafeCount = favoriteCafeCount;
    // });
    Navigator.pushNamed(context, '/signin');
  }

  // TODO: 6. Implementasi fungsi signOut
  void signOut() {
    setState(() {
      isSignedIn = false;
      userName = '';
      fullName = '';
      favoriteCafeCount = 0;
    });
    Navigator.pushNamed(context, '/signin');
  }

  void editFullName() {
    showDialog(
      context: context,
      builder: (context) {
        String editedName = fullName;
        return AlertDialog(
          title: const Text('Edit Nama'),
          content: TextField(
            onChanged: (value) {
              editedName = value;
            },
            controller: TextEditingController(text: fullName),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Batal'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Simpan'),
              onPressed: () {
                setState(() {
                  fullName = editedName;
                });
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: 200,
            width: double.infinity,
            color: Colors.brown,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: [
                // TODO: 2. Buat bagian ProfilHeader yang berisi gambar profil
                Align(
                  alignment: Alignment.topCenter,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 200 - 50),
                    child: Stack(
                      alignment: Alignment.bottomRight,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.brown, width: 2),
                            shape: BoxShape.circle,
                          ),
                          child: const CircleAvatar(
                            radius: 50,
                            backgroundImage:
                            AssetImage('image/placeholder_image.png'),
                          ),
                        ),
                        if (isSignedIn)
                          IconButton(
                            onPressed: () {},
                            icon: Icon(
                              Icons.camera_alt,
                              color: Colors.brown[50],
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
                // TODO: 3. Buat bagian profilInfo yang berisi info profil
                const SizedBox(height: 20),
                Divider(color: Colors.brown[100]),
                const SizedBox(height: 4),
                ProfileInfoItem(
                  icon: Icons.lock,
                  label: 'Pengguna',
                  value: userName,
                  iconColor: Colors.amber,
                ),
                const SizedBox(height: 4),
                Divider(color: Colors.brown[100]),
                const SizedBox(height: 4),
                ProfileInfoItem(
                  icon: Icons.person,
                  label: 'Nama',
                  value: fullName,
                  showEditIcon: isSignedIn,
                  onEditPressed: () {
                    debugPrint('Icon edit ditekan ...');
                  },
                  iconColor: Colors.blue,
                ),
                const SizedBox(height: 4),
                Divider(color: Colors.brown[100]),
                const SizedBox(height: 4),
                ProfileInfoItem(
                  icon: Icons.favorite,
                  label: 'Favorit',
                  value: favoriteCafeCount > 0 ? '$favoriteCafeCount' : '',
                  iconColor: Colors.red,
                ),
                const SizedBox(height: 4),
                Divider(color: Colors.brown[100]),
                const SizedBox(height: 20),
                isSignedIn
                    ? TextButton(
                        onPressed: signOut,
                        child: const Text('Sign Out'),
                        )
                    : TextButton(
                        onPressed: signIn,
                        child: const Text('Sign In'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
