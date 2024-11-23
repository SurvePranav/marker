// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hive_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class MyHiveModelAdapter extends TypeAdapter<MyHiveModel> {
  @override
  final int typeId = 0;

  @override
  MyHiveModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return MyHiveModel(
      date: fields[0] as DateTime,
      values: (fields[1] as List).cast<bool>(),
    );
  }

  @override
  void write(BinaryWriter writer, MyHiveModel obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.date)
      ..writeByte(1)
      ..write(obj.values);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MyHiveModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
