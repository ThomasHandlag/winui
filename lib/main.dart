import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:winui/components/circle_audio_visualizer.dart';
import 'package:winui/components/github_status.dart';
import 'package:winui/components/lamb.dart';
import 'package:winui/components/sidebar.dart';
import 'package:winui/components/status_box.dart';
import 'package:winui/components/user_box.dart';
import 'package:winui/theme.dart';
import 'dart:developer' as dev;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      darkTheme: const MaterialTheme(TextTheme()).dark(),
      theme: const MaterialTheme(TextTheme()).light(),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final int _pageIndex = 0;

  bool _isPlay = false;

  int _noise = 0;

  final player = AudioPlayer();

  void getAudioInfo() async {
    if (_isPlay) {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      alignment: Alignment.centerLeft,
      fit: StackFit.expand,
      children: [
        Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color.fromARGB(250, 10, 0, 100),
                Colors.black,
              ],
              begin: Alignment.topLeft,
              end: Alignment.centerRight,
              stops: [0.0, 1.0],
              tileMode: TileMode.clamp,
            ),
            image: DecorationImage(
                image: AssetImage('assets/images/bg1.jpg'), fit: BoxFit.fill),
          ),
        ),
        Row(
          children: [
            const Sidebar(maxWidth: 200),
            Expanded(
                child: Container(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        const Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            StatusBox(
                                label: "Projects",
                                value: "10",
                                iconData: Icons.folder),
                            StatusBox(
                              label: "Line of code",
                              value: "100832",
                              iconData: Icons.code,
                            ),
                            StatusBox(
                                label: "Hour of work",
                                value: "102",
                                iconData: Icons.hourglass_full),
                            UserBox(name: "Ọp ti mớt pờ rai", avatarPath: "0")
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width * 0.4,
                              height: 300,
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                  color: Colors.black,
                                  backgroundBlendMode: BlendMode.softLight,
                                  borderRadius: BorderRadius.circular(10)),
                              child: const Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "180921 commit in the last year",
                                    ),
                                    GitHubStatus(),
                                  ]),
                            ),
                            const Lamb(),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Container(
                                width: MediaQuery.of(context).size.width * 0.4,
                                height: 300,
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                    color: Colors.black,
                                    backgroundBlendMode: BlendMode.softLight,
                                    borderRadius: BorderRadius.circular(10)),
                                child: const Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Daily Report",
                                      ),
                                      Expanded(
                                          child: CircleAudioVisualizer(
                                              angleStep: 360 / 120,
                                              numBar: 120,
                                              barWidth: 10,
                                              barHeight: 10)),
                                    ])),
                            Container(
                              width: MediaQuery.of(context).size.width * 0.4,
                              height: 300,
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                  color: Colors.black,
                                  backgroundBlendMode: BlendMode.softLight,
                                  borderRadius: BorderRadius.circular(10)),
                              child: const Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Weekly Report",
                                    )
                                  ]),
                            )
                          ],
                        ),
                      ],
                    )))
          ],
        ),
      ],
    ));
  }
}
