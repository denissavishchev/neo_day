import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:neo_day/models/day_history_model.dart';
import 'package:neo_day/models/start_tasks_model.dart';
import 'package:neo_day/widgets/button_widget.dart';
import 'package:neo_day/widgets/languages/language.dart';
import 'package:neo_day/widgets/night_widgets/rating_picker_widget.dart';
import 'constants.dart';
import 'models/boxes.dart';
import 'models/habit_history_model.dart';
import 'models/habits_model.dart';
import 'dart:math';
import 'models/start_task_history_model.dart';

class MainProvider extends ChangeNotifier {

  final habitTextController = TextEditingController();
  final todayTargetTextController = TextEditingController();
  final notesTextControllerOne = TextEditingController();
  final notesTextControllerTwo = TextEditingController();
  final notesTextControllerThree = TextEditingController();
  final notesPageController = PageController();
  final onboardingPageController = PageController(viewportFraction: 0.9);
  final GlobalKey<ScaffoldState> notesKey = GlobalKey<ScaffoldState>();

  Box box = Hive.box('day');

  bool isDay = true;
  bool isDayOnboarding = false;
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
  int totalTasks = 0;
  int doneTasks = 0;
  int selectedStars = 0;
  int selectedNote = 0;
  int dayTaskCount = 0;
  String sleepDuration = '';
  int randomNumber = 0;
  bool isRatingWidget = true;

  List<StartTasksModel> startTasks = [
    StartTasksModel(top: 'startEnergyTop', title: 'startEnergyTitle', description: 'startEnergyDescription'),
    StartTasksModel(top: 'startEmpathyTop', title: 'startEmpathyTitle', description: 'startEmpathyDescription'),
    StartTasksModel(top: 'startArtTop', title: 'startArtTitle', description: 'startArtDescription'),
  ];

  void initDay(){
    if(box.get('startTime') == null){
      isDay = false;
    }else{
      startTime = DateFormat('HH:mm').format(DateTime.parse(box.get('startTime').toString()));
      endTime = box.get('endTime') == null
          ? ''
          : DateFormat('HH:mm').format(DateTime.parse(box.get('endTime').toString()));
      previousDayDuration = box.get('previousDayDuration').toString();
      isDay = box.get('day') ?? false;
      totalTasks = box.get('totalTasks') ?? 0;
      doneTasks = box.get('doneTasks') ?? 0;
      dayTaskCount = box.get('dayTaskCount') ?? 0;
      sleepDuration = box.get('sleepDuration') ?? '';
      selectedStars = box.get('selectedStars') ?? 0;
      randomNumber = box.get('randomNumber') ?? 0;
    }
  }

  void switchDay(context) async {
    isDay = !isDay;
    if(isDay){
      await box.put('day', true);
      await box.put('startTime', DateTime.now().toString());
      startTime = DateFormat('HH:mm').format(DateTime.parse(box.get('startTime').toString()));
      if(box.get('endTime') != null){
        await box.put('sleepDuration',
            formatDuration(DateTime.parse(box.get('startTime')).difference(DateTime.parse(box.get('endTime')))));
      }
      sleepDuration = box.get('sleepDuration') ?? '';
      await box.put('motivationText', 'quote');
    }else{
      isRatingWidget = false;
      if(dayTaskCount < 29){
        dayTaskCount++;
      }else{
        addStartTaskHistoryToBase();
        dayTaskCount = 0;
        box.put('startTasksCount', '');
        box.put('startTasks', '');
      }
      await box.put('dayTaskCount', dayTaskCount);
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
      await box.put('doneTasks', doneTasks);
      await box.put('totalTasks', totalTasks);
      getRandomNumber();
      selectedStars = 0;
      Future.delayed(Duration(milliseconds: 800), () async {
        await showToAddDayRating(context);
      });
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

  Future addDayHistoryToBase() async {
    final day = DayHistoryModel()
      ..startTime = box.get('startTime') ?? ''
      ..endTime = DateTime.now().toString()
      ..target = box.get('isTodayTarget') ?? false
      ..task = doneTasks
      ..tasks = totalTasks
      ..targetName = box.get('todayTarget') ?? ''
      ..sleepDuration = box.get('sleepDuration') ?? ''
      ..selectedStars = box.get('selectedStars').toString();
    final dayBox = Boxes.addDayHistoryToBase();
    dayBox.add(day);
    await box.put('selectedStars', selectedStars);
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

  Future addHabitHistoryToBase(Box<HabitsModel> boxDelete, int index, List<HabitsModel> habits) async {
    final habitHistory = HabitHistoryModel()
      ..name = habits[index].name
      ..startTime = habits[index].start
      ..endTime = (DateTime.parse(habits[index].start).add(Duration(days: habits[index].days))).toString()
      ..totalDays = habits[index].days.toString()
      ..goodDays = habits[index].progress.split('').map(int.parse).toList().where((e) => e == 1).length.toString()
      ..badDays = habits[index].progress.split('').map(int.parse).toList().where((e) => e == 0).length.toString()
      ..list = habits[index].progress;
    final box = Boxes.addHabitHistoryToBase();
    box.add(habitHistory);
    deleteHabit(boxDelete, index);
  }

  Future addStartTaskHistoryToBase() async {
    final startTaskHistory = StartTaskHistoryModel()
      ..name = box.get('startTask')
      ..history = box.get('startTasksCount');
    final startTaskBox = Boxes.addStartTaskHistoryToBase();
    startTaskBox.add(startTaskHistory);
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
                      color: kBlack,
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        TextField(
                          controller: habitTextController,
                          style: const TextStyle(color: kWhite),
                          decoration: textFieldDecoration,
                          cursorColor: kWhite,
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: Slider(
                                divisions: 17,
                                activeColor: kTangerine,
                                inactiveColor: kWhite,
                                thumbColor: kTangerine,
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
                        ButtonWidget(
                            text: 'add',
                            onTap: (){
                              addHabitToBase();
                              Navigator.of(context).pop();
                            }
                        )
                      ],
                    )
                );
              }
          );
        });
  }

  Future<void>showToAddDayRating(context) async {
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
                      color: kBlack,
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text('rateThisDay', style: kTextStyle,),
                        RatingPickerWidget(),
                        ButtonWidget(
                          text: 'rate',
                          onTap: () {
                              addDayHistoryToBase();
                              isRatingWidget = true;
                              notifyListeners();
                              Navigator.of(context).pop();
                          },),
                      ],
                    )
                );
              }
          );
        });
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

  void selectStars(int stars) async{
    if (stars == 0 && selectedStars == stars + 1){
      selectedStars = 0;
    }else{
      selectedStars = stars + 1;
    }
    notifyListeners();
  }

  void switchDayOnboarding(context) async {
    isDayOnboarding = !isDayOnboarding;
    notifyListeners();
  }

  void getRandomNumber() async{
    Random random = Random();
    randomNumber = random.nextInt(5);
    await box.put('randomNumber', randomNumber);
  }


}