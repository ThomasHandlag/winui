import 'dart:math';

import 'package:flutter/material.dart';
import 'package:winui/common/layouts/github_stat_layout.dart';

class GitHubStatus extends StatefulWidget {
  const GitHubStatus({super.key});

  @override
  State<StatefulWidget> createState() => GitHubStatusState();
}

class GitHubStatusState extends State<GitHubStatus> {
  List<int> years = [2021, 2022, 2023, 2024];
  int _selectedYear = 0;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 190,
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.grey.shade900,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
                child: Column(children: [
              Expanded(
                  child: Scrollbar(
                      controller: _scrollController,
                      child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          controller: _scrollController,
                          child: const SizedBox(
                              width: 500,
                              child: Column(
                                children: [
                                  Expanded(
                                      child:
                                          GitHubStatusLayout(data: [1, 2, 3])),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                        child:
                                            Text("Learn more about Github API",
                                                style: TextStyle(
                                                  fontSize: 11,
                                                )),
                                      ),
                                      StatusInfo(
                                        data: [],
                                      ),
                                    ],
                                  )
                                ],
                              ))))),
            ])),
            YearSelectList(
                years: years,
                onSelected: (value) => setState(() {
                      _selectedYear = value;
                    }))
          ],
        ));
  }
}

class StateBox extends StatelessWidget {
  StateBox({super.key});

  final listColors = const [
    Color.fromARGB(255, 44, 37, 48),
    Color.fromARGB(255, 105, 0, 160),
    Color.fromARGB(255, 130, 0, 185),
    Color.fromARGB(255, 155, 0, 205),
    Color.fromARGB(255, 200, 0, 255),
  ];

  final random = Random();

  @override
  Widget build(BuildContext context) {
    var index = random.nextInt(listColors.length);
    return Padding(
        padding: const EdgeInsets.all(1),
        child: Container(
            width: 12,
            height: 12,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(2),
              color: listColors[index],
            ),
            child: GestureDetector(
              onTap: () {},
              child: Tooltip(
                message: "$index commits on 5 july 2024",
              ),
            )));
  }
}

class YearSelectList extends StatefulWidget {
  const YearSelectList(
      {super.key, required this.years, required this.onSelected});
  final List<int> years;
  final Function(int) onSelected;
  @override
  State<StatefulWidget> createState() => YearSelectListState();
}

class YearSelectListState extends State<YearSelectList> {
  int _selectedYear = 0;
  @override
  Widget build(context) {
    return Container(
        color: const Color.fromRGBO(0, 0, 0, 0),
        padding: const EdgeInsets.all(10.0),
        width: 60,
        child: ListView.separated(
          separatorBuilder: (context, index) => const SizedBox(height: 10),
          itemBuilder: (context, index) {
            return Material(
                color: _selectedYear != index
                    ? Colors.transparent
                    : Colors.purple.shade300,
                borderRadius: BorderRadius.circular(5),
                child: InkWell(
                  onTap: () {
                    setState(() {
                      _selectedYear = index;
                    });
                    widget.onSelected(widget.years[index]);
                  },
                  borderRadius: BorderRadius.circular(5),
                  child: Container(
                    padding: const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Text(widget.years[index].toString()),
                  ),
                ));
          },
          itemCount: widget.years.length,
        ));
  }
}

class StatusInfo extends StatelessWidget {
  const StatusInfo({super.key, required this.data});
  final List<int> data;
  final listColors = const [
    Colors.transparent,
    Color.fromARGB(255, 44, 37, 48),
    Color.fromARGB(255, 105, 0, 160),
    Color.fromARGB(255, 130, 0, 185),
    Color.fromARGB(255, 155, 0, 205),
    Color.fromARGB(255, 200, 0, 255),
    Colors.transparent,
  ];
  @override
  Widget build(BuildContext context) {
    return Container(
        width: 200,
        height: 35,
        padding: const EdgeInsets.all(10),
        child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              if (index == 0) {
                return const Text("Less",
                    style: TextStyle(color: Colors.grey, fontSize: 12));
              } else if (index == listColors.length - 1) {
                return const Text("More",
                    style: TextStyle(color: Colors.grey, fontSize: 12));
              } else {
                return Container(
                  width: 12,
                  height: 12,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: listColors[index],
                  ),
                );
              }
            },
            separatorBuilder: (context, index) => const SizedBox(width: 5),
            itemCount: listColors.length));
  }
}
