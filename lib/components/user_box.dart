import 'package:flutter/material.dart';

class UserBox extends StatelessWidget {
  const UserBox({super.key, required this.name, required this.avatarPath});
  final String name;
  final String avatarPath;

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(10),
        constraints: const BoxConstraints(maxWidth: 150),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.background,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("User", style: TextStyle(color: Colors.blueGrey)),
                SizedBox(
                  width: 80,
                  child: Text(
                    name,
                    style: const TextStyle(overflow: TextOverflow.ellipsis),
                  ),
                ),
              ],
            ),
            Container(
              padding: const EdgeInsets.all(4),
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                  color: Colors.green, borderRadius: BorderRadius.circular(50)),
              child: ClipOval(
                // child: Image.network(avatarPath,),
                child: Image.asset("assets/images/bg2.jpg", fit: BoxFit.fill,)
              ),
            ),
          ],
        ));
  }
}
