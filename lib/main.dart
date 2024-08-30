import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:winui/common/pages/home_page.dart';
import 'package:winui/common/widgets/background.dart';
import 'package:winui/global/global.dart';
import 'package:winui/global/global_bloc.dart';
import 'package:winui/theme.dart';
import 'package:winui/utilities/sidebar.dart';
import 'package:winui/common/pages/setting_page.dart';
import 'package:winui/common/pages/task_page.dart';
import 'dart:developer' as dev;

void main() {
  Bloc.observer = MyBlocObserver();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fkin shit',
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
  final List<Widget> pages = [
    const HomePage(),
    TaskPage(),
    SettingPage(),
  ];

  @override
  void dispose() {
    super.dispose();
  }

  final SidebarBloc bloc = SidebarBloc();

  late Sidebar sidebar;

  @override
  void initState() {
    super.initState();
    sidebar = Sidebar(maxWidth: 200, bloc: bloc);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: MediaQuery.of(context).size.width > 500
            ? null
            : AppBar(
                leading: Builder(builder: (context) {
                  return IconButton(
                    icon: const Icon(Icons.menu),
                    onPressed: () {
                      if (bloc.state.isOpen) {
                        Scaffold.of(context).openDrawer();
                      }
                      bloc.add(const SidebarExpandEvent());
                    },
                  );
                }),
              ),
        drawer: MediaQuery.of(context).size.width > 500
            ? null
            : Container(
                decoration: const BoxDecoration(
                  color: Colors.black,
                  backgroundBlendMode: BlendMode.softLight,
                ),
                child: sidebar),
        body: Stack(
            alignment: Alignment.topLeft,
            fit: StackFit.expand,
            children: [
              const Background(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  MediaQuery.of(context).size.width < 500
                      ? Container()
                      : Container(
                          decoration: const BoxDecoration(
                              backgroundBlendMode: BlendMode.softLight,
                              color: Colors.black),
                          child: sidebar,
                        ),
                  Expanded(
                    child: pages[bloc.state.index],
                  )
                ],
              )
            ]));
  }
}
