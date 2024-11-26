import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/adapters.dart';
import '../Hive/UserNutrition/user_nutrition.dart';
import '../Hive/Meals/user_meals.dart';
import 'package:intl/intl.dart';

class ProgressScreen extends StatefulWidget {
  const ProgressScreen({super.key});

  @override
  State<ProgressScreen> createState() => _ProgressScreenState();
}

class _ProgressScreenState extends State<ProgressScreen> {
  late Box<UserNutrition> nutritionBox;
  Box<AddMealBox>? mealBox;
  UserNutrition? selectedUser;
  double totalKcal = 0;
  double totalProtein = 0;
  bool showMessage = false;
  String message = '';
  Color messageColor = Colors.transparent;
  bool isCelebration = false;
  bool showMealDetails = false; // Track if meal details are expanded

  @override
  void initState() {
    super.initState();
    nutritionBox = Hive.box<UserNutrition>('userNutrition');
  }

  void _onUserSelected(UserNutrition? user) async {
    setState(() {
      selectedUser = user;
      totalKcal = 0;
      totalProtein = 0;
      showMessage = false; // Reset message visibility
      message = ''; // Reset message
      messageColor = Colors.transparent; // Reset color
      isCelebration = false; // Reset celebration flag
      showMealDetails = false; // Reset meal detail expansion
    });

    if (user != null) {
      try {
        mealBox = await Hive.openBox<AddMealBox>(user.id);
        setState(() {
          totalKcal = mealBox!.values.fold(0, (sum, meal) => sum + meal.kcal);
          totalProtein = mealBox!.values.fold(0, (sum, meal) => sum + meal.protein);
        });

        _checkGoalAchievement(user);
      } catch (e) {
        debugPrint("Error opening meal box for user ${user.id}: $e");
      }
    }
  }

  void _checkGoalAchievement(UserNutrition user) {
    if (totalKcal >= user.kcal && totalProtein >= user.protein) {
      setState(() {
        message = "Goal Achieved!";
        messageColor = Colors.green; // Success color
      });
      _showMessageForDuration();
    } else if (totalKcal >= user.kcal && totalProtein < user.protein) {
      setState(() {
        message = "You're losing muscle!";
        messageColor = Colors.red; // Warning color for muscle loss
      });
      _showMessageForDuration();
    } else if (totalProtein >= user.protein && totalKcal < user.kcal) {
      setState(() {
        message = "You're losing energy!";
        messageColor = Colors.orange; // Warning color for energy loss
      });
      _showMessageForDuration();
    }
  }

  // Function to show message for 2 seconds
  void _showMessageForDuration() {
    Future.delayed(Duration(seconds: 2), () {
      setState(() {
        showMessage = false; // Hide message after 2 seconds
      });
    });

    setState(() {
      showMessage = true; // Show message immediately
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(
          "NutriFit",
          style: GoogleFonts.inter(
            fontSize: 40,
            color: Colors.white,
            fontStyle: FontStyle.italic,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Stack(
        children: [
          // The main UI for the progress screen
          ValueListenableBuilder(
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

              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Dropdown to select the user
                    Text(
                      "Select User:",
                      style: GoogleFonts.inter(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 8),
                    DropdownButton<UserNutrition>(
                      hint: const Text('Select a user'),
                      value: selectedUser,
                      onChanged: _onUserSelected,
                      isExpanded: true,
                      items: nutritionList.map((user) {
                        return DropdownMenuItem<UserNutrition>(
                          value: user,
                          child: Text(user.name),
                        );
                      }).toList(),
                    ),
                    const SizedBox(height: 20),

                    // Display selected user's nutritional information
                    if (selectedUser != null) ...[
                      Card(
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
                                "${selectedUser!.name}'s Nutrition Goal",
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
                                            '${selectedUser!.kcal}',
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
                                            '${selectedUser!.protein}',
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
                              const SizedBox(height: 20),

                              // Display total calories and protein consumed
                              Text(
                                'Total Calories Consumed: $totalKcal',
                                style: GoogleFonts.inter(
                                  fontSize: 16,
                                  color: Colors.black87,
                                ),
                              ),
                              Text(
                                'Total Protein Consumed: $totalProtein g',
                                style: GoogleFonts.inter(
                                  fontSize: 16,
                                  color: Colors.black87,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                    ],

                    // Wrap the meal cards in a single parent card
                    Expanded(
                      child: showMessage
                          ? GestureDetector(
                        onTap: () {
                          setState(() {
                            showMealDetails = !showMealDetails; // Toggle meal details
                          });
                        },
                        child: Card(
                          margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                          elevation: 6,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Display the status message on the top of the card
                              Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Text(
                                  message,
                                  style: GoogleFonts.inter(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: messageColor,
                                  ),
                                ),
                              ),
                              // Meal details (meal name + date) shown if tapped
                              if (showMealDetails)
                                ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: mealBox?.length ?? 0,
                                  itemBuilder: (context, index) {
                                    final meal = mealBox?.getAt(index);
                                    final formattedDate = DateFormat.yMMMd().format(meal?.timestamp ?? DateTime.now());
                                    return Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            meal?.mealname ?? 'Meal',
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
                                            'Calories: ${meal?.kcal}',
                                            style: GoogleFonts.inter(
                                              fontSize: 14,
                                              color: Colors.orange,
                                            ),
                                          ),
                                          Text(
                                            'Protein: ${meal?.protein}g',
                                            style: GoogleFonts.inter(
                                              fontSize: 14,
                                              color: Colors.green,
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                ),
                            ],
                          ),
                        ),
                      )
                          : ListView.builder(
                        itemCount: mealBox?.length ?? 0,
                        itemBuilder: (context, index) {
                          final meal = mealBox?.getAt(index);
                          final formattedDate = DateFormat.yMMMd().format(meal?.timestamp ?? DateTime.now());
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  meal?.mealname ?? 'Meal',
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
                                  'Calories: ${meal?.kcal}',
                                  style: GoogleFonts.inter(
                                    fontSize: 14,
                                    color: Colors.orange,
                                  ),
                                ),
                                Text(
                                  'Protein: ${meal?.protein}g',
                                  style: GoogleFonts.inter(
                                    fontSize: 14,
                                    color: Colors.green,
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

