import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/adapters.dart';
import '../Hive/UserNutrition/user_nutrition.dart'; // Import your UserNutrition class
import '../Hive/Meals/user_meals.dart'; // Import your AddMealBox class for meals
import 'package:intl/intl.dart';

class ProgressScreen extends StatefulWidget {
  const ProgressScreen({super.key});

  @override
  State<ProgressScreen> createState() => _ProgressScreenState();
}

class _ProgressScreenState extends State<ProgressScreen> {
  late Box<UserNutrition> nutritionBox; // Define the box for UserNutrition
  Box<AddMealBox>? mealBox; // Make mealBox nullable
  UserNutrition? selectedUser; // The currently selected user
  double totalKcal = 0; // Total calories consumed by the user
  double totalProtein = 0; // Total protein consumed by the user

  @override
  void initState() {
    super.initState();
    // Open the Hive boxes
    nutritionBox = Hive.box<UserNutrition>('userNutrition');
  }

  // Function to handle user selection from the dropdown
  void _onUserSelected(UserNutrition? user) async {
    setState(() {
      selectedUser = user; // Update the selected user
      totalKcal = 0; // Reset total kcal when user changes
      totalProtein = 0; // Reset total protein when user changes
    });

    if (user != null) {
      // Open the meal box for the selected user
      try {
        mealBox = await Hive.openBox<AddMealBox>(
            user.id); // Use user ID to get their specific meal box

        // Calculate the total kcal and protein after the box is opened
        setState(() {
          totalKcal = mealBox!.values.fold(0, (sum, meal) => sum + meal.kcal);
          totalProtein =
              mealBox!.values.fold(0, (sum, meal) => sum + meal.protein);
        });
      } catch (e) {
        debugPrint("Error opening meal box for user ${user.id}: $e");
      }
    }
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
      body: ValueListenableBuilder(
        valueListenable: nutritionBox.listenable(),
        builder: (context, Box<UserNutrition> box, _) {
          // Get the list of UserNutrition items from the box
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

                  // Display the meals for the selected user
                  const SizedBox(height: 20),
                  Text(
                    "Meals:",
                    style: GoogleFonts.inter(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 8),
                  // List the meals for the selected user
                  // Expanded(
                  //   child: ListView.builder(
                  //     itemCount: mealBox?.length ?? 0, // Handle null safely
                  //     itemBuilder: (context, index) {
                  //       final meal = mealBox?.getAt(index);
                  //       return Card(
                  //         margin: const EdgeInsets.symmetric(vertical: 5),
                  //         elevation: 4,
                  //         shape: RoundedRectangleBorder(
                  //           borderRadius: BorderRadius.circular(12),
                  //         ),
                  //         child: ListTile(
                  //           title: Text(meal?.mealname ?? ''),
                  //           subtitle: Text(
                  //               'Calories: ${meal?.kcal}, Protein: ${meal?.protein}g'),
                  //         ),
                  //       );
                  //     },
                  //   ),
                  // ),// Import for date formatting
                  Expanded(
                    child: ListView.builder(
                      itemCount: mealBox?.length ?? 0, // Handle null safely
                      itemBuilder: (context, index) {
                        final meal = mealBox?.getAt(index);
                        if (meal == null)
                          return SizedBox(); // Handle null meal data

                        // Format the timestamp if available
                        String formattedDate = '';
                        if (meal.timestamp != null) {
                          formattedDate = DateFormat('dd MMM h:mm a')
                              .format(meal.timestamp!);
                        }

                        return Card(
                          margin: const EdgeInsets.symmetric(vertical: 5),
                          elevation: 4,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: ListTile(
                            title: Stack(
                              children: [
                                Text(meal.mealname ?? '',
                                    style: GoogleFonts.inter(fontSize: 16)),
                                Positioned(
                                  top: 0,
                                  right: 0,
                                  child: Text(
                                    formattedDate, // Display formatted date
                                    style: GoogleFonts.inter(
                                      fontSize: 12,
                                      color: Colors.grey[700],
                                      fontStyle: FontStyle.italic,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            subtitle: Text(
                                'Calories: ${meal.kcal}, Protein: ${meal.protein}g',
                                style: GoogleFonts.inter(fontSize: 14)),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ],
            ),
          );
        },
      ),
    );
  }
}
