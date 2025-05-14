import 'package:hive/hive.dart';
part 'start_task_model.g.dart';

@HiveType(typeId: 13)
class StartTaskModel extends HiveObject{
  @HiveField(0)
  late String name;
  @HiveField(1)
  late bool status;
  @HiveField(2)
  late String start;
  @HiveField(3)
  late int days;
  @HiveField(4)
  late String progress;
}