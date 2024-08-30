import 'package:flutter/material.dart';

class ProjectManager extends StatefulWidget {
  const ProjectManager({super.key});
  //List<Project> projects;
  @override
  State<StatefulWidget> createState() => ProjectManagerState();
}

class ProjectManagerState extends State<ProjectManager> {
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        itemBuilder: (context, index) {
          return const ProjectItem();
        },
        separatorBuilder: (context, index) => const SizedBox(height: 20),
        itemCount: 10);
  }
}

class ProjectItem extends StatelessWidget {
  const ProjectItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration:
          BoxDecoration(borderRadius: BorderRadius.circular(10), boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.1),
          spreadRadius: 5,
          blurRadius: 7,
          offset: const Offset(0, 3), // changes position of shadow
        ),
      ]),
      child: const ListTile(
        title: Text("Project Name"),
        subtitle: Text("Project Manager"),
        trailing: Icon(Icons.chevron_right),
      ),
    );
  }
}
