// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'current_screen.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CurrentScreenAdapter extends TypeAdapter<CurrentScreen> {
  @override
  final int typeId = 2;

  @override
  CurrentScreen read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CurrentScreen()..name = fields[0] as String;
  }

  @override
  void write(BinaryWriter writer, CurrentScreen obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj.name);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CurrentScreenAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
