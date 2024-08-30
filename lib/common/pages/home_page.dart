import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:winui/utilities/circle_audio_visualizer.dart';
import 'package:winui/utilities/github_status.dart';
import 'package:winui/utilities/lamb.dart';
import 'package:winui/utilities/project_manager.dart';
import 'package:winui/utilities/sidebar.dart';
import 'package:winui/utilities/status_box.dart';
import 'package:winui/utilities/user_box.dart';
import 'package:winui/model/common_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  State<StatefulWidget> createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  final infoBox = const <InforBoxData>[
    InforBoxData(label: "Projects", value: "10", iconData: Icons.folder),
    InforBoxData(label: "Line of code", value: "100832", iconData: Icons.code),
    InforBoxData(
        label: "Hour of work", value: "102", iconData: Icons.hourglass_full)
  ];
  final useBox = const UserBox(name: "Ọp ti mớt pờ rai", avatarPath: "0");

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              MediaQuery.of(context).size.width < 800
                  ? CarouselSlider.builder(
                      itemCount: infoBox.length,
                      itemBuilder: (context, index, _) {
                        return StatusBox(
                            label: infoBox[index].label,
                            value: infoBox[index].value,
                            iconData: infoBox[index].iconData);
                      },
                      options: CarouselOptions(
                          height: MediaQuery.of(context).size.height * 0.1,
                          viewportFraction: 1))
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        for (var i = 0; i < infoBox.length; i++)
                          StatusBox(
                              label: infoBox[i].label,
                              value: infoBox[i].value,
                              iconData: infoBox[i].iconData),
                        useBox
                      ],
                    ),
              Expanded(
                child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: SingleChildScrollView(
                        child: StaggeredGrid.extent(
                      maxCrossAxisExtent: 750,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 20,
                      children: [
                        Container(
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
                          child: const ProjectManager(),
                        ),
                        const Lamb(),
                      ],
                    ))),
              ),
            ]));
  }
}
