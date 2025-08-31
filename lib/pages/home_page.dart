import 'package:flutter/material.dart';
import 'package:music_player/colors/color_extension.dart';
import 'package:music_player/components/my_drawer.dart';
import 'package:music_player/models/playlist_provider.dart';
import 'package:music_player/models/song.dart';
import 'package:music_player/pages/SongPage.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  late final dynamic playlistProvider;
  @override
  void initState(){
    super.initState();
    playlistProvider = Provider.of<PlaylistProvider>(context, listen: false);

  }

  void goToSong(int i){
    playlistProvider.currentSongIndex = i;
    Navigator.push(context, MaterialPageRoute(builder: (context) => SongPage()));
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.surface,

        title: Text(
          "Music Player",
          style: TextStyle(color: Theme.of(context).colorScheme.primary),
        ),
        centerTitle: true,
        iconTheme: IconThemeData(color: Theme.of(context).colorScheme.primary),
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
                  Container(
                      decoration: BoxDecoration(
                        color: darkGray,
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      child: ListTile(
                        title: Text(
                          song.model.title,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                        subtitle: Text(
                          song.model.artist == "<unknown>" ? "Artist" : song.model.artist!,
                        ),
                        leading: song.cover,
                       onTap: () => goToSong(index),
                      ),
                    ),
                  SizedBox(height: 10,)
                ],
              );
            },
          );
        },
      ),
    );
  }
}
