import 'dart:async';
import 'dart:math';
import 'dart:typed_data';

import 'package:audioplayers/audioplayers.dart';
import 'package:ffi/ffi.dart';
import 'package:flutter/material.dart';
import 'package:winui/components/music_player.dart';
import 'package:winui/components/songs_displayer.dart';
import 'dart:developer' as dev;
import 'package:fftea/fftea.dart';

import 'package:winui/custom/audiocapture.dart';

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
    with SingleTickerProviderStateMixin {
  double _progress = 0.0;
  late Animation<double> animation;
  late AnimationController controller;

  final AudioCapture _audioCapture = AudioCapture();
  final Float32List _audioBuffer =
      Float32List(44100); // 1 second buffer at 44.1 kHz
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
    Song(name: 'Song 2', artist: 'Artist 2', uri: 'audio/tiny.mp3'),
    Song(name: 'Song 3', artist: 'Artist 3', uri: 'audio/1.mp3'),
    Song(name: 'Song 4', artist: 'Artist 4', uri: 'audio/lostinmiddle.mp3'),
  ];

  Timer? _timer;

  @override
  void initState() {
    super.initState();
    setState(() {
      _currentURL = songs[0].uri;
    });
    controller = AnimationController(
        duration: const Duration(milliseconds: 100), vsync: this);
    animation = Tween(begin: 0.0, end: 1.0).animate(controller)
      ..addListener(() {
        setState(() {
          _progress = animation.value;
        });
      })
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          controller.repeat();
        } else if (status == AnimationStatus.dismissed) {
          controller.forward();
        }
      });
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
      _audioCapture.stop();
      setState(() {
        _isPlaying = false;
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
        _audioCapture.stop();
      }
    });
    _timer = Timer.periodic(const Duration(milliseconds: 100), (timer) {
      if (_audioCapture.getAudioData(_audioBuffer)) {
        setState(() {
          _audioData = _audioBuffer.toList();
        });
      }
    });
  }

  void _getSongDuration() async {
    await _audioPlayer
        .getDuration()
        .then((value) => setState(() => _duration = value!.inSeconds));
  }

  void start() {
    _audioCapture.start();
    _getSongDuration();
    controller.forward();
  }

  @override
  void dispose() {
    controller.dispose();
    _audioCapture.stop();
    _isPlaying = false;
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(1),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
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
            SongsDisplayer(
              songs: songs,
              onPressed: _setCurrentSong,
            ),
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
    var angle = 0.0;

    if (isPlaying) {
      final fft = FFT(data.length);
      final freq = fft.realFft(data);

      var mappedData = <double>[];
      for (int i = 0; i < data.length; i++) {
        mappedData.add((data[i] + 1) * 10);
      }

      final random = Random();

      var avgWaveform = <double>[];
      var minWaveform = <double>[];
      var maxWaveform = <double>[];

      var segmentLength = mappedData.length ~/ numbars;
      for (int i = 0; i < numbars; i++) {
        var segment = mappedData.sublist(i, segmentLength - 1);
        var avgValue = segment.reduce((a, b) => a + b) / segmentLength;
        segment.sort();
        minWaveform.add(mappedData.first);
        maxWaveform.add(mappedData.last);
        avgWaveform.add(avgValue);
      }

      for (int i = 0; i < numbars; i++, angle += 2 * pi / numbars) {
        // if (i % (numbars / colors.length) == 0) {
        //   paint.color = colors[i ~/ (numbars / colors.length - 1)];
        // }
        paint.color = const Color.fromARGB(150, 50, 0, 150);

        double x1 = (size.width / 2) - 70 * cos(angle - pi / 2);
        double y1 = (size.height / 2) - 70 * sin(angle - pi / 2);

        double x2 =
            (size.width / 2) + (avgWaveform[i] * dy + 90) * cos(angle + pi / 2);
        double y2 = (size.height / 2) +
            (avgWaveform[i] * dy + 90) * sin(angle + pi / 2);
        var next = Offset(x2, y2);
        canvas.drawLine(Offset(x1, y1), next, paint);

        paint.color = const Color.fromARGB(150, 80, 0, 180);

        double x1Min = (size.width / 2) - 70 * cos(angle - pi / 2);
        double y1Min = (size.height / 2) - 70 * sin(angle - pi / 2);

        double x2Min = (size.width / 2) +
            (maxWaveform[i] * dy + 100) * cos(angle + pi / 2);
        double y2Min = (size.height / 2) +
            (maxWaveform[i] * dy + 100) * sin(angle + pi / 2);
        var nextMin = Offset(x2Min, y2Min);
        canvas.drawLine(Offset(x1Min, y1Min), nextMin, paint);
        paint.color = const Color.fromARGB(100, 30, 30, 30);
        paint.style = PaintingStyle.fill;
        var rect = Rect.fromCircle(
            center: Offset(size.width / 2, size.height / 2),
            radius: 50.0 + (dy * minWaveform[i]));
        canvas.drawOval(rect, paint);
      }
    }
    paint.color = Colors.black54;
    paint.strokeWidth = 2;
    paint.style = PaintingStyle.fill;
    var rect = Rect.fromCircle(
        center: Offset(size.width / 2, size.height / 2), radius: 80);
    canvas.drawOval(rect, paint);
  }

  @override
  bool shouldRepaint(CircleAudioVisualizerPainter oldDelegate) => isPlaying;
}
