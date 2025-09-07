import 'package:flutter/material.dart';
import 'package:music_player/theme/theme_provider.dart';
import 'package:provider/provider.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.surface,
        title: Text(
          "Settings",
          style: TextStyle(color: Theme.of(context).colorScheme.inversePrimary),
        ),
        centerTitle: true,
        iconTheme: IconThemeData(color: Theme.of(context).colorScheme.inversePrimary),
      ),

      body: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.secondary,
          borderRadius: BorderRadius.circular(15),
        ),
        padding: const EdgeInsets.all(15),
        margin: const EdgeInsets.all(15),

        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Dark Mode",
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.inversePrimary,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Switch(
                  value: Provider.of<ThemeProvider>(
                    context,
                    listen: false,
                  ).isDarkMode,
                  onChanged: (value) => Provider.of<ThemeProvider>(
                    context,
                    listen: false,
                  ).toggleTheme(),
                  activeThumbColor: Theme.of(context).colorScheme.inversePrimary,
                  inactiveThumbColor: Theme.of(context).colorScheme.inversePrimary,
                  trackOutlineColor: WidgetStateProperty.all(
                    Theme.of(context).colorScheme.secondary,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
