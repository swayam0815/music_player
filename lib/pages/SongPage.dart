import 'package:flutter/material.dart';
import 'package:music_player/components/neu.dart';
import 'package:music_player/models/playlist_provider.dart';
import 'package:provider/provider.dart';

class songPage extends StatelessWidget {
  const songPage({super.key});
  final double size = 300;

  @override
  Widget build(BuildContext context) {
    return Consumer<PlaylistProvider>(
      builder: (context, value, child) => Scaffold(
        backgroundColor: Theme.of(context).colorScheme.surface,
        body: Column(
          children: [
            Row(
              children: [
                IconButton(onPressed: () {}, icon: Icon(Icons.arrow_back)),
                Text("SONG"),
                IconButton(onPressed: () {}, icon: Icon(Icons.menu)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
