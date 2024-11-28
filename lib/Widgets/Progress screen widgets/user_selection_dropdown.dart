import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../Hive/UserNutrition/user_nutrition.dart';

class UserSelectionDropdown extends StatelessWidget {
  final List<UserNutrition> nutritionList;
  final UserNutrition? selectedUser;
  final ValueChanged<UserNutrition?> onUserSelected;

  const UserSelectionDropdown({
    Key? key,
    required this.nutritionList,
    required this.selectedUser,
    required this.onUserSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
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
          onChanged: onUserSelected,
          isExpanded: true,
          items: nutritionList.map((user) {
            return DropdownMenuItem<UserNutrition>(
              value: user,
              child: Text(user.name),
            );
          }).toList(),
        ),
      ],
    );
  }
}