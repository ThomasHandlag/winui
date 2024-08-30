import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:winui/utilities/songs_displayer.dart';

class MusicPlayer extends StatefulWidget {
  const MusicPlayer(
      {super.key,
      required this.onPressed,
      required this.audioPlayer,
      required this.songs,
      required this.openSong});
  final VoidCallback onPressed;
  final AudioPlayer audioPlayer;
  final List<Song> songs;
  final ValueChanged<String> openSong;
  @override
  State<StatefulWidget> createState() => MusicPlayerState();
}

class MusicPlayerState extends State<MusicPlayer> {
  int _duration = 0;
  int _currentPosition = 0;

  @override
  void initState() {
    super.initState();
    widget.audioPlayer.onDurationChanged.listen((event) {
      setState(() {
        _duration = event.inSeconds;
      });
    });
    widget.audioPlayer.onPositionChanged.listen((event) {
      setState(() {
        _currentPosition = event.inSeconds;
      });
    });
  }

  bool _offState = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(2),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        // border: Border.all(color: Colors.white),
        boxShadow: const [BoxShadow(color: Colors.black, blurRadius: 4)],
        backgroundBlendMode: BlendMode.plus,
        gradient: const LinearGradient(
          colors: [Colors.blue, Colors.purple],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Column(children: [
        Row(
          children: [
            Expanded(
                child: Slider(
                    value: _currentPosition.toDouble(),
                    onChanged: (value) {
                      widget.audioPlayer.seek(Duration(seconds: value.toInt()));
                    },
                    max: _duration.toDouble(),
                    min: 0.0)),
            IconButton(
                onPressed: () {
                  setState(() {
                    _offState = !_offState;
                  });
                },
                icon: const Icon(Icons.chevron_right)),
          ],
        ),
        Offstage(
          offstage: _offState,
          child: SizedBox(
            height: 160,
            child: SongsDisplayer(
              songs: widget.songs,
              onPressed: widget.openSong,
            ),
          ),
        ),
        if (_offState)
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconButton(
                  onPressed: () {
                    widget.onPressed();
                  },
                  icon: const Icon(Icons.skip_previous)),
              IconButton(
                  onPressed: () {
                    widget.onPressed();
                  },
                  icon: Icon(widget.audioPlayer.state == PlayerState.playing
                      ? Icons.pause
                      : Icons.play_arrow)),
              IconButton(
                  onPressed: () {
                    widget.onPressed();
                  },
                  icon: const Icon(Icons.skip_next)),
            ],
          )
      ]),
    );
  }
}
