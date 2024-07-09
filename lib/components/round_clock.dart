import 'dart:async';

import 'package:flutter/material.dart';

class RoundClock extends StatefulWidget {
  const RoundClock({super.key});

  @override
  State<StatefulWidget> createState() => RoundClockState();
}

class RoundClockState extends State<RoundClock> {
  DateTime _date = DateTime.now();

  @override
  void initState() {
    super.initState();
    Timer.periodic(const Duration(seconds: 1), (timer) {
      timer.tick;
      setState(() {
        _date = DateTime.now();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: Colors.grey.shade600),
        padding: const EdgeInsets.all(5),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(5),
                      bottomLeft: Radius.circular(5)),
                  color: Colors.purple.shade300),
              child: Text(
                "${_date.hour}",
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            const Text(":",
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
            Container(
              padding: const EdgeInsets.all(5),
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(5),
                      bottomRight: Radius.circular(5)),
                  color: Colors.grey),
              child: Text("${_date.minute > 9 ? "" : "0"}${_date.minute}",
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold)),
            ),
            Container(
                padding: const EdgeInsets.all(5),
                decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(5),
                        bottomRight: Radius.circular(5)),
                    color: Colors.grey),
                child: Text("${_date.second > 9 ? "" : "0"}${_date.second}",
                    style: const TextStyle(fontSize: 12)))
          ],
        ));
  }
}
