import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../Services/Calucations/calculation_helper.dart';

final calorieProteinProvider = Provider.autoDispose.family<Map<String, List<int>>, Map<String, dynamic>>(
      (ref, params) {

    final age = params['age'] as int;
    final activityLevel = params['activityLevel'] as ActivityLevel;
    final gender = params['gender'] as String;
    final height = params['height'] as int;
    final weight = params['weight'] as int;

    return calculateCaloriesAndProtein(
      age: age,
      activityLevel: activityLevel,
      gender: gender,
      height: height,
      weight: weight,
    );
  },
);

