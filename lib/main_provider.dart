import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:neo_day/widgets/languages/language.dart';
import 'constants.dart';
import 'models/boxes.dart';
import 'models/habits_model.dart';
import 'package:intl/intl.dart';
import 'dart:math';

class MainProvider extends ChangeNotifier {

  final habitTextController = TextEditingController();

  Box box = Hive.box('day');

  bool isDay = true;
  bool isAddTaskVisible = false;
  String endTime = '';
  String previousDayDuration = '';
  String startTime = '';
  String dayDuration = '';
  double habitDaySlider = 10;
  int convertedLength = 0;
  int zeros = 0;
  int ones = 0;
  String selectedLanguage = 'English - UK';
  int motivationIndex = 0;
  String motivationText = 'quote';

  void switchDay(context) async {
    isDay = !isDay;
    if(isDay){
      await box.put('day', true);
      await box.put('startTime', DateTime.now().toString());
      startTime = DateFormat('HH:mm').format(DateTime.parse(box.get('startTime').toString()));
    }else{
      motivationIndex = 0;
      await box.put('endTime', DateTime.now().toString());
      endTime = DateFormat('HH:mm').format(DateTime.parse(box.get('endTime').toString()));
      await box.put('previousDayDuration', dayDuration);
      previousDayDuration = box.get('previousDayDuration').toString();
      await box.put('day', false);
      final nameHabitBox = [];
      final startHabitBox = [];
      final daysHabitBox = [];
      final progressHabitBox = [];
      final statusHabitBox = [];
      for(var h in Hive.box<HabitsModel>('habit').values){
        nameHabitBox.add(h.name);
        startHabitBox.add(h.start);
        daysHabitBox.add(h.days);
        progressHabitBox.add(h.progress);
        statusHabitBox.add(h.status);
      }
      for(var i = 0; i < nameHabitBox.length; i++){
        Hive.box<HabitsModel>('habit').putAt(i, HabitsModel()
          ..name = nameHabitBox[i]
          ..status = false
          ..start = startHabitBox[i]
          ..days = daysHabitBox[i]
          ..progress = progressHabitBox[i].length == daysHabitBox[i]
              ? progressHabitBox[i]
              : progressHabitBox[i] + (statusHabitBox[i] ? '1' : '0')
        );
      }
    }
    notifyListeners();
  }

  void changeHabitDaySlider(double v){
    habitDaySlider = v;
    notifyListeners();
  }

  Future addHabitToBase() async {
    final habit = HabitsModel()
      ..name = habitTextController.text
      ..status = false
      ..days = habitDaySlider.toInt()
      ..progress = ''
      ..start = DateTime.now().toString();
    final box = Boxes.addHabitToBase();
    box.add(habit);
    habitTextController.clear();
    habitDaySlider = 10;
    notifyListeners();
  }

  void switchHabit(Box<HabitsModel> box, int index, List<HabitsModel> habits) async{
    box.putAt(index, HabitsModel()
      ..name = habits[index].name
      ..status = !habits[index].status
      ..days = habits[index].days
      ..progress = habits[index].progress
      ..start = habits[index].start
    );
    notifyListeners();
  }

  Future<void> deleteHabit(Box<HabitsModel> box, int index)async{
    box.deleteAt(index);
  }

  void updateTimer(){
    final duration = box.get('startTime') == null
        ? DateTime.now().difference(DateTime.now())
        : DateTime.now().difference(DateTime.parse(box.get('startTime').toString()));
    dayDuration = formatDuration(duration);
  }

  String formatDuration(Duration duration) {
    String twoDigits(int n) {
      if (n >= 10) return "$n";
      return "0$n";
    }
    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    return "${twoDigits(duration.inHours)}:$twoDigitMinutes:$twoDigitSeconds";
  }

  void initDay(){
    if(box.get('startTime') == null){
      isDay = false;
    }else{
      startTime = DateFormat('HH:mm').format(DateTime.parse(box.get('startTime').toString()));
      endTime = box.get('endTime') == null
          ? ''
          :DateFormat('HH:mm').format(DateTime.parse(box.get('endTime').toString()));
      previousDayDuration = box.get('previousDayDuration').toString();
      isDay = box.get('day');
    }
  }

  Future<void>showToAddHabit(context)async {
    Size size = MediaQuery.sizeOf(context);
    return showModalBottomSheet(
        context: context,
        backgroundColor: Colors.transparent,
        isScrollControlled: true,
        builder: (context) {
          return StatefulBuilder(
              builder: (context, setState){
                return Container(
                    height: size.height * 0.3,
                    width: size.width,
                    padding: const EdgeInsets.symmetric(horizontal: 18),
                    margin: const EdgeInsets.only(bottom: 250),
                    decoration: const BoxDecoration(
                      color: kIndigo,
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        TextField(
                          controller: habitTextController,
                          style: const TextStyle(color: kWhite),
                          decoration: textFieldDecoration,
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: Slider(
                                divisions: 17,
                                activeColor: kGreen,
                                inactiveColor: kWhite,
                                thumbColor: kGreen,
                                value: habitDaySlider,
                                onChanged: (v) => setState((){
                                  changeHabitDaySlider(v);
                                }),
                                min: 10,
                                max: 180,
                              ),
                            ),
                            Text(habitDaySlider.toStringAsFixed(0), style: kTextStyle,)
                          ],
                        ),
                        ElevatedButton(
                            onPressed: (){
                              addHabitToBase();
                              Navigator.of(context).pop();
                            },
                            child: Text('Add')),
                      ],
                    )
                );
              }
          );
        });
  }

  void showMotivation(String text){
    motivationIndex = 1;
    motivationText = '$text${Random().nextInt(30)}';
    notifyListeners();
  }

  void hideMotivation(){
    motivationIndex = 0;
    notifyListeners();
  }

  void setLanguage(Language value, context){
    selectedLanguage = value.toString();
    notifyListeners();
  }


}