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
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(
              left: 10.0,
              right: 10.0,
              bottom: 25.0,
              top: 10.0,
            ),
            child: Column(
              children: [
                // app bar
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,

                  children: [
                    IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: Icon(Icons.arrow_back_ios_new_outlined),
                    ),
                    Text("PLAYLIST", style: TextStyle(fontSize: 20.0)),
                    IconButton(onPressed: () {}, icon: Icon(Icons.menu)),
                  ],
                ),

                // song cover
                NeuBox(
                  child: Column(
                    children: [
                      SizedBox(
                        width: size,
                        height: size,
                        child: ClipRRect(
                          borderRadius: BorderRadiusGeometry.circular(10),
                          child: Provider.of<PlaylistProvider>(
                            context,
                          ).currSong.cover,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 15.0,
                          right: 15.0,
                          top: 10,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    Provider.of<PlaylistProvider>(
                                      context,
                                    ).currSong.model.title.toString().trim(),
                                    style: TextStyle(
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.bold,
                                      overflow: TextOverflow.ellipsis,
                                      color: Theme.of(
                                        context,
                                      ).colorScheme.primary,
                                    ),
                                    maxLines: 1,
                                  ),
                                  Text(
                                    Provider.of<PlaylistProvider>(
                                      context,
                                    ).currSong.model.artist.toString().trim(),
                                    style: TextStyle(
                                      fontSize: 15.0,
                                      fontWeight: FontWeight.w500,
                                      overflow: TextOverflow.ellipsis,

                                      color: Theme.of(
                                        context,
                                      ).colorScheme.primary,
                                    ),
                                    maxLines: 1,
                                    textAlign: TextAlign.start,
                                  ),
                                ],
                              ),
                            ),
                            Icon(Icons.favorite, color: Colors.red),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 35.0),
                  child: Column(
                    children: [
                      SliderTheme(
                        data: SliderTheme.of(context).copyWith(
                          inactiveTrackColor: Theme.of(
                            context,
                          ).colorScheme.secondary,
                          activeTrackColor: Theme.of(
                            context,
                          ).colorScheme.primary,
                          thumbColor: Theme.of(context).colorScheme.secondary,
                          overlayColor: Theme.of(
                            context,
                          ).colorScheme.primary.withAlpha(32),
                          overlayShape: const RoundSliderOverlayShape(
                            overlayRadius: 10.0,
                            
                          ),
                          thumbShape: RoundSliderThumbShape(enabledThumbRadius: 0)
                        ),
                        child: Slider(
                          min: 0.0,
                          max: 100.0,
                          value: 50.0,
                          onChanged: (value) {},
                        ),
                      ),
                      const SizedBox(height: 10),

                      const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("0:00"),
                          Icon(Icons.shuffle),
                          Icon(Icons.repeat_outlined),
                          Text("0:00"),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
