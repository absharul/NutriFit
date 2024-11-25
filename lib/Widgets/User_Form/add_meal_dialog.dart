import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:nutrifit/Hive/Box/boxes.dart';
import '../../Hive/Meals/user_meals.dart';
import '../../Hive/UserNutrition/user_nutrition.dart';

class AddMealDialog extends StatefulWidget {
  final UserNutrition userNutrition; // The user for which we are adding meals

  AddMealDialog({required this.userNutrition});

  @override
  _AddMealDialogState createState() => _AddMealDialogState();
}

class _AddMealDialogState extends State<AddMealDialog> {
  final _mealController = TextEditingController();
  final _kcalController = TextEditingController();
  final _proteinController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  UserNutrition? selectedUser; // Variable to hold selected user
  List<UserNutrition> usersList = []; // List of all users from Hive

  @override
  void initState() {
    super.initState();
    _loadUsers();
  }

  // Load users from the Hive box
  Future<void> _loadUsers() async {
    var userBox = await Hive.openBox<UserNutrition>('userNutrition');
    setState(() {
      usersList = userBox.values.toList();
      selectedUser = widget.userNutrition; // Default to the passed user
    });
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.black87, // Slightly lighter black for contrast
      shape: RoundedRectangleBorder(
        borderRadius:
            BorderRadius.circular(20.0), // More rounded edges for a modern look
      ),
      title: const Text(
        'Add New Meal',
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 24,
          color: Colors.white,
        ),
      ),
      content: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Dropdown to select user
            Padding(
                padding: const EdgeInsets.only(bottom: 16.0),
                child: usersList.isEmpty
                    ? const CircularProgressIndicator()
                    : DropdownButtonFormField<UserNutrition>(
                        value: selectedUser,
                        onChanged: (UserNutrition? newUser) {
                          setState(() {
                            selectedUser = newUser;
                          });
                        },
                        items: usersList.map((UserNutrition user) {
                          return DropdownMenuItem<UserNutrition>(
                            value: user,
                            child: Text(
                              user.name,
                              style: TextStyle(
                                  color: Colors
                                      .white), // Text color for each dropdown item
                            ),
                          );
                        }).toList(),
                        decoration: InputDecoration(
                          labelText: 'Select User',
                          labelStyle: TextStyle(color: Colors.white),
                          hintText: 'Choose the user',
                          hintStyle: TextStyle(color: Colors.white60),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(color: Colors.blueAccent),
                          ),
                          contentPadding: EdgeInsets.symmetric(
                              horizontal: 16, vertical: 12),
                        ),
                        style: TextStyle(
                            color: Colors.white), // Selected item text color
                        iconEnabledColor:
                            Colors.white, // Set icon color to white
                        dropdownColor: Colors
                            .black, // Set dropdown background color to black
                        validator: (value) {
                          if (value == null) {
                            return 'Please select a user';
                          }
                          return null;
                        },
                      )),
            // Meal name field
            Padding(
              padding: const EdgeInsets.only(bottom: 16.0),
              child: TextFormField(
                controller: _mealController,
                decoration: InputDecoration(
                  labelText: 'Meal Name',
                  labelStyle: TextStyle(color: Colors.white),
                  hintText: 'Enter the name of the meal',
                  hintStyle: TextStyle(color: Colors.white60),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: Colors.blueAccent),
                  ),
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                ),
                style: TextStyle(color: Colors.white),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a meal name';
                  }
                  return null;
                },
              ),
            ),
            // Calories field
            Padding(
              padding: const EdgeInsets.only(bottom: 16.0),
              child: TextFormField(
                controller: _kcalController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Calories',
                  labelStyle: TextStyle(color: Colors.white),
                  hintText: 'Enter calories',
                  hintStyle: TextStyle(color: Colors.white60),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: Colors.blueAccent),
                  ),
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                ),
                style: TextStyle(color: Colors.white),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter calories';
                  }
                  if (int.tryParse(value) == null) {
                    return 'Please enter a valid number';
                  }
                  return null;
                },
              ),
            ),
            // Protein field
            Padding(
              padding: const EdgeInsets.only(bottom: 16.0),
              child: TextFormField(
                controller: _proteinController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Protein (g)',
                  labelStyle: const TextStyle(color: Colors.white),
                  hintText: 'Enter protein content',
                  hintStyle: const TextStyle(color: Colors.white60),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(color: Colors.blueAccent),
                  ),
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                ),
                style: const TextStyle(color: Colors.white),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter protein content';
                  }
                  if (int.tryParse(value) == null) {
                    return 'Please enter a valid number';
                  }
                  return null;
                },
              ),
            ),
          ],
        ),
      ),
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.redAccent,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              ),
              child: const Text('Cancel',
                  style: TextStyle(fontSize: 16, color: Colors.white)),
            ),
            const SizedBox(width: 20),
            ElevatedButton(
              onPressed: () async {
                if (_formKey.currentState?.validate() ?? false) {
                  // Retrieve entered values
                  final mealName = _mealController.text;
                  final kcal = int.parse(_kcalController.text);
                  final protein = double.parse(_proteinController.text);

                  // Create a new AddMealBox object
                  final newMeal = AddMealBox(mealname: mealName, kcal: kcal, protein: protein);

                  if (selectedUser != null) {
                    // Open the user's specific meal box
                    var userMealBox = await Hive.openBox<AddMealBox>(selectedUser!.id);

                    // Add the meal to the user-specific meal box
                    await userMealBox.add(newMeal);

                    // Optionally, you can return the meal data if needed
                    print('Meal added: $mealName, Calories: $kcal, Protein: $protein');

                    Navigator.of(context).pop(); // Close the dialog after saving
                  }
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.yellowAccent,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              ),
              child: const Text('Add',
                  style: TextStyle(fontSize: 16, color: Colors.black)),
            ),
          ],
        ),
      ],
    );
  }
}
