import 'package:chota_youtube/helper_functions.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Page'),
      ),
      drawer: Drawer(
        child: Container(
          color: Colors.deepPurpleAccent, // Custom drawer background color
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              DrawerHeader(
                decoration: BoxDecoration(
                  color: Colors.deepPurpleAccent, // Header background color
                ),
                child: Center(
                  child: Text(
                    'Menu',
                    style: TextStyle(
                      color: Colors.white, // Header text color
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              ListTile(
                title: const Text(
                  'Upload Videos',
                  style: TextStyle(color: Colors.white),
                ),
                leading: Icon(Icons.video_call,
                    color: Colors.white), // Upload Videos icon
                onTap: () {
                  Navigator.pop(context); // Close the drawer
                  Navigator.pushNamed(context, '/uploadVideos');
                },
              ),
              ListTile(
                title: const Text(
                  'Settings',
                  style: TextStyle(color: Colors.white),
                ),
                leading:
                    Icon(Icons.settings, color: Colors.white), // Settings icon
                onTap: () {
                  Navigator.pop(context); // Close the drawer
                  Navigator.pushNamed(context, '/settings');
                },
              ),
              ListTile(
                title: const Text(
                  'Log Out',
                  style: TextStyle(color: Colors.white),
                ),
                leading:
                    Icon(Icons.logout, color: Colors.white), // Log Out icon
                onTap: () {
                  HelperFunctions.clearLoggedIn();
                  Navigator.pop(context); // Close the drawer
                  Navigator.pushNamed(context, '/login');
                },
              ),
            ],
          ),
        ),
      ),
      body: const Center(
        child: Text('Welcome to the Home Page!'),
      ),
    );
  }
}
