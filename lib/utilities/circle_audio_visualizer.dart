import 'dart:typed_data';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:winui/utilities/music_player.dart';
import 'package:winui/utilities/songs_displayer.dart';

class CircleAudioVisualizer extends StatefulWidget {
  const CircleAudioVisualizer(
      {super.key,
      required this.angleStep,
      required this.numBar,
      required this.barWidth,
      required this.barHeight});
  final double angleStep;
  final int numBar;
  final double barWidth;
  final double barHeight;
  @override
  State<StatefulWidget> createState() => CircleAudioVisualizerState();
}

class CircleAudioVisualizerState extends State<CircleAudioVisualizer>
    with TickerProviderStateMixin {
  double _progress = 0.0;
  late Animation<double> animation;
  late AnimationController controller;
  late Animation curveAnimation;
  List<double> _audioData = [];
  final AudioPlayer _audioPlayer = AudioPlayer();
  bool _isPlaying = false;

  void _setCurrentSong(String uri) {
    _isPlaying = true;
    setState(() {
      _currentURL = uri;
    });
  }

  int _duration = 0;
  int _currentPosition = 0;

  String _currentURL = "";

  final songs = <Song>[
    Song(
        name: 'Lost in the middle',
        artist: 'NCS',
        uri: 'audio/lostinmiddle.mp3'),
    Song(name: 'Love U', artist: 'NCS', uri: 'audio/loveu.mp3'),
    Song(name: 'Survive', artist: 'NCS', uri: 'audio/survive.mp3'),
    Song(
        name: 'Calling out your name', artist: 'NCS', uri: 'audio/calling.mp3'),
  ];

  @override
  void initState() {
    super.initState();
    setState(() {
      _currentURL = songs[0].uri;
    });
    controller = AnimationController(
        duration: const Duration(milliseconds: 100),
        vsync: this,
        reverseDuration: const Duration(milliseconds: 100),
        animationBehavior: AnimationBehavior.preserve);
    _audioPlayer.onDurationChanged.listen((value) {
      setState(() {
        _duration = value.inSeconds;
      });
    });
    _audioPlayer.onPositionChanged.listen((event) {
      setState(() {
        _currentPosition = event.inSeconds;
      });
    });
    _audioPlayer.onPlayerComplete.listen((event) {
      setState(() {
        _isPlaying = false;
        _audioData = [];
      });
    });

    _audioPlayer.onPlayerStateChanged.listen((event) {
      if (event == PlayerState.playing) {
        setState(() {
          _isPlaying = true;
        });
        start();
      } else if (event == PlayerState.paused) {
        setState(() {
          _isPlaying = false;
        });
      }
    });

    curveAnimation = CurvedAnimation(parent: controller, curve: Curves.easeIn)
      ..addListener(() {
        setState(() {
          _progress = curveAnimation.value;
        });
      })
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          controller.repeat();
        } else if (status == AnimationStatus.dismissed) {
          controller.forward();
        }
      });
  }

  void _getSongDuration() async {
    await _audioPlayer
        .getDuration()
        .then((value) => setState(() => _duration = value!.inSeconds));
  }

  void start() {
    _getSongDuration();
    controller.forward();
  }

  @override
  void dispose() {
    controller.dispose();
    _isPlaying = false;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(20),
        child: Wrap(
          children: [
            SizedBox(
                width: 250,
                height: 250,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                          child: CustomPaint(
                              painter: CircleAudioVisualizerPainter(_progress,
                                  _audioData, _isPlaying, _currentPosition, 80),
                              child: Container())),
                      MusicPlayer(
                        audioPlayer: _audioPlayer,
                        openSong: _setCurrentSong,
                        songs: songs,
                        onPressed: () {
                          if (_isPlaying) {
                            _audioPlayer.pause();
                            controller.stop();
                          } else {
                            _audioPlayer.play(AssetSource(_currentURL));
                            controller.forward();
                          }
                        },
                      )
                    ])),
          ],
        ));
  }
}

class CircleAudioVisualizerPainter extends CustomPainter {
  List<double> data;

  final colors = <Color>[
    Colors.cyan.shade500,
    Colors.blue.shade500,
    Colors.purple.shade500,
    Colors.pink.shade300,
    Colors.red.shade500,
    Colors.orange.shade500,
    Colors.yellow.shade500,
    Colors.green.shade500,
    Colors.brown.shade500,
  ];

  double dy;
  bool isPlaying;
  int currentPosition;
  int numbars;

  CircleAudioVisualizerPainter(
      this.dy, this.data, this.isPlaying, this.currentPosition, this.numbars);

  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint();
    paint.style = PaintingStyle.stroke;

    paint.strokeWidth = 6;
    paint.color = const Color.fromARGB(150, 50, 0, 150);
  }

  @override
  bool shouldRepaint(CircleAudioVisualizerPainter oldDelegate) => false;
}
