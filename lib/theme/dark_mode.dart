import 'package:flutter/material.dart';
import 'package:music_player/colors/color_extension.dart';

ThemeData darkMode = ThemeData(
  colorScheme: ColorScheme.dark(
    surface: bg,
    primary: focusStart,
    secondary: focusStart,
    inversePrimary: Colors.white,
  ),
);
