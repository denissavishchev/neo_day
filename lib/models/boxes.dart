import 'package:hive/hive.dart';
import 'habits_model.dart';

class Boxes {
  static Box<HabitsModel> addHabitToBase() =>
      Hive.box<HabitsModel>('habit');
}