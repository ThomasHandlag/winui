import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'dart:developer' as dev;

class MusicPlayer extends StatefulWidget {
  const MusicPlayer(
      {super.key,
      required this.onPressed,
      required this.audioPlayer});
  final VoidCallback onPressed;
  final AudioPlayer audioPlayer;
  @override
  State<StatefulWidget> createState() => MusicPlayerState();
}

class MusicPlayerState extends State<MusicPlayer> {

  int _duration = 0;
  int _currentPosition =0;

  @override
  void initState() {
    super.initState();
    widget.audioPlayer.onDurationChanged.listen((event) {
      setState(() {
        _duration = event.inSeconds;
      });
      dev.log(event.inSeconds.toString());
    });
    widget.audioPlayer.onPositionChanged.listen((event) {
      setState(() {
        _currentPosition = event.inSeconds;
      });
    });
  }

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
        Slider(
            value: _currentPosition.toDouble(),
            onChanged: (value) {
              widget.audioPlayer.seek(Duration(seconds: value.toInt()));
            },
            max: _duration.toDouble(),
            min: 0.0),
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
                icon: Icon(widget.audioPlayer.state == PlayerState.playing ? Icons.pause : Icons.play_arrow)),
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
