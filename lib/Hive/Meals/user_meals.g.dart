// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_meals.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AddMealBoxAdapter extends TypeAdapter<AddMealBox> {
  @override
  final int typeId = 0;

  @override
  AddMealBox read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return AddMealBox(
      mealname: fields[0] as String,
      kcal: fields[1] as int,
      protein: fields[2] as double,
    );
  }

  @override
  void write(BinaryWriter writer, AddMealBox obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.mealname)
      ..writeByte(1)
      ..write(obj.kcal)
      ..writeByte(2)
      ..write(obj.protein);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AddMealBoxAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}