import 'package:flutter/material.dart';

class StatusBox extends StatelessWidget {
  const StatusBox(
      {super.key,
      required this.label,
      required this.value,
      required this.iconData});
  final String label;
  final String value;
  final IconData iconData;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: MediaQuery.of(context).size.width > 800
            ? MediaQuery.of(context).size.width * 0.2
            : MediaQuery.of(context).size.width * 0.8,
        child: Material(
          color: Colors.transparent,
          child: Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                backgroundBlendMode: BlendMode.softLight,
                color: Colors.black,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(label,
                          style: const TextStyle(color: Colors.blueGrey)),
                      Text(value),
                    ],
                  ),
                  Container(
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(10)),
                    child: Icon(iconData, size: 20, color: Colors.white),
                  ),
                ],
              )),
        ));
  }
}
