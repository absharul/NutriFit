import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nutrifit/Hive/Box/boxes.dart';
import '../Hive/UserNutrition/user_nutrition.dart';
import '../Widgets/User_Form/user_info_widget.dart';

class CheckScreen extends ConsumerStatefulWidget {
  const CheckScreen({super.key});

  @override
  ConsumerState<CheckScreen> createState() => _CheckScreenState();
}

class _CheckScreenState extends ConsumerState<CheckScreen> {
  Map<String, dynamic>? userData;
  Map<String, List<int>>? calculationResults;

  void _handleFormSubmit(
      Map<String, dynamic> userData, Map<String, List<int>> results) {
    print('Form Submitted');
    print('User Data: $userData');
    print('Calculation Results: $results');

    setState(() {
      this.userData = userData;
      this.calculationResults = results;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            UserFormWidget(onFormSubmit: _handleFormSubmit),
            if (userData != null && calculationResults != null) ...[
              Card(
                elevation: 5,
                margin: const EdgeInsets.all(5.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.9,
                  height: 185, // Adjusted height to fit the table
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Stack(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Hello, ${userData!['name']}! You need to consume:',
                              style: GoogleFonts.inter(
                                fontSize: 13,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                            const SizedBox(height: 10),

                            // Table with Calories and Protein
                            Table(
                              children: [
                                TableRow(
                                  decoration: BoxDecoration(
                                    color: Colors.grey[200],
                                  ),
                                  children: [
                                    Center(
                                      child: Padding(
                                        padding: const EdgeInsets.all(5.0),
                                        child: Text(
                                          'Calories(kcal)',
                                          style: GoogleFonts.inter(
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Center(
                                      child: Padding(
                                        padding: const EdgeInsets.all(5.0),
                                        child: Text(
                                          'Protein(g)',
                                          style: GoogleFonts.inter(
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black,
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
                                        padding: const EdgeInsets.all(5.0),
                                        child: Text(
                                          '${calculationResults!['Calorie']?.first ?? 0}', // Get the first value from the list
                                          style: const TextStyle(
                                            fontSize: 20,
                                            color: Colors.orange,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Center(
                                      child: Padding(
                                        padding: const EdgeInsets.all(5.0),
                                        child: Text(
                                          '${calculationResults!['Protein']?.first ?? 0}', // Get the first value from the list
                                          style: const TextStyle(
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
                            Center(
                              child: ElevatedButton(
                                style: ButtonStyle(
                                  backgroundColor: WidgetStateProperty.all<Color>(Colors.blue),
                                  minimumSize: WidgetStateProperty.all(const Size(0, 0)),
                                  maximumSize: WidgetStateProperty.all(const Size(150, 30)),
                                ),
                                onPressed: () {
                                  // Safely access the first value in the list, fallback to 0 if null
                                  final kcal = calculationResults?['Calorie']?.first ?? 0;
                                  final protein = calculationResults?['Protein']?.first.toDouble() ?? 0.0;
                                  String userId = userData!['name'] ?? DateTime.now().toString();
                                  // Create a new UserNutrition instance
                                  final newData = UserNutrition(
                                    id: userId,
                                    name: userData!['name']?.trim() ?? 'Unnamed User', // Trim any spaces in the name
                                    kcal: kcal,
                                    protein: protein,
                                  );

                                  // Check if the user already exists in the box by their name (using 'put' to store by key)
                                  if (nutritionBox.containsKey(newData.name)) {
                                    // Show SnackBar if the user already exists
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text("User Already Exists"),
                                        duration: Duration(seconds: 2),
                                      ),
                                    );
                                  } else {
                                    // Add new data to the Hive box using 'put' for unique key-based storage
                                    nutritionBox.put(newData.name, newData); // Use 'put' with the user's name as key
                                    print('Data added to Hive: ${newData.name}'); // Debug output
                                  }
                                },
                                child: const Center(
                                  child: Text(
                                    "SET GOAL",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
