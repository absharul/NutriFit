import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MealSection extends StatelessWidget {
  final List<Map<String, dynamic>> meals = [
    {"meal": "Chicken Curry", "protein": 19.0, "calories": 165},
    {"meal": "Tandoori Chicken", "protein": 30.0, "calories": 150},
    {"meal": "Fish Curry", "protein": 20.0, "calories": 120},
    {"meal": "Egg Bhurji (Scrambled)", "protein": 13.0, "calories": 150},
    {"meal": "Chicken Biryani", "protein": 18.0, "calories": 200},
    {"meal": "Grilled Fish", "protein": 25.0, "calories": 180},
    {"meal": "Chole (Chickpea Curry)", "protein": 9.0, "calories": 160},
    {"meal": "Dal Tadka", "protein": 8.0, "calories": 120},
    {"meal": "Palak Paneer", "protein": 15.0, "calories": 200},
    {"meal": "Methi Thepla", "protein": 6.0, "calories": 120},
    {"meal": "Prawn Masala", "protein": 24.0, "calories": 150},
    {"meal": "Chicken Korma", "protein": 21.0, "calories": 250},
    {"meal": "Aloo Gobi", "protein": 2.0, "calories": 80},
    {"meal": "Egg Curry", "protein": 12.0, "calories": 170},
    {"meal": "Macher Jhol (Bengali Fish Curry)", "protein": 22.0, "calories": 130},
    {"meal": "Mutton Rogan Josh", "protein": 25.0, "calories": 280},
    {"meal": "Rajma (Kidney Bean Curry)", "protein": 8.0, "calories": 127},
    {"meal": "Paneer Butter Masala", "protein": 16.0, "calories": 290},
    {"meal": "Fish Fry", "protein": 23.0, "calories": 200},
    {"meal": "Chicken Pakora", "protein": 22.0, "calories": 180},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.only(bottom: 8.0),
                child: Text(
                  'Nutritional Breakdown of Meals',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
              Table(
                border: TableBorder.all(
                  color: Colors.black.withOpacity(0.5),
                  width: 1,
                ),
                columnWidths: const {
                  0: FlexColumnWidth(3),
                  1: FlexColumnWidth(1),
                  2: FlexColumnWidth(1),
                },
                children: [
                  const TableRow(
                    decoration: BoxDecoration(
                      color: Colors.black,
                    ),
                    children: [
                      TableCell(
                        child: Padding(
                          padding: EdgeInsets.all(12.0),
                          child: Text(
                            'Meal Name \n Per(100g)',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.yellowAccent,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ),
                      TableCell(
                        child: Padding(
                          padding: EdgeInsets.all(12.0),
                          child: Text(
                            'Protein (g)',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.yellowAccent,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ),
                      TableCell(
                        child: Padding(
                          padding: EdgeInsets.all(12.0),
                          child: Text(
                            'Calories (kcal)',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.yellowAccent,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  for (var i = 0; i < meals.length; i++)
                    TableRow(
                      decoration: BoxDecoration(
                        color: i % 2 == 0 ? Colors.grey[100] : Colors.white,
                      ),
                      children: [
                        TableCell(
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Text(
                              meals[i]['meal'],
                              style: const TextStyle(fontSize: 16),
                            ),
                          ),
                        ),
                        TableCell(
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Text(
                              meals[i]['protein'].toString(),
                              style: const TextStyle(fontSize: 16),
                            ),
                          ),
                        ),
                        TableCell(
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Text(
                              meals[i]['calories'].toString(),
                              style: const TextStyle(fontSize: 16),
                            ),
                          ),
                        ),
                      ],
                    ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
