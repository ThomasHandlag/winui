import 'dart:math';

import 'package:flutter/material.dart';
import 'package:winui/components/round_clock.dart';

class Lamb extends StatefulWidget {
  const Lamb({super.key});

  @override
  State<StatefulWidget> createState() => LambState();
}

class LambState extends State<Lamb> {

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 600,
      height: 300,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.black,
        backgroundBlendMode: BlendMode.softLight,
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              CustomPaint(
                  painter: LambPanter(color: Colors.grey.shade800, radius: 65),
                  child: Container(
                    padding: const EdgeInsets.all(20),
                    width: 150,
                    height: 150,
                  )),
              const RoundClock(),
            ],
          )
        ],
      ),
    );
  }
}

class LambPanter extends CustomPainter {
  final Color color;
  final double radius;

  LambPanter({required this.color, required this.radius});

  final textStyle = const TextStyle(
    color: Colors.white,
    fontSize: 15,
  );

  final textPainter = TextPainter(
    textAlign: TextAlign.center,
    textDirection: TextDirection.ltr,
  );
  // base offset from I(0,0)

  @override
  void paint(Canvas canvas, Size size) {
    var center = const Offset(75, 75);

    var a = center.dx + radius;
    var paint = Paint();
    paint.color = color;
    canvas.drawOval(
        Rect.fromCenter(center: center, width: a, height: a), paint);
    paint.color = Colors.pink.shade300;
    canvas.drawOval(
        Rect.fromCenter(center: center, width: 5, height: 5), paint);

    DateTime now = DateTime.now();
    double hour = now.hour.toDouble();
    double minute = now.minute.toDouble();
    double second = now.second.toDouble();

    double hourRadians = (hour * 30 + minute * 0.5) * pi / 180;

    double hourHandX = center.dx + radius * 0.85 * cos(hourRadians - pi / 2);
    double hourHandY = center.dy + radius * 0.85 * sin(hourRadians - pi / 2);
    
    paint.strokeWidth = 2;
    paint.color = Colors.pink;
    canvas.drawLine(
        Offset(center.dx, center.dy), Offset(hourHandX, hourHandY), paint);

    canvas.drawOval(
        Rect.fromCenter(
            center: Offset(hourHandX, hourHandY), width: 20, height: 20),
        paint);
    double minuteRadians = (minute * 6) * pi / 180;
    double minuteHandX = center.dx + radius * 0.7 * cos(minuteRadians - pi / 2);
    double minuteHandY = center.dy + radius * 0.7 * sin(minuteRadians - pi / 2);
    paint.strokeWidth = 2;
    canvas.drawLine(Offset(center.dx, center.dy), Offset(minuteHandX, minuteHandY), paint);

    double secondRadians = (second * 6) * pi / 180;
    double secondHandX = center.dx + radius * 0.8 * cos(secondRadians - pi / 2);
    double secondHandY = center.dy + radius * 0.8 * sin(secondRadians - pi / 2);
    paint.strokeWidth = 1;
    canvas.drawLine(Offset(center.dx, center.dy), Offset(secondHandX, secondHandY), paint);

    double hourRadius = radius - 10;
    TextPainter textPainter = TextPainter(
      textDirection: TextDirection.ltr,
    );
    for (int i = 0; i < 12; i++) {
      double angle = (i * 30) * pi / 180;
      double x = center.dx + hourRadius * cos(angle - pi / 2);
      double y = center.dy + hourRadius * sin(angle - pi / 2);
      textPainter.text = TextSpan(
        text: '$i',
        style: const TextStyle(
          color: Colors.white,
          fontSize: 12,
        ),
      );
      textPainter.layout();
      textPainter.paint(
        canvas,
        Offset(x - textPainter.width / 2, y - textPainter.height / 2),
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
