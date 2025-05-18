import 'package:hive/hive.dart';
part 'start_task_history_model.g.dart';

@HiveType(typeId: 33)
class StartTaskHistoryModel extends HiveObject{
  @HiveField(0)
  late String name;
  @HiveField(1)
  late String history;
}