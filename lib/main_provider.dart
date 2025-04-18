import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import 'constants.dart';
import 'models/boxes.dart';
import 'models/habits_model.dart';

class MainProvider extends ChangeNotifier {

  final habitTextController = TextEditingController();

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

  void switchDay(context) async {
    isDay = !isDay;
    notifyListeners();
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

}