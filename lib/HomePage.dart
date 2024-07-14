import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'AboutUs.dart';
import 'Services.dart';
import 'Contacts.dart';
import 'main.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin {
  ThemeData _lightTheme = ThemeData.light();
  ThemeData _darkTheme = ThemeData.dark().copyWith(primaryColor: Colors.black);
  ThemeData _currentTheme = ThemeData.light();
  late SharedPreferences _prefs;
  late TabController _tabController;
  File? _profileImage; // Variable to hold the profile image file
  bool _isDarkMode = false; // Track current theme mode

  @override
  void initState() {
    super.initState();
    _loadTheme();
    _tabController = TabController(length: 3, vsync: this);
  }

  _loadTheme() async {
    _prefs = await SharedPreferences.getInstance();
    setState(() {
      _isDarkMode = _prefs.getBool('isDark') ?? false;
      _currentTheme = _isDarkMode ? _darkTheme : _lightTheme;
    });
  }

  _switchTheme(bool isDark) async {
    setState(() {
      _isDarkMode = isDark;
      _currentTheme = _isDarkMode ? _darkTheme : _lightTheme;
      _prefs.setBool('isDark', _isDarkMode);
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.title), // Localized app title
        bottom: TabBar(
          controller: _tabController,
          tabs: [
            Tab(icon: Icon(Icons.logout), text: AppLocalizations.of(context)!.aboutUs),
            // Localized aboutUs
            Tab(icon: Icon(Icons.app_registration), text: AppLocalizations.of(context)!.services),
            // Localized services
            Tab(icon: Icon(Icons.calculate), text: AppLocalizations.of(context)!.contacts),
            // Localized contacts
          ],
        ),
        actions: [
          IconButton(
            icon: Icon(_isDarkMode ? Icons.lightbulb_outline : Icons.lightbulb),
            // Use lightbulb outline for dark mode and lightbulb for light mode
            onPressed: () {
              _switchTheme(!_isDarkMode); // Toggle theme
            },
          ),
          IconButton(
            icon: Icon(Icons.language),
            onPressed: () {
              _showLanguageDialog(context); // Show language selection dialog
            },
          ),
        ],
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          AboutUs(),
          Services(),
          ContactsPage(),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.black,
              ),
              child: Stack(
                children: [
                  Positioned.fill(
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: CircleAvatar(
                        radius: 40,
                        backgroundColor: Colors.white,
                        backgroundImage: _profileImage != null ? FileImage(_profileImage!) : null,
                        child: _profileImage == null ? Icon(Icons.person, size: 40, color: Colors.grey) : null,
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 12.0,
                    left: 12.0,
                    right: 12.0,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          AppLocalizations.of(context)!.profilePicture,
                          // Localized profilePicture
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 8),
                        TextButton.icon(
                          onPressed: () {
                            _selectFromGallery();
                          },
                          icon: Icon(Icons.photo_library, color: Colors.white),
                          label: Text(
                            AppLocalizations.of(context)!.selectFromGallery,
                            // Localized selectFromGallery
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                            ),
                          ),
                        ),
                        SizedBox(height: 8),
                        TextButton.icon(
                          onPressed: () {
                            _takePicture();
                          },
                          icon: Icon(Icons.camera_alt, color: Colors.white),
                          label: Text(
                            AppLocalizations.of(context)!.takeAPicture,
                            // Localized takeAPicture
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            Divider(),
            // Other Drawer items
            ListTile(
              leading: Icon(Icons.logout),
              title: Text(AppLocalizations.of(context)!.aboutUs),
              // Localized aboutUs
              onTap: () {
                _tabController.animateTo(0);
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.app_registration),
              title: Text(AppLocalizations.of(context)!.services),
              // Localized services
              onTap: () {
                _tabController.animateTo(1);
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.calculate),
              title: Text(AppLocalizations.of(context)!.contacts),
              // Localized contacts
              onTap: () {
                _tabController.animateTo(2);
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }

  // Method to handle selecting image from gallery
  Future<void> _selectFromGallery() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _profileImage = File(pickedFile.path);
      });
      print('Image selected from gallery: ${pickedFile.path}');
    } else {
      print('No image selected.');
    }
  }

  // Method to handle taking a new picture
  Future<void> _takePicture() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.camera);

    if (pickedFile != null) {
      setState(() {
        _profileImage = File(pickedFile.path);
      });
      print('Picture taken: ${pickedFile.path}');
    } else {
      print('No picture taken.');
    }
  }

  // Method to show language selection dialog
  void _showLanguageDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(AppLocalizations.of(context)!.changeLanguage),
          // Localized title
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ListTile(
                title: Text(AppLocalizations.of(context)!.english),
                // Localized English
                onTap: () {
                  MyApp.setLocale(context, const Locale('en'));
                  Navigator.of(context).pop();
                },
              ),
              ListTile(
                title: Text(AppLocalizations.of(context)!.french),
                // Localized French
                onTap: () {
                  MyApp.setLocale(context, const Locale('fr'));
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
