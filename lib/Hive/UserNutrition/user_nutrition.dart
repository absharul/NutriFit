import 'package:hive/hive.dart';

part 'user_nutrition.g.dart'; // For generated code


@HiveType(typeId: 0)
class UserNutrition extends HiveObject {
  @HiveField(0)
  String id; // Unique identifier for the user

  @HiveField(1)
  String name;

  @HiveField(2)
  int kcal;

  @HiveField(3)
  double protein;

  UserNutrition({
    required this.id,
    required this.name,
    required this.kcal,
    required this.protein,
  });
}

