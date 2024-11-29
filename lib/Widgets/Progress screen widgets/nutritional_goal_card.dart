import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../Hive/UserNutrition/user_nutrition.dart';

class NutritionGoalCard extends StatelessWidget {
  final UserNutrition user;
  final double totalKcalToday;
  final double totalProteinToday;

  const NutritionGoalCard({
    required this.user,
    required this.totalKcalToday,
    required this.totalProteinToday,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "${user.name}'s Nutrition Goal",
              style: GoogleFonts.inter(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 12),
            Table(
              columnWidths: const {
                0: FlexColumnWidth(2),
                1: FlexColumnWidth(2),
              },
              children: [
                TableRow(
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                  ),
                  children: [
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'Calories (kcal)',
                          style: GoogleFonts.inter(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                        ),
                      ),
                    ),
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'Protein (g)',
                          style: GoogleFonts.inter(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                TableRow(
                  children: [
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          '${user.kcal}',
                          style: GoogleFonts.inter(
                            fontSize: 20,
                            color: Colors.orange,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          '${user.protein}',
                          style: GoogleFonts.inter(
                            fontSize: 20,
                            color: Colors.green,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 5.0),
            Text(
              'Total kcal consumed Today: $totalKcalToday',
              style: GoogleFonts.inter(
                fontSize: 16,
                color: Colors.orange,
              ),
            ),
            Text(
              'Total Protein consumed Today: $totalProteinToday g',
              style: GoogleFonts.inter(
                fontSize: 16,
                color: Colors.green,
              ),
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
