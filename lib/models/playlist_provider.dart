import 'package:flutter/material.dart';
import 'package:music_player/models/song.dart';
import 'package:on_audio_query/on_audio_query.dart';

class PlaylistProvider extends ChangeNotifier {
  int _currentSongIndex = 0;
  final OnAudioQuery _audioQuery = OnAudioQuery();
  // ignore: prefer_final_fields
  List<Song> _songs = [];

  Future<void> fetchSongs() async {
     {
      bool permissionStatus = await _audioQuery.permissionsStatus();
      if (!permissionStatus) {
        permissionStatus = await _audioQuery.permissionsRequest();
      }

      if (!permissionStatus) {
        return;
      }

      List<SongModel> songsFetched = await _audioQuery.querySongs();
      _songs.clear();
      for (SongModel s in songsFetched) {
        _songs.add(
          Song(
            model: s,
            cover: QueryArtworkWidget(
              controller: _audioQuery,
              id: s.id,
              type: ArtworkType.AUDIO,
              artworkBorder: BorderRadius.all(Radius.zero),
            ),
          ),
        );
      }

      notifyListeners();
    } 
  }

  void initState() {
    fetchSongs();
  }

  PlaylistProvider() {
    initState();
  }

  // G E T T E R S
  int get currentSongIndex => _currentSongIndex;
  List<Song> get songs => _songs;

  Song get currSong => _songs[currentSongIndex];

  // setters
  set currentSongIndex(int newIndex) {
    _currentSongIndex = newIndex;
    notifyListeners();
  }
}
