import 'package:hive/hive.dart';
import 'package:neo_day/models/start_task_history_model.dart';
import 'day_history_model.dart';
import 'habit_history_model.dart';
import 'habits_model.dart';

class Boxes {
  static Box<HabitsModel> addHabitToBase() =>
      Hive.box<HabitsModel>('habit');
  static Box<HabitHistoryModel> addHabitHistoryToBase() =>
      Hive.box<HabitHistoryModel>('habitHistory');
  static Box<StartTaskHistoryModel> addStartTaskHistoryToBase() =>
      Hive.box<StartTaskHistoryModel>('startTaskHistory');
  static Box<DayHistoryModel> addDayHistoryToBase() =>
      Hive.box<DayHistoryModel>('dayHistory');
}