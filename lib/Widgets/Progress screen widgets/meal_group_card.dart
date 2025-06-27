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
    super.key,
    required this.date,
    required this.dailyMessage,
    required this.dailyKcal,
    required this.dailyProtein,
    required this.meals,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: ExpansionTile(
        title: Text(
          dailyMessage,
          style: GoogleFonts.inter(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: _getMessageColor(dailyMessage),
          ),
        ),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 4.0),
          child: Text(
            date,
            style: GoogleFonts.inter(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Colors.black54,
            ),
          ),
        ),
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildInfoRow(
                  label: 'Total Calories',
                  value: '$dailyKcal kcal',
                  icon: Icons.fastfood,
                  iconColor: Colors.orange,
                ),
                _buildInfoRow(
                  label: 'Total Protein',
                  value: '$dailyProtein g',
                  icon: Icons.fitness_center,
                  iconColor: Colors.green,
                ),
                const SizedBox(height: 8),
              ],
            ),
          ),
          ...meals.map((meal) {
            final formattedDate = DateFormat.jm().format(meal.timestamp);
            return Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    meal.mealname,
                    style: GoogleFonts.inter(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  Text(
                    formattedDate,
                    style: GoogleFonts.inter(
                      fontSize: 12,
                      color: Colors.grey[600],
                    ),
                  ),
                  const SizedBox(height: 4),
                  _buildInfoRow(
                    label: 'Calories',
                    value: '${meal.kcal} kcal',
                    icon: Icons.local_dining,
                    iconColor: Colors.orange,
                  ),
                  _buildInfoRow(
                    label: 'Protein',
                    value: '${meal.protein}g',
                    icon: Icons.fitness_center,
                    iconColor: Colors.green,
                  ),
                  const SizedBox(height: 12),
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
      case "Low Protein":
        return Colors.blue;
      case "Low kcal":
        return Colors.orange;
      case "Keep going":
        return Colors.black;
      default:
        return Colors.black;
    }
  }

  Widget _buildInfoRow(
      {required String label,
      required String value,
      required IconData icon,
      required Color iconColor}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        children: [
          Icon(icon, color: iconColor, size: 18),
          const SizedBox(width: 8),
          Text(
            '$label: $value',
            style: GoogleFonts.inter(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Colors.black87,
            ),
          ),
        ],
      ),
    );
  }
}
