import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

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
                  height: 185,  // Adjusted height to fit the table
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Stack(
                      children: [
                        // Column for greeting and table content
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Displaying the greeting message with the name
                            Text(
                              'Hello, ${userData!['name']}! You need to consume:',
                              style: GoogleFonts.inter(
                                fontSize: 13,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                            const SizedBox(height: 10),

                            // Table with "Calories" and "Protein" as header
                            Table(
                              children: [
                                // Header row for the table
                                TableRow(
                                  decoration: BoxDecoration(
                                    color: Colors.grey[200],  // Background color for header row
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
                                // Data row for the table
                                TableRow(
                                  children: [
                                    Center(
                                      child: Padding(
                                        padding: const EdgeInsets.all(5.0),
                                        child: Text(
                                          '${calculationResults!['Calorie']?.join(' - ')}',
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
                                          '${calculationResults!['Protein']?.join(' - ')}',
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
                                  minimumSize: WidgetStateProperty.all(Size(0, 0)),
                                  maximumSize: WidgetStateProperty.all(Size(150, 30))
                                ),
                                  onPressed: (){},
                                  child: const Center(
                                    child: Text("Save", style: TextStyle(color: Colors.white),),
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
