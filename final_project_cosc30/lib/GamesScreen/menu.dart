import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'about.dart';
import 'settings.dart';
import 'devprofiles.dart';
import 'package:finalproject/login.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MenuContent extends StatefulWidget {
  @override
  _MenuContentState createState() => _MenuContentState();
}

class _MenuContentState extends State<MenuContent> {
  Uint8List? _imageBytes;

  List<String> backgroundImages = [
    'images/user/bg2.jpg',
    'images/user/bg3.jpg',
    'images/user/cover6.jpg',
    'images/user/bg4.jpg',
    'images/user/bg1.jpg',
  ];

  int currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _loadImageFromPreferences();
    _loadBackgroundImageIndex(); // Load the previously selected background image index
  }

  Future<void> _loadImageFromPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<int>? imageBytes =
        prefs.getStringList('user_image')?.map(int.parse)?.toList();

    if (imageBytes != null) {
      setState(() {
        _imageBytes = Uint8List.fromList(imageBytes);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      elevation: 0,
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          Container(
            height: 200,
            child: DrawerHeader(
              decoration: BoxDecoration(
                color: const Color(0xff4e208b),
                image: currentIndex >= 0 &&
                        currentIndex < backgroundImages.length &&
                        backgroundImages[currentIndex] != null
                    ? DecorationImage(
                        image: AssetImage(
                          backgroundImages[currentIndex],
                        ),
                        fit: BoxFit.fill,
                      )
                    : null,
              ),
              child: Padding(
                padding: const EdgeInsets.only(top: 30.0), // Add top space here
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    FutureBuilder<User?>(
                      future: Future.value(FirebaseAuth.instance.currentUser),
                      builder: (context, snapshot) {
                        User? user = snapshot.data;

                        if (snapshot.connectionState == ConnectionState.done) {
                          if (user != null) {
                            return Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    _selectImage();
                                  },
                                  child: Stack(
                                    alignment: Alignment.bottomRight,
                                    children: [
                                      CircleAvatar(
                                        radius: 40,
                                        backgroundImage: _imageBytes != null
                                            ? MemoryImage(_imageBytes!)
                                            : AssetImage(
                                                    'images/user/default.png')
                                                as ImageProvider<Object>,
                                      ),
                                      Positioned(
                                        right: 0,
                                        bottom: 0,
                                        child: Container(
                                          child: IconButton(
                                            icon: Icon(
                                              Icons.edit,
                                              color: Color(0xffff13b1),
                                            ),
                                            onPressed: () {
                                              _selectImage();
                                            },
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                    width:
                                        15), // Adjust spacing between avatar and text
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          SizedBox(height: 20),
                                          Container(
                                            width: 200,
                                            color: Color(
                                                0x460c0101), // Set the background color here
                                            child: Text(
                                              '${user.displayName}',
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 30,
                                                fontFamily: 'Salsa',
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                          Container(
                                            child: Text(
                                              user.email!,
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 14,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            );
                          }
                        }
                        return Container();
                      },
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          icon: Icon(
                            Icons.arrow_back_ios,
                            color: Colors.white,
                          ),
                          onPressed: () {
                            _navigateBackgroundImage(-1);
                          },
                        ),
                        IconButton(
                          icon: Icon(
                            Icons.arrow_forward_ios,
                            color: Colors.white,
                          ),
                          onPressed: () {
                            _navigateBackgroundImage(1);
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          ListTile(
            title: Text('Developers'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => DevProfiles()),
              );
            },
          ),
          ListTile(
            title: Text('Settings'),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SettingsPage(),
                ),
              );
            },
          ),
          ListTile(
            title: Text('About'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AboutPage()),
              );
            },
          ),
          ListTile(
            title: Text('Log out'),
            onTap: () {
              _showLogoutConfirmationDialog(context);
            },
          ),
          ListTile(
            title: Text('Exit'),
            onTap: () {
              _showExitConfirmationDialog(context);
            },
          ),
        ],
      ),
    );
  }

  void _navigateBackgroundImage(int direction) {
    setState(() {
      currentIndex = (currentIndex + direction) % backgroundImages.length;
      if (currentIndex < 0) {
        currentIndex = backgroundImages.length - 1;
      }

      _saveBackgroundImageIndex(currentIndex);
    });
  }

  Future<void> _saveBackgroundImageIndex(int index) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt('background_image_index', index);
  }

  Future<void> _loadBackgroundImageIndex() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int? index = prefs.getInt('background_image_index');

    if (index != null) {
      setState(() {
        currentIndex = index;
      });
    }
  }

  Future<void> _selectImage() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      List<int> imageBytes = await image.readAsBytes();
      setState(() {
        _imageBytes = Uint8List.fromList(imageBytes);
      });

      await _saveImageToFirebaseStorage(Uint8List.fromList(imageBytes));
      await _saveImageToSharedPreferences(Uint8List.fromList(imageBytes));
    }
  }

  Future<void> _saveImageToSharedPreferences(Uint8List imageBytes) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setStringList(
        'user_image', imageBytes.map((int byte) => byte.toString()).toList());
  }

  Future<void> _saveImageToFirebaseStorage(Uint8List imageBytes) async {
    try {
      String fileName = 'image_${DateTime.now().millisecondsSinceEpoch}.jpg';

      var storageRef =
          firebase_storage.FirebaseStorage.instance.ref('images/$fileName');

      await storageRef.putData(imageBytes);

      String downloadUrl = await storageRef.getDownloadURL();

      print('Download URL: $downloadUrl');

      // You may still want to log or handle the download URL

      // There's no user-specific logic here, so no need to update Firestore

      // If you want to update Firestore, add your logic here
    } catch (e) {
      print('Error saving image to Firebase Storage: $e');
      // Handle error as needed (e.g., show a snackbar or an alert)
    }
  }

  void _showExitConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Exit "),
          content: Text(
            "Are you sure you want to exit?",
            style: TextStyle(),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("Cancel"),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.of(context).pop();
                SystemNavigator.pop();
              },
              child: Text("Exit"),
            ),
          ],
        );
      },
    );
  }

  void _showLogoutConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Log Out"),
          content: Text("Are you sure you want to log out?"),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text("Cancel"),
            ),
            TextButton(
              onPressed: () async {
                // Close the dialog
                Navigator.of(context).pop();

                // Perform logout logic here (e.g., sign out the user)
                await FirebaseAuth.instance.signOut();

                // Navigate to the login page
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => LoginPage()),
                  (Route<dynamic> route) => false,
                );
              },
              child: Text("Log Out"),
            ),
          ],
        );
      },
    );
  }
}
