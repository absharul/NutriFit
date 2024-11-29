import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/adapters.dart';
import '../Hive/UserNutrition/user_nutrition.dart';
import '../Hive/Meals/user_meals.dart';
import 'package:intl/intl.dart';

import '../Widgets/Progress screen widgets/meal_group_card.dart';
import '../Widgets/Progress screen widgets/message_display.dart';
import '../Widgets/Progress screen widgets/nutritional_goal_card.dart';
import '../Widgets/Progress screen widgets/user_selection_dropdown.dart';

class ProgressScreen extends StatefulWidget {
  const ProgressScreen({super.key});

  @override
  State<ProgressScreen> createState() => _ProgressScreenState();
}


class _ProgressScreenState extends State<ProgressScreen> {
  late Box<UserNutrition> nutritionBox;
  Box<AddMealBox>? mealBox;
  UserNutrition? selectedUser;
  double totalKcalToday = 0;
  double totalProteinToday = 0;
  bool showMessage = false;
  String message = '';
  Color messageColor = Colors.transparent;

  @override
  void initState() {
    super.initState();
    nutritionBox = Hive.box<UserNutrition>('userNutrition');
  }

  void _onUserSelected(UserNutrition? user) async {
    setState(() {
      selectedUser = user;
      totalKcalToday = 0;
      totalProteinToday = 0;
      showMessage = false;
      message = '';
      messageColor = Colors.transparent;
    });

    if (user != null) {
      try {
        mealBox = await Hive.openBox<AddMealBox>(user.id);
        setState(() {
          totalKcalToday = mealBox?.values.fold(0, (sum, meal) {
            if (meal.timestamp.year == DateTime.now().year &&
                meal.timestamp.month == DateTime.now().month &&
                meal.timestamp.day == DateTime.now().day) {
              return sum! + meal.kcal;
            }
            return sum;
          }) ?? 0;

          totalProteinToday = mealBox?.values.fold(0, (sum, meal) {
            if (meal.timestamp.year == DateTime.now().year &&
                meal.timestamp.month == DateTime.now().month &&
                meal.timestamp.day == DateTime.now().day) {
              return sum! + meal.protein;
            }
            return sum;
          }) ?? 0;
        });
      } catch (e) {
        debugPrint("Error opening meal box for user ${user.id}: $e");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ValueListenableBuilder(
          valueListenable: nutritionBox.listenable(),
          builder: (context, Box<UserNutrition> box, _) {
            List<UserNutrition> nutritionList = box.values.toList();

            if (nutritionList.isEmpty) {
              return Center(
                child: Text(
                  'No Data Available',
                  style: GoogleFonts.inter(fontSize: 18),
                ),
              );
            }

            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  UserSelectionDropdown(
                    nutritionList: nutritionList,
                    selectedUser: selectedUser,
                    onUserSelected: _onUserSelected,
                  ),
                  const SizedBox(height: 20),
                  if (selectedUser != null) ...[
                    NutritionGoalCard(
                      user: selectedUser!,
                      totalKcalToday: totalKcalToday,
                      totalProteinToday: totalProteinToday,
                    ),
                    Padding(
                       padding: EdgeInsets.only(left: 10.0,top: 10.0),
                        child: Text('Records', style: GoogleFonts.inter(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),),
                    ),
                    MessageDisplay(
                      message: message,
                      messageColor: messageColor,
                    ),
                    ..._groupMealsByDate().entries.map((entry) {
                      final date = entry.key;
                      final meals = entry.value;

                      double dailyKcal = meals.fold(0, (sum, meal) => sum + meal.kcal);
                      double dailyProtein = meals.fold(0, (sum, meal) => sum + meal.protein);

                      bool isCurrentDay = DateFormat.yMMMd().format(DateTime.now()) == date;

                      String dailyMessage = checkAchievement(dailyKcal, dailyProtein, selectedUser!, isCurrentDay);

                      return MealGroupCard(
                        date: date,
                        dailyMessage: dailyMessage,
                        dailyKcal: dailyKcal,
                        dailyProtein: dailyProtein,
                        meals: meals,
                      );
                    }).toList(),
                  ],
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  String checkAchievement(double dailyKcal, double dailyProtein, UserNutrition user, bool isCurrentDay) {
    if (isCurrentDay) {
      if (dailyKcal >= user.kcal && dailyProtein >= user.protein) {
        return "Goal Achieved!";
      } else if (dailyKcal >= user.kcal && dailyProtein < user.protein) {
        return "Low Protein";
      } else if (dailyKcal < user.kcal && dailyProtein >= user.protein) {
        return "Low kcal";
      } else {
        return "Keep going";
      }
    } else {
      if (dailyKcal < user.kcal || dailyProtein < user.protein) {
        return "Failed";
      } else {
        return "Goal Achieved!";
      }
    }
  }
  // Group meals by date
  Map<String, List<AddMealBox>> _groupMealsByDate() {
    final groupedMeals = <String, List<AddMealBox>>{};
    final today = DateTime.now();

    if (mealBox == null) return groupedMeals;

    for (var meal in mealBox!.values) {
      final formattedDate = DateFormat.yMMMd().format(meal.timestamp);
      if (!groupedMeals.containsKey(formattedDate)) {
        groupedMeals[formattedDate] = [];
      }
      groupedMeals[formattedDate]?.add(meal);
    }

    return groupedMeals;
  }
}
