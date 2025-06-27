import 'package:hive/hive.dart';

part 'user_meals.g.dart'; 
@HiveType(typeId: 1) 
class AddMealBox extends HiveObject {
  @HiveField(0)
  String mealname;

  @HiveField(1)
  int kcal;

  @HiveField(2)
  double protein;

  @HiveField(3)
  DateTime timestamp; 
  AddMealBox({
    required this.mealname,
    required this.kcal,
    required this.protein,
    required this.timestamp, 
  });
}
