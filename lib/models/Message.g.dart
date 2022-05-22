// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Message.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class MessageAdapter extends TypeAdapter<Message> {
  @override
  final int typeId = 1;

  @override
  Message read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Message(
      id: fields[0] as int,
      fromUser: fields[2] as bool,
      dateTime: fields[3] as DateTime,
      type: fields[4] as String,
    )
      ..text = fields[1] as String?
      ..description = fields[5] as String?
      ..prevention = fields[6] as String?
      ..treatments = fields[7] as String?
      ..title = fields[8] as String?
      ..probability = fields[9] as int?
      ..publications = fields[10] as String?;
  }

  @override
  void write(BinaryWriter writer, Message obj) {
    writer
      ..writeByte(11)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.text)
      ..writeByte(2)
      ..write(obj.fromUser)
      ..writeByte(3)
      ..write(obj.dateTime)
      ..writeByte(4)
      ..write(obj.type)
      ..writeByte(5)
      ..write(obj.description)
      ..writeByte(6)
      ..write(obj.prevention)
      ..writeByte(7)
      ..write(obj.treatments)
      ..writeByte(8)
      ..write(obj.title)
      ..writeByte(9)
      ..write(obj.probability)
      ..writeByte(10)
      ..write(obj.publications);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MessageAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
