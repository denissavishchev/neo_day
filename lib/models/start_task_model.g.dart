// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'start_task_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class StartTaskModelAdapter extends TypeAdapter<StartTaskModel> {
  @override
  final int typeId = 13;

  @override
  StartTaskModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return StartTaskModel()
      ..name = fields[0] as String
      ..status = fields[1] as bool
      ..start = fields[2] as String
      ..days = fields[3] as int
      ..progress = fields[4] as String;
  }

  @override
  void write(BinaryWriter writer, StartTaskModel obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.status)
      ..writeByte(2)
      ..write(obj.start)
      ..writeByte(3)
      ..write(obj.days)
      ..writeByte(4)
      ..write(obj.progress);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is StartTaskModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
