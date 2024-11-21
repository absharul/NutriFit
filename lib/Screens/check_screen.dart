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
                margin: const EdgeInsets.all(16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.9,
                  height: 200,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Hello, ${userData!['name']}!',
                          style: GoogleFonts.inter(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          'Calories: ${calculationResults!['Calorie']?.join(' - ')}',
                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.black,
                          ),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          'Protein: ${calculationResults!['Protein']?.join(' - ')}',
                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.black,
                          ),
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
