import 'package:flutter/material.dart';
import 'package:music_player/models/playlist_provder.dart';
import 'package:music_player/pages/home_page.dart';
import 'package:music_player/theme/dark_mode.dart';
import 'package:music_player/theme/light_mode.dart';
import 'package:music_player/theme/theme_provider.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => ThemeProvider(),
      child: const MainApp(),
    ),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
      theme: Provider.of<ThemeProvider>(context).themeData,
    );
  }
}
