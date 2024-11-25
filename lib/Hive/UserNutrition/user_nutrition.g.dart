// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_nutrition.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class UserNutritionAdapter extends TypeAdapter<UserNutrition> {
  @override
  final int typeId = 0;

  @override
  UserNutrition read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return UserNutrition(
      id: fields[0] as String,
      name: fields[1] as String,
      kcal: fields[2] as int,
      protein: fields[3] as double,
    );
  }

  @override
  void write(BinaryWriter writer, UserNutrition obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.kcal)
      ..writeByte(3)
      ..write(obj.protein);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserNutritionAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
