import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:nutrifit/Hive/Meals/user_meals.dart';
import 'Hive/Box/boxes.dart';
import 'Hive/UserNutrition/user_nutrition.dart';
import 'routes/app_router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(UserNutritionAdapter());
  Hive.registerAdapter(AddMealBoxAdapter());  // Register AddMealBox adapter
  nutritionBox = await Hive.openBox<UserNutrition>('userNutrition');
  mealBox = await Hive.openBox<AddMealBox>('addmealBox');

  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerConfig: AppRouter.router,
    );
  }
}
