import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:math';
import '../../constants.dart';


class TimerWidget extends StatefulWidget {
  const TimerWidget({super.key});

  @override
  State<TimerWidget> createState() => _TimerWidgetState();
}

class _TimerWidgetState extends State<TimerWidget> {
  List<bool> activeDots = List.filled(60, false);
  int currentIndex = 0;
  Timer? timer;
  bool isRunning = false;

  void startTimer() {
    timer?.cancel();
    setState(() {
      activeDots = List.filled(60, false);
      currentIndex = 0;
      isRunning = true;
    });

    timer = Timer.periodic(Duration(seconds: 1), (t) {
      if (currentIndex >= 60) {
        t.cancel();
        setState(() {
          isRunning = false;
        });
        print('done');
        return;
      }
      setState(() {
        activeDots[currentIndex] = true;
        currentIndex++;
      });
    });
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  List<Widget> buildDots(double radius) {
    List<Widget> dots = [];
    for (int i = 0; i < 60; i++) {
      final angle = (2 * pi * (i / 60)) - pi / 2;
      final x = radius * cos(angle);
      final y = radius * sin(angle);

      dots.add(Positioned(
        left: radius + x,
        top: radius + y,
        child: Container(
          width: 8,
          height: 8,
          decoration: BoxDecoration(
            color: activeDots[i] ? kTangerine : kWhite,
            shape: BoxShape.circle,
          ),
        ),
      ));
    }
    return dots;
  }

  @override
  Widget build(BuildContext context) {
    double radius = 90;
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
              width: 200,
              height: 200,
              child: Stack(children: buildDots(radius))),
          SizedBox(height: 10),
          GestureDetector(
            onTap: isRunning ? null : startTimer,
            child: Container(
              width: 100,
              height: 40,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                  border: Border.all(color: kWhite, width: 2)
              ),
              child: Center(child: Text('start', style: kTextStyle,)),
            ),
          )
        ],
      ),
    );
  }
}
