// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'start_task_history_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class StartTaskHistoryModelAdapter extends TypeAdapter<StartTaskHistoryModel> {
  @override
  final int typeId = 33;

  @override
  StartTaskHistoryModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return StartTaskHistoryModel()
      ..name = fields[0] as String
      ..history = fields[1] as String;
  }

  @override
  void write(BinaryWriter writer, StartTaskHistoryModel obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.history);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is StartTaskHistoryModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
