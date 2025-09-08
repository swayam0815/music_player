import 'package:flutter/material.dart';
import 'package:music_player/components/neu.dart';
import 'package:music_player/models/playlist_provider.dart';
import 'package:provider/provider.dart';

class songPage extends StatelessWidget {
  const songPage({super.key});
  final double size = 300;

  String timeFormat(Duration duration){
    String digits = (duration.inSeconds.remainder(60)).toString().padLeft(2, '0');
    return "${duration.inMinutes}:$digits";
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<PlaylistProvider>(
      builder: (context, value, child) {
        final currSong = value.currSong;
        return Scaffold(
          backgroundColor: Theme.of(context).colorScheme.surface,
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.only(left: 15, right: 15, bottom: 15),
              child: Column(
                //mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: Icon(Icons.arrow_back),
                      ),
                      Text("SONG", style: TextStyle(fontSize: 20)),
                      IconButton(onPressed: () {}, icon: Icon(Icons.menu)),
                    ],
                  ),
                  SizedBox(height: 20),

                  NeuBox(
                    child: Column(
                      children: [
                        SizedBox(
                          width: size,
                          height: size,
                          child: ClipRRect(
                            borderRadius: BorderRadiusGeometry.circular(10),
                            child: currSong.cover,
                          ),
                        ),

                        Padding(
                          padding: const EdgeInsets.only(
                            top: 10,
                            left: 15,
                            right: 15,
                            bottom: 10,
                          ),
                          child: SizedBox(
                            width: size,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        currSong.model.title.toString().trim(),
                                        style: TextStyle(
                                          fontSize: 18.0,
                                          fontWeight: FontWeight.bold,
                                          overflow: TextOverflow.ellipsis,
                                          color: Theme.of(
                                            context,
                                          ).colorScheme.inversePrimary,
                                        ),
                                        maxLines: 1,
                                      ),
                                      Text(
                                        currSong.model.artist.toString().trim(),
                                        style: TextStyle(
                                          fontSize: 15.0,
                                          fontWeight: FontWeight.w500,
                                          overflow: TextOverflow.ellipsis,
                                          color: Theme.of(
                                            context,
                                          ).colorScheme.inversePrimary,
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
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  Column(
                    children: [
                      SliderTheme(
                        data: SliderTheme.of(context).copyWith(
                          inactiveTrackColor: Theme.of(
                            context,
                          ).colorScheme.secondary,
                          activeTrackColor: Theme.of(context).colorScheme.primary,
                          thumbColor: Theme.of(context).colorScheme.secondary,
                          overlayColor: Theme.of(
                            context,
                          ).colorScheme.primary.withAlpha(32),
                          overlayShape: const RoundSliderOverlayShape(
                            overlayRadius: 10.0,
                          ),
                          thumbShape: RoundSliderThumbShape(
                            enabledThumbRadius: 0,
                          ),
                        ),
                        child: Slider(
                          min: 0.0,
                          max: value.totDur.inSeconds.toDouble(),
                          value: value.currDur.inSeconds.toDouble(),
                          onChanged: (double double) {},
                          onChangeEnd: (double double) {
                            value.seek(Duration(seconds: double.toInt()));
                          },
                        ),
                      ),
                      NeuBox(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(timeFormat(value.currDur)),
                              Icon(Icons.shuffle_outlined),
                              Icon(Icons.repeat_outlined),
                              Text(timeFormat(value.totDur)),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 25),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: GestureDetector(
                              onTap: value.playPreviousSong,
                              child: NeuBox(child: Icon(Icons.skip_previous)),
                            ),
                          ),
                          const SizedBox(width: 20),
                          Expanded(
                            flex: 2,
                            child: GestureDetector(
                              onTap: value.togglePlay,
                              child: NeuBox(child: Icon(value.isPlaying ? Icons.pause : Icons.play_arrow)),
                            ),
                          ),
                          const SizedBox(width: 20),
                          Expanded(
                            child: GestureDetector(
                              onTap: value.playNextSong,
                              child: NeuBox(child: Icon(Icons.skip_next)),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
