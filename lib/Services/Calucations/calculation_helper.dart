//calculation_helper.dart

import 'package:flutter/material.dart';

// Enum to represent activity levels
enum ActivityLevel {
  Sedentary, // little or no exercise
  LightlyActive, // light exercise/sports 1-3 days/week
  ModeratelyActive, // moderate exercise/sports 3-5 days/week
  VeryActive, // hard exercise/sports 6-7 days/week
}

// Function to calculate calorie and protein range based on age, gender, height, weight, and activity level
Map<String, List<int>> calculateCaloriesAndProtein({
  required int age,
  required ActivityLevel activityLevel,
  required String gender,
  required int height, // Height in cm
  required int weight, // Weight in kg
}) {
  // Define the calorie and protein ranges
  Map<String, List<int>> calorieProteinRanges = {};

  // Calculate BMR (Basal Metabolic Rate) using the Harris-Benedict equation
  double bmr = 0;
  if (gender == 'Male') {
    bmr = 88.362 + (13.397 * weight) + (4.799 * height) - (5.677 * age);
  } else if (gender == 'Female') {
    bmr = 447.593 + (9.247 * weight) + (3.098 * height) - (4.330 * age);
  }

  // Determine the activity multiplier based on the activity level
  double activityMultiplier = 1.2; // Sedentary by default
  switch (activityLevel) {
    case ActivityLevel.LightlyActive:
      activityMultiplier = 1.375; // Lightly active
      break;
    case ActivityLevel.ModeratelyActive:
      activityMultiplier = 1.55; // Moderately active
      break;
    case ActivityLevel.VeryActive:
      activityMultiplier = 1.725; // Very active
      break;
    default:
      activityMultiplier = 1.2; // Sedentary
  }

  // Calculate total daily calorie needs
  int calorieIntake = (bmr * activityMultiplier).round();

  // Protein needs: 0.8g to 2.2g per kg of body weight, adjusted based on activity level
  double proteinFactor = 1.0; // Default protein factor for sedentary
  switch (activityLevel) {
    case ActivityLevel.LightlyActive:
      proteinFactor = 1.2; // Light activity
      break;
    case ActivityLevel.ModeratelyActive:
      proteinFactor = 1.4; // Moderate activity
      break;
    case ActivityLevel.VeryActive:
      proteinFactor = 1.6; // High activity
      break;
    default:
      proteinFactor = 1.0; // Sedentary
  }

  // Calculate protein needs in grams
  int proteinIntake = (weight * proteinFactor).round();

  // Store calorie and protein ranges in the map
  calorieProteinRanges['Calorie'] = [
    calorieIntake - 200,
    calorieIntake + 200
  ]; // 200 calorie range for flexibility
  calorieProteinRanges['Protein'] = [
    proteinIntake - 10,
    proteinIntake + 10
  ]; // 10g protein range for flexibility

  return calorieProteinRanges;
}
