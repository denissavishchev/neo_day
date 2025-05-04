import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:neo_day/widgets/languages/language.dart';
import 'constants.dart';
import 'models/boxes.dart';
import 'models/habits_model.dart';
import 'dart:math';

class MainProvider extends ChangeNotifier {

  final habitTextController = TextEditingController();
  final todayTargetTextController = TextEditingController();
  final notesTextControllerOne = TextEditingController();
  final notesTextControllerTwo = TextEditingController();
  final notesTextControllerThree = TextEditingController();
  final notesPageController = PageController();
  final GlobalKey<ScaffoldState> notesKey = GlobalKey<ScaffoldState>();

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
  String motivationText = 'quote';
  int totalTasks = 0;
  int doneTasks = 0;
  int selectedStars = 0;
  int selectedNote = 0;
  String todayTarget = '';
  bool isTodayTarget = false;

  List puzzleColors = List.filled(30, 0);
  bool isPuzzleTaskVisible = false;
  int selectedPuzzle = 0;
  bool isPuzzleToday = false;
  String puzzlesParts = '';

  int dayTaskCount = 0;

  void openPuzzleTask(int index){
    if(puzzleColors[index] == 0 && !isPuzzleToday){
      isPuzzleTaskVisible = true;
      puzzleColors[index] = 1;
      selectedPuzzle = index;
      isPuzzleToday = true;
      puzzlesParts = puzzleColors.join(',');
      box.put('isPuzzleToday', isPuzzleToday);
      box.put('puzzlesParts', puzzlesParts);
      notifyListeners();
    }
  }

  void hidePuzzleTask(){
    isPuzzleTaskVisible = false;
    notifyListeners();
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
      isDay = box.get('day') ?? false;
      isPuzzleToday = box.get('isPuzzleToday') ?? false;
      puzzleColors = box.get('puzzlesParts') == null
          ? List<int>.filled(30, 0)
          : (box.get('puzzlesParts')).split(',').map(int.parse).toList();
      motivationText = box.get('motivationText') ?? 'quote';
      isTodayTarget = box.get('isTodayTarget') ?? false;
      todayTarget = box.get('todayTarget') ?? '';
      totalTasks = box.get('totalTasks') ?? 0;
      doneTasks = box.get('doneTasks') ?? 0;
      dayTaskCount = box.get('dayTaskCount') ?? 0;
    }
  }

  void switchDay(context) async {
    isDay = !isDay;
    if(isDay){
      await box.put('day', true);
      await box.put('startTime', DateTime.now().toString());
      startTime = DateFormat('HH:mm').format(DateTime.parse(box.get('startTime').toString()));
      motivationText = 'quote';
      await box.put('motivationText', 'quote');
      isTodayTarget = false;
      todayTarget = '';
      isTodayTarget = false;
      await box.put('isTodayTarget', false);
      Future.delayed(Duration(seconds: 1), () async {
        await showToAddTodayTarget(context);
      });
    }else{
      if(dayTaskCount < 30){
        dayTaskCount++;
      }else{
        dayTaskCount = 0;
      }
      await box.put('dayTaskCount', dayTaskCount);
      isPuzzleToday = false;
      isPuzzleTaskVisible = false;
      await box.put('isPuzzleToday', isPuzzleToday);
      await box.put('endTime', DateTime.now().toString());
      endTime = DateFormat('HH:mm').format(DateTime.parse(box.get('endTime').toString()));
      await box.put('previousDayDuration', dayDuration);
      previousDayDuration = box.get('previousDayDuration').toString();
      await box.put('doneTasks', doneTasks);
      await box.put('totalTasks', totalTasks);
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
      totalTasks = 0;
      doneTasks = 0;
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
        String tasks = progressHabitBox[i].length == daysHabitBox[i]
            ? progressHabitBox[i]
            : progressHabitBox[i] + (statusHabitBox[i] ? '1' : '0');
        totalTasks = Hive.box<HabitsModel>('habit').values.length;
        if(tasks.substring(tasks.length - 1) == '1') {
          doneTasks++;
        }
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

  Future<void>showToAddHabit(context) async {
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

  Future<void>showToAddTodayTarget(context) async {
    Size size = MediaQuery.sizeOf(context);
    return showModalBottomSheet(
        context: context,
        isDismissible: false,
        backgroundColor: Colors.transparent,
        isScrollControlled: true,
        builder: (context) {
          return StatefulBuilder(
              builder: (context, setState){
                return Container(
                    height: size.height * 0.2,
                    width: size.width,
                    padding: const EdgeInsets.symmetric(horizontal: 18),
                    margin: const EdgeInsets.only(bottom: 450),
                    decoration: const BoxDecoration(
                      color: kIndigo,
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text('addTodayTarget'.tr()),
                        TextField(
                          controller: todayTargetTextController,
                          style: const TextStyle(color: kWhite),
                          decoration: textFieldDecoration,
                        ),
                        ElevatedButton(
                            onPressed: (){
                              box.put('todayTarget', todayTargetTextController.text);
                              todayTarget = todayTargetTextController.text;
                              todayTargetTextController.clear();
                              isTodayTarget = false;
                              notifyListeners();
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
    motivationText = '$text${Random().nextInt(30)}';
    box.put('motivationText', motivationText);
    notifyListeners();
  }

  void hideMotivation(){
    motivationText = 'quote';
    box.put('motivationText', 'quote');
    notifyListeners();
  }

  void setLanguage(Language value, context){
    selectedLanguage = value.toString();
    notifyListeners();
  }

  Future saveNote(String note, int index) async{
    switch(index){
      case 0:
        await box.put('note0', note);
        break;
      case 1:
        await box.put('note1', note);
        break;
      case 2:
        await box.put('note2', note);
        break;
    }
    notifyListeners();
  }

  Future readNote() async{
    selectedNote = 0;
    notesTextControllerOne.text = await box.get('note0') ?? '';
    notesTextControllerTwo.text = await box.get('note1') ?? '';
    notesTextControllerThree.text = await box.get('note2') ?? '';
    notesKey.currentState?.openDrawer();
  }
  
  void switchNote(int page){
    selectedNote = page;
    notesPageController.jumpToPage(page);
    FocusManager.instance.primaryFocus?.unfocus();
    notifyListeners();
  }

  void selectStars(int stars){
    if (stars == 0 && selectedStars == stars + 1){
      selectedStars = 0;
    }else{
      selectedStars = stars + 1;
    }
    notifyListeners();
  }

  void switchIsTodayTarget(){
    isTodayTarget = !isTodayTarget;
    box.put('isTodayTarget', isTodayTarget);
    notifyListeners();
  }

}