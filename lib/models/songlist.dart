// Example usage in a widget
import 'package:flutter/material.dart';
import 'package:music_player/colors/color_extension.dart';
import 'package:music_player/models/playlist_provider.dart';
import 'package:music_player/models/song.dart';
import 'package:music_player/pages/SongPage.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:provider/provider.dart';

class SongListPage extends StatefulWidget {
  @override
  // ignore: library_private_types_in_public_api
  _SongListPageState createState() => _SongListPageState();
}

class _SongListPageState extends State<SongListPage> {
  final OnAudioQuery _audioQuery = OnAudioQuery();
  List<SongModel> _songs = [];
  bool _loading = true;
  String? _error;
  late final dynamic playlistProvider;


  @override
  void initState() {
    super.initState();
    fetchSongs();
    playlistProvider = Provider.of<PlaylistProvider>(context, listen: false);
  }

  void goToSong(int songIndex){
    playlistProvider.currentSongIndex = songIndex;
    Navigator.push(context, MaterialPageRoute(builder: (context) => SongPage(),));
  }


  Future<void> fetchSongs() async {
    try {
      bool permissionStatus = await _audioQuery.permissionsStatus();
      if (!permissionStatus) {
        permissionStatus = await _audioQuery.permissionsRequest();
      }

      if (!permissionStatus) {
        setState(() {
          _error = "Permission denied. Cannot access songs.";
          _loading = false;
        });
        return;
      }

      List<SongModel> songs = await _audioQuery.querySongs();
      setState(() {
        _songs = songs;
        _loading = false;
      });
    } catch (e) {
      setState(() {
        _error = "Error fetching songs: $e";
        _loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _loading
          ? Center(child: CircularProgressIndicator())
          : _error != null
          ? Center(child: Text(_error!))
          : _songs.isEmpty
          ? Center(child: Text("No songs found on device."))
          : ListView.builder(
              itemCount: _songs.length,

              itemBuilder: (context, index) {
                final SongModel song = _songs[index];

                return Container(
                  decoration: BoxDecoration(
                    color: darkGray,
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  child: ListTile(
                    title: Text(
                      song.title,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                    subtitle: Text(
                      song.artist == "<unknown>" ? "Artist" : song.artist!,
                    ),
                    leading: QueryArtworkWidget(
                      controller: _audioQuery,
                      id: _songs[index].id,
                      type: ArtworkType.AUDIO,
                      artworkBorder: BorderRadius.all(Radius.zero),
                    ),
                    onTap: () => goToSong(index),
                  ),
                );
              },
            ),
    );
  }

  List<SongModel> get songs => _songs;
}
