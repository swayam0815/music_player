import 'package:flutter/material.dart';
import 'package:music_player/components/my_drawer.dart';
import 'package:music_player/models/playlist_provider.dart';
import 'package:music_player/models/song.dart';
import 'package:music_player/pages/songPage.dart';
import 'package:music_player/theme/theme_provider.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final dynamic playlistProvider;
  @override
  void initState() {
    super.initState();
    playlistProvider = Provider.of<PlaylistProvider>(context, listen: false);
  }

  void goToSong(int i) {
    playlistProvider.currentSongIndex = i;
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => songPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.surface,

        title: Text(
          "Music Player",
          style: TextStyle(color: Theme.of(context).colorScheme.inversePrimary),
        ),
        centerTitle: true,
        iconTheme: IconThemeData(
          color: Theme.of(context).colorScheme.inversePrimary,
        ),
      ),
      drawer: MyDrawer(),
      body: Consumer<PlaylistProvider>(
        builder: (context, value, child) {
          final List<Song> playlist = value.songs;
          return ListView.builder(
            itemCount: playlist.length,
            itemBuilder: (context, index) {
              final Song song = playlist[index];

              return Column(
                children: [
                  SizedBox(height: 10),
                  Column(
                    children: [
                      SizedBox(height: 10),
                      Container(
                        margin: EdgeInsets.only(
                          top: 10,
                          bottom: 15,
                          left: 20,
                          right: 20,
                        ),
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.secondary,
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          boxShadow:
                              Provider.of<ThemeProvider>(
                                context,
                                listen: false,
                              ).isDarkMode
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
                                    color: Colors.grey.shade500,
                                    blurRadius: 15,
                                    offset: const Offset(4, 4),
                                  ),
                                  BoxShadow(
                                    color: Colors.grey.shade400,
                                    blurRadius: 20,
                                    offset: const Offset(-4, -4),
                                  ),
                                ],
                        ),
                        child: ListTile(
                          title: Text(
                            song.model.title,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            style: TextStyle(
                              color: Theme.of(
                                context,
                              ).colorScheme.inversePrimary,
                            ),
                          ),
                          subtitle: Text(
                            song.model.artist == "<unknown>"
                                ? "Artist"
                                : song.model.artist!,
                            style: TextStyle(
                              color: Theme.of(
                                context,
                              ).colorScheme.inversePrimary,
                            ),
                          ),
                          leading: song.cover,
                          onTap: () => goToSong(index),
                        ),
                      ),
                    ],
                  ),
                ],
              );
            },
          );
        },
      ),
    );
  }
}
