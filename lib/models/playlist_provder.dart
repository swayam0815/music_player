// Example usage in a widget
import 'package:flutter/material.dart';
import 'package:on_audio_query/on_audio_query.dart';

class SongListPage extends StatefulWidget {
  @override
  _SongListPageState createState() => _SongListPageState();
}

class _SongListPageState extends State<SongListPage> {
  final OnAudioQuery _audioQuery = OnAudioQuery();
  List<SongModel> _songs = [];
  bool _loading = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    fetchSongs();
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
                return Container(
                  margin: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    border: Border.all(color: Theme.of(context).colorScheme.secondary),
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    color: Theme.of(context).colorScheme.secondary,
                  ), 
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(25))
                        ),
                        margin: EdgeInsets.only(right: 15),
                        child: QueryArtworkWidget(
                          controller: _audioQuery,
                          id: _songs[index].id,
                          type: ArtworkType.AUDIO,
                          artworkBorder: BorderRadius.all(Radius.zero),
                        ),
                      ),
                      Flexible(
                        
                        child: Text(
                          _songs[index].title,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
    );
  }
}


// ListTile(
//                   title: Text(_songs[index].title),
            
//                   subtitle: Text(_songs[index].artist ?? "Unknown Artist"),
//                   leading: QueryArtworkWidget(
//                     controller: _audioQuery,
//                     id: _songs[index].id,
//                     type: ArtworkType.AUDIO,
//                     artworkBorder: BorderRadius.all(Radius.zero),
//                   ),
                  
//                 );