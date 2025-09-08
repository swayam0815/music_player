import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:music_player/models/song.dart';
import 'package:on_audio_query/on_audio_query.dart';

class PlaylistProvider extends ChangeNotifier {
  int _currentSongIndex = 0;
  final OnAudioQuery _audioQuery = OnAudioQuery();
  // ignore: prefer_final_fields
  List<Song> _songs = [];

  AudioPlayer _audioPlayer = AudioPlayer();

  Duration _currentDuration = Duration.zero;
  Duration _totalDuration = Duration.zero;
  bool _playing = false;

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
        _songs.add(Song(model: s, cover: Icon(Icons.music_note)));
      }

      notifyListeners();
    }
  }

  void initState() {
    fetchSongs();
  }

  void play() async {
    if (_songs.isNotEmpty) {
      final String? path = _songs[currentSongIndex].model.uri;
      if (path == null || path.isEmpty) {
        return;
      }
      await _audioPlayer.stop();
      await _audioPlayer.setUrl(path);
      _playing = true;
      await _audioPlayer.play();

      notifyListeners();
    }
  }

  void togglePlay() async {
    if (_playing) {
      _playing = false;
      await _audioPlayer.pause();
    } else {
      _playing = true;
      await _audioPlayer.play();
    }
    notifyListeners();
  }

  void seek(Duration position) async {
    await _audioPlayer.seek(position);
  }

  void playNextSong() async {
    if (_songs.isNotEmpty) {
      await _audioPlayer.stop();
      _playing = false;
      currentSongIndex = (currentSongIndex + 1) % _songs.length;
      notifyListeners();
    }
  }

  void playPreviousSong() async {
    if (_songs.isNotEmpty) {
      if (_currentDuration.inSeconds > 2) {
        seek(Duration.zero);
      } else {
        await _audioPlayer.stop();
        _playing = false;
        currentSongIndex =
            (currentSongIndex - 1 + _songs.length) % _songs.length;
        notifyListeners();
        play();
      }
    }
  }

  PlaylistProvider() {
    listenToDuration();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      fetchSongs();
    });
  }
  void listenToDuration() {
    _audioPlayer.durationStream.listen((newDuration) {
      _totalDuration = (newDuration ?? Duration.zero);
      notifyListeners();
    });

    _audioPlayer.positionStream.listen((newPosition) {
      _currentDuration = newPosition;
      notifyListeners();
    });

    _audioPlayer.playerStateStream.listen((state) {
      if (state.processingState == ProcessingState.completed) {
        playNextSong();
      }
    });
  }

  // G E T T E R S
  int get currentSongIndex => _currentSongIndex;
  List<Song> get songs => _songs;

  Song get currSong => _songs[currentSongIndex];
  bool get isPlaying => _playing;
  Duration get currDur => _currentDuration;
  Duration get totDur => _totalDuration;
  // setters
  set currentSongIndex(int newIndex) {
    _currentSongIndex = newIndex;
    play();
    notifyListeners();
  }
}
