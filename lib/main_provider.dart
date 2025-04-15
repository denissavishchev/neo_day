import 'package:flutter/material.dart';

class MainProvider extends ChangeNotifier {

  bool isDay = true;
  String endTime = '';
  String previousDayDuration = '';
  String startTime = '';
  String dayDuration = '';

  void switchDay(context) async {
    isDay = !isDay;
    notifyListeners();
  }
}