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
                  height: 185,
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Stack(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Hello, ${userData!['name']}! You need to consume minimum',
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
                                          '${calculationResults!['Calorie']?.first ?? 0}',
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
                                          '${calculationResults!['Protein']?.first ?? 0}',
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
                                  backgroundColor:
                                      WidgetStateProperty.all<Color>(
                                          Colors.blue),
                                  minimumSize:
                                      WidgetStateProperty.all(const Size(0, 0)),
                                  maximumSize: WidgetStateProperty.all(
                                      const Size(150, 30)),
                                ),
                                onPressed: () {
                                  final kcal =
                                      calculationResults?['Calorie']?.first ??
                                          0;
                                  final protein = calculationResults?['Protein']
                                          ?.first
                                          .toDouble() ??
                                      0.0;
                                  String userId = userData?['name'] ??
                                      DateTime.now().toString();

                                  final newData = UserNutrition(
                                    id: userId,
                                    name: userData?['name']?.trim() ??
                                        'Unnamed User',
                                    kcal: kcal,
                                    protein: protein,
                                  );

                                  if (nutritionBox
                                      .containsKey(newData.name.trim())) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text("User Already Exists"),
                                        duration: Duration(seconds: 2),
                                        backgroundColor: Colors.red,
                                      ),
                                    );
                                  } else {
                                    nutritionBox.put(
                                        newData.name.trim(), newData);
                                    print(
                                        'Data added to Hive: ${newData.name}');
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text(
                                            "${newData.name} Goal is Set",
                                            style:
                                                TextStyle(color: Colors.white)),
                                        duration: const Duration(seconds: 2),
                                        backgroundColor: Colors.green,
                                      ),
                                    );
                                  }
                                },
                                child: const Center(
                                  child: Text(
                                    "SET GOAL",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              ),
                            )
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
