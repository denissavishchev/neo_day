// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'day_history_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class DayHistoryModelAdapter extends TypeAdapter<DayHistoryModel> {
  @override
  final int typeId = 47;

  @override
  DayHistoryModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return DayHistoryModel()
      ..startTime = fields[0] as String
      ..endTime = fields[1] as String
      ..target = fields[2] as bool
      ..tasks = fields[3] as int
      ..task = fields[4] as int
      ..targetName = fields[5] as String
      ..sleepDuration = fields[6] as String;
  }

  @override
  void write(BinaryWriter writer, DayHistoryModel obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.startTime)
      ..writeByte(1)
      ..write(obj.endTime)
      ..writeByte(2)
      ..write(obj.target)
      ..writeByte(3)
      ..write(obj.tasks)
      ..writeByte(4)
      ..write(obj.task)
      ..writeByte(5)
      ..write(obj.targetName)
      ..writeByte(6)
      ..write(obj.sleepDuration);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DayHistoryModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
