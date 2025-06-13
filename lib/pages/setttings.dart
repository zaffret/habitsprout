import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:habit_sprout1/services/theme_notifier.dart';
import 'package:habit_sprout1/services/firebase_service.dart';

class SettingsPage extends StatelessWidget {
  static const routeName = '/settings';

  final FirebaseService _firebaseService = FirebaseService();

  SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final themeNotifier = Provider.of<ThemeNotifier>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Theme',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SwitchListTile(
              title: const Text('Dark Mode'),
              value: themeNotifier.isDarkMode,
              onChanged: (value) {
                themeNotifier.toggleTheme();
              },
            ),
            ListTile(
              title: const Text('Logout'),
              leading: const Icon(Icons.logout),
              onTap: () async {
                try {
                  await _firebaseService.logOut();
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Successfully logged out.'),
                    ),
                  );
                  Navigator.of(context).pushReplacementNamed(
                      '/login'); // Replace '/login' with your login route
                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Error logging out: $e'),
                    ),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
