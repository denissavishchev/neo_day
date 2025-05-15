import 'package:hive/hive.dart';
import 'habit_history_model.dart';
import 'habits_model.dart';

class Boxes {
  static Box<HabitsModel> addHabitToBase() =>
      Hive.box<HabitsModel>('habit');
  static Box<HabitHistoryModel> addHabitHistoryToBase() =>
      Hive.box<HabitHistoryModel>('habitHistory');
}