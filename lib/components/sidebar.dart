import 'package:flutter/material.dart';
import 'package:winui/components/sidebar_button.dart';

class Sidebar extends StatefulWidget {
  const Sidebar({super.key, required this.maxWidth});

  final double maxWidth;

  @override
  State<StatefulWidget> createState() => SidebarState();
}

class SidebarState extends State<Sidebar> {
  bool _isExpande = false;

  bool _isAnimationEnd = false;

  final Duration animationDuration = const Duration(milliseconds: 500);

  int _index = 0;

  final List<Map<String, IconData>> sidebarItems = [
    {
      "Home": Icons.home,
    },
    {
      "Tasks": Icons.schedule,
    },
    {
      "News": Icons.newspaper,
    },
    {
      "Support": Icons.support,
    },
    {
      "About": Icons.info,
    }
  ];

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
        onEnd: () {
          setState(() {
            if (_isExpande) {
              _isAnimationEnd = true;
            }
          });
        },
        width: _isExpande ? widget.maxWidth : 80,
        height: MediaQuery.of(context).size.height,
        duration: animationDuration,
        child: Material(
            elevation: 10,
            color: Colors.transparent,
            child: Container(
              padding: const EdgeInsets.all(20.0),
              decoration: const BoxDecoration(
                  backgroundBlendMode: BlendMode.softLight,
                  color: Colors.black),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      IconButton(
                          onPressed: () {
                            setState(() {
                              _isExpande = !_isExpande;
                              if (!_isExpande) {
                                _isAnimationEnd = false;
                              }
                            });
                          },
                          icon: const Icon(Icons.menu)),
                      _isAnimationEnd
                          ? AnimatedOpacity(
                              opacity: _isAnimationEnd ? 1 : 0,
                              duration: animationDuration,
                              child: Row(
                                children: [
                                  Container(
                                    width: 5,
                                  ),
                                  const Text("WinWin")
                                ],
                              ))
                          : const Spacer(),
                    ],
                  ),
                  const Divider(),
                  Expanded(
                    child: ListView.separated(
                        itemBuilder: (context, index) {
                          return SidebarButton(
                            isSelected: index == _index,
                            icon: sidebarItems[index].values.first,
                            label: sidebarItems[index].keys.first,
                            isAnimationEnd: _isAnimationEnd,
                            onPressed: () {
                              setState(() {
                                _index = index;
                              });
                            },
                          );
                        },
                        separatorBuilder: (context, index) => const SizedBox(
                              height: 10,
                            ),
                        itemCount: sidebarItems.length),
                  ),
                  const Spacer(),
                  SidebarButton(
                      isSelected: false,
                      icon: Icons.settings,
                      label: "Setting",
                      isAnimationEnd: _isAnimationEnd,
                      onPressed: () {}),
                ],
              ),
            )));
  }
}
