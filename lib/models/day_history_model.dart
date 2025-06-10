import 'package:hive/hive.dart';
part 'day_history_model.g.dart';

@HiveType(typeId: 47)
class DayHistoryModel extends HiveObject{
  @HiveField(0)
  late String startTime;
  @HiveField(1)
  late String endTime;
  @HiveField(2)
  late bool target;
  @HiveField(3)
  late int tasks;
  @HiveField(4)
  late int task;
  @HiveField(5)
  late String targetName;
  @HiveField(6)
  late String sleepDuration;
  @HiveField(7)
  late String selectedStars;
}