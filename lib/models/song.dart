import 'package:flutter/material.dart';
import 'package:music_player/colors/color_extension.dart';

class Song extends StatelessWidget {
  final String songName;
  final String artist;
  final Widget cover;
  final String audioPath;

  const Song({
    super.key,
    required this.songName,
    required this.artist,
    required this.cover,
    required this.audioPath,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
      color: darkGray,
      borderRadius: BorderRadius.all(Radius.circular(10)),
      boxShadow: [
       
        
      ]

      ),
      child: ListTile(
        title: Text(songName, overflow: TextOverflow.ellipsis, maxLines: 1),
        subtitle: Text(artist == "<unknown>" ? "Artist" : artist),
        leading: cover,
      ),
    );
  }
}
