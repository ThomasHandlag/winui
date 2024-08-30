import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:winui/global/global_bloc.dart';
import 'package:winui/utilities/sidebar_button.dart';
import 'package:winui/global/global.dart';

class Sidebar extends StatefulWidget {
  const Sidebar({super.key, required this.maxWidth, required this.bloc});

  final double maxWidth;
  final SidebarBloc bloc;

  @override
  State<StatefulWidget> createState() => SidebarState();
}

class SidebarState extends State<Sidebar> {
  bool _isAnimationEnd = false;

  final Duration animationDuration = const Duration(milliseconds: 500);

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

  late bool isDrawder;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
        builder: (context, SidebarObjectState state) => AnimatedContainer(
              onEnd: () {
                setState(() {
                  if (!state.isOpen) {
                    _isAnimationEnd = true;
                  }
                });
              },
              width: !state.isOpen
                  ? widget.maxWidth
                  : MediaQuery.of(context).size.width < 500
                      ? widget.maxWidth
                      : 80,
              height: MediaQuery.of(context).size.height,
              duration: animationDuration,
              curve: Curves.fastOutSlowIn,
              alignment: Alignment.topLeft,
              transformAlignment: Alignment.topLeft,
              child: Material(
                  elevation: 10,
                  color: Colors.transparent,
                  child: Container(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            IconButton(
                                onPressed: () {
                                  setState(() {
                                    if (state.isOpen == false) {
                                      _isAnimationEnd = false;
                                    }
                                  });
                                  widget.bloc.add(const SidebarExpandEvent());

                                  if (!state.isOpen &&
                                      Scaffold.of(context).hasDrawer) {
                                    Navigator.of(context).pop();
                                  }
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
                                  isSelected: index == state.index,
                                  icon: sidebarItems[index].values.first,
                                  label: sidebarItems[index].keys.first,
                                  isAnimationEnd: _isAnimationEnd,
                                  onPressed: () {
                                    widget.bloc.add(SidebarSelectEvent(index));
                                  },
                                );
                              },
                              separatorBuilder: (context, index) =>
                                  const SizedBox(
                                    height: 10,
                                  ),
                              itemCount: sidebarItems.length),
                        ),
                        const Spacer(),
                        Column(
                          children: [
                            SidebarButton(
                                isSelected: false,
                                icon: Icons.edit_note,
                                label: "Edit widgets",
                                isAnimationEnd: _isAnimationEnd,
                                onPressed: () {
                                  final snackBar = SnackBar(
                                    content: const Text('Yay! A SnackBar!'),
                                    behavior: SnackBarBehavior.floating,
                                    width: 300,
                                    action: SnackBarAction(
                                      label: 'Loading',
                                      onPressed: () {
                                        // Some code to undo the change.
                                      },
                                    ),
                                  );

                                  // Find the ScaffoldMessenger in the widget tree
                                  // and use it to show a SnackBar.
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(snackBar);
                                }),
                            SidebarButton(
                                isSelected: false,
                                icon: Icons.settings,
                                label: "Setting",
                                isAnimationEnd: _isAnimationEnd,
                                onPressed: () {})
                          ],
                        ),
                      ],
                    ),
                  )),
            ),
        bloc: widget.bloc);
  }
}
