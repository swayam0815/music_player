import 'package:flutter/material.dart';
import 'package:music_player/theme/theme_provider.dart';
import 'package:provider/provider.dart';

class NeuBox extends StatelessWidget {
  final Widget? child;

  const NeuBox({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Theme.of(context).colorScheme.surface,
        boxShadow: Provider.of<ThemeProvider>(context, listen: false).isDarkMode
            ? [
                BoxShadow(
                  color: Colors.grey.shade800,
                  blurRadius: 15,
                  offset: const Offset(4, 4),
                ),
                BoxShadow(
                  color: Colors.grey.shade900,
                  blurRadius: 20,
                  offset: const Offset(-4, -4),
                ),
              ]
            : [
                BoxShadow(
                  color: const Color.fromARGB(255, 211, 211, 211),
                  blurRadius: 15,
                  offset: const Offset(4, 4),
                ),
                BoxShadow(
                  color: Colors.grey.shade200,
                  blurRadius: 20,
                  offset: const Offset(-4, -4),
                ),
              ],
      ),
      child: child,
    );
  }
}
