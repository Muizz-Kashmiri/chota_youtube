import 'package:chota_youtube/helper_functions.dart';
import 'package:chota_youtube/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Consumer<ThemeProvider>(
          builder: (context, themeProvider, _) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ListTile(
                  title: const Text(
                    'Dark Mode',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  trailing: Switch(
                    value: themeProvider.isDarkModeEnabled,
                    onChanged: (value) {
                      themeProvider.toggleDarkMode(value);
                      HelperFunctions.setIsDarkMode(value);
                    },
                  ),
                ),
                const Divider(
                  color: Colors.grey,
                ),
                const SizedBox(height: 20),
                ListTile(
                  title: const Text(
                    'Other Settings',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  onTap: () {
                    // Navigate to other settings page
                  },
                  trailing: const Icon(Icons.arrow_forward_ios),
                ),
                // Add other settings here
              ],
            );
          },
        ),
      ),
    );
  }
}
