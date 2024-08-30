import 'package:flutter/material.dart';

class SongsDisplayer extends StatelessWidget {
  const SongsDisplayer(
      {super.key, required this.songs, required this.onPressed});
  final ValueChanged<String> onPressed;
  final List<Song> songs;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(2),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10), color: Colors.grey.shade900),
      child: ListView.separated(
        itemCount: songs.length,
        itemBuilder: (context, index) {
          return Material(
              color: Colors.transparent,
              child: InkWell(
                  onTap: () {
                    onPressed(songs[index].uri);
                  },
                  child: Container(
                      width: 120,
                      padding: const EdgeInsets.all(10),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              songs[index].name,
                              style:
                                  const TextStyle(overflow: TextOverflow.fade),
                            ),
                            Text(
                              songs[index].artist,
                              style: const TextStyle(
                                  overflow: TextOverflow.fade,
                                  fontSize: 10,
                                  color: Colors.white70),
                            ),
                          ]))));
        },
        separatorBuilder: (context, index) => const Divider(),
      ),
    );
  }
}

class Song {
  final String name;
  final String artist;
  final String uri;
  Song({required this.name, required this.artist, required this.uri});
}
