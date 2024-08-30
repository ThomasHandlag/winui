import 'dart:async';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class RoundClock extends StatefulWidget {
  const RoundClock({super.key});

  @override
  State<StatefulWidget> createState() => RoundClockState();
}

class RoundClockState extends State<RoundClock> {
  DateTime _date = DateTime.now();

  Timer? timer;
  final CarouselController _carouselController = CarouselController();
  final CarouselController _carouselController2 = CarouselController();

  String monthToString(int month) {
    switch (month) {
      case 1:
        return "Jan";
      case 2:
        return "Feb";
      case 3:
        return "Mar";
      case 4:
        return "Apr";
      case 5:
        return "May";
      case 6:
        return "Jun";
      case 7:
        return "Jul";
      case 8:
        return "Aug";
      case 9:
        return "Sep";
      case 10:
        return "Oct";
      case 11:
        return "Nov";
      case 12:
        return "Dec";
      default:
        return "";
    }
  }

  int _curIndex = 0;

  int _hourIndex = 0;

  final List<String> _hourd = ["00", "00"];

  final List<String> _timd = ["00", "00"];
  @override
  void initState() {
    super.initState();
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        _date = DateTime.now();
      });

      if (_date.second == 0) {
        _carouselController.nextPage(
            duration: const Duration(seconds: 1), curve: Curves.easeInOut);
      }
      if (_date.minute == 59 && _date.second == 59) {
        _carouselController2.nextPage(
            duration: const Duration(seconds: 1), curve: Curves.easeInOut);
      }
    });
    setState(() {
      _hourd[0] = "${_date.hour > 9 ? _date.hour : "0${_date.hour}"}";
      _hourd[1] = "${_date.hour > 9 ? _date.hour : "0${_date.hour}"}";
      _timd[0] = "${_date.minute > 9 ? _date.minute : "0${_date.minute}"}";
      _timd[1] = "${_date.minute > 9 ? _date.minute : "0${_date.minute}"}";
    });
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 138,
      height: 120,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5), color: Colors.grey.shade900),
      padding: const EdgeInsets.all(5),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                  width: 60,
                  padding: const EdgeInsets.all(15),
                  decoration: BoxDecoration(
                      borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(5),
                          bottomLeft: Radius.circular(5)),
                      color: Colors.purple.shade900),
                  child: CarouselSlider.builder(
                    itemCount: 2,
                    disableGesture: true,
                    carouselController: _carouselController2,
                    itemBuilder: (context, index, _) => Text(_hourd[index],
                        style: const TextStyle(
                            fontSize: 24, fontWeight: FontWeight.bold)),
                    options: CarouselOptions(
                        scrollDirection: Axis.vertical,
                        viewportFraction: 1,
                        enableInfiniteScroll: true,
                        onPageChanged: (nextIndex, reason) {
                          setState(() {
                            _hourIndex = nextIndex;
                            _hourd[nextIndex] =
                                "${_date.hour > 9 ? "" : "0"}${_date.hour}";
                          });
                        },
                        aspectRatio: 1),
                  )),
              const Text(":",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
              Container(
                  padding: const EdgeInsets.all(15),
                  width: 60,
                  decoration: BoxDecoration(
                      borderRadius: const BorderRadius.only(
                          topRight: Radius.circular(5),
                          bottomRight: Radius.circular(5)),
                      color: Colors.purple.shade800),
                  child: CarouselSlider.builder(
                    itemCount: 2,
                    disableGesture: true,
                    itemBuilder: (context, index, _) => Text(_timd[index],
                        style: const TextStyle(
                            fontSize: 24, fontWeight: FontWeight.bold)),
                    options: CarouselOptions(
                        scrollDirection: Axis.vertical,
                        viewportFraction: 1,
                        enableInfiniteScroll: true,
                        onPageChanged: (nextIndex, reason) {
                          setState(() {
                            _curIndex = nextIndex;
                            _timd[nextIndex] =
                                "${_date.minute > 9 ? "" : "0"}${_date.minute}";
                          });
                        },
                        aspectRatio: 1),
                    carouselController: _carouselController,
                  )),
            ],
          ),
          Container(
              padding: const EdgeInsets.all(15),
              child: Text(
                "${_date.day} ${monthToString(_date.month)} ${_date.year}",
              )),
        ],
      ),
    );
  }
}
