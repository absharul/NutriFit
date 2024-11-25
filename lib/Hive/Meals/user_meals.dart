import 'package:hive/hive.dart';

part 'user_meals.g.dart'; // For generated code

@HiveType(typeId: 0)
class AddMealBox extends HiveObject {
  @HiveField(0)
  String mealname;

  @HiveField(1)
  int kcal;

  @HiveField(2)
  double protein;

  AddMealBox({required this.mealname, required this.kcal, required this.protein});
}