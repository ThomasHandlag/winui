import 'package:flutter/material.dart';
import 'package:winui/components/github_status.dart';
import 'package:winui/components/lamb.dart';
import 'package:winui/components/sidebar.dart';
import 'package:winui/components/status_box.dart';
import 'package:winui/components/user_box.dart';
import 'package:winui/theme.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      alignment: Alignment.centerLeft,
      fit: StackFit.expand,
      children: [
        Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
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
                            UserBox(
                                name: "Ọp ti mớt pờ rai",
                                avatarPath:
                                    "https://p16-sign-sg.tiktokcdn.com/aweme/100x100/tos-alisg-avt-0068/3dd0fb8b5f71a701086c8ec4065836f2.jpeg?lk3s=a5d48078&nonce=3544&refresh_token=d76a35bedb747fc761cc3d9aaf15dd36&x-expires=1719900000&x-signature=RUfS1VM%2FJ10E6B%2BaNmcW4f4ltTg%3D&shp=a5d48078&shcp=81f88b70")
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Container(
                                width: 600,
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
                                      )
                                    ])),
                            Container(
                              width: 600,
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
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Container(
                              width: 600,
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
                                      "180921 line of code in the last year",
                                    ),
                                     GitHubStatus(),
                                  ]),
                            ),
                            const Lamb(),
                          ],
                        )
                      ],
                    )))
          ],
        )
      ],
    ) // This trailing comma makes auto-formatting nicer for build methods.
        );
  }
}
