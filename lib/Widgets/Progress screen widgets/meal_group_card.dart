import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../../Hive/Meals/user_meals.dart';

class MealGroupCard extends StatelessWidget {
  final String date;
  final String dailyMessage;
  final double dailyKcal;
  final double dailyProtein;
  final List<AddMealBox> meals;

  const MealGroupCard({
    Key? key,
    required this.date,
    required this.dailyMessage,
    required this.dailyKcal,
    required this.dailyProtein,
    required this.meals,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: ExpansionTile(
        subtitle: Text(
          date,
          style: GoogleFonts.inter(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        title: Text(
          dailyMessage,
          style: GoogleFonts.inter(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: _getMessageColor(dailyMessage),
          ),
        ),
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Total Calories for $date: $dailyKcal',
                  style: GoogleFonts.inter(
                    fontSize: 16,
                    color: Colors.orange,
                  ),
                ),
                Text(
                  'Total Protein for $date: $dailyProtein g',
                  style: GoogleFonts.inter(
                    fontSize: 16,
                    color: Colors.green,
                  ),
                ),
              ],
            ),
          ),
          ...meals.map((meal) {
            final formattedDate = DateFormat.yMMMd().format(meal.timestamp);
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    meal.mealname ?? 'Meal',
                    style: GoogleFonts.inter(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  Text(
                    formattedDate,
                    style: GoogleFonts.inter(
                      fontSize: 12,
                      color: Colors.grey[600],
                    ),
                  ),
                  Text(
                    'Calories: ${meal.kcal}',
                    style: GoogleFonts.inter(
                      fontSize: 14,
                      color: Colors.orange,
                    ),
                  ),
                  Text(
                    'Protein: ${meal.protein}g',
                    style: GoogleFonts.inter(
                      fontSize: 14,
                      color: Colors.green,
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
        ],
      ),
    );
  }

  Color _getMessageColor(String message) {
    switch (message) {
      case "Goal Achieved!":
        return Colors.green;
      case "Failed":
        return Colors.red;
      case "Keep going":
        return Colors.black;
      default:
        return Colors.black;
    }
  }
}