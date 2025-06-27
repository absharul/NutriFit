import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import '../../Hive/Meals/user_meals.dart';
import '../../Hive/UserNutrition/user_nutrition.dart';

class AddMealDialog extends StatefulWidget {
  final UserNutrition userNutrition;
  const AddMealDialog({super.key, required this.userNutrition});

  @override
  _AddMealDialogState createState() => _AddMealDialogState();
}

class _AddMealDialogState extends State<AddMealDialog> {
  final _mealController = TextEditingController();
  final _kcalController = TextEditingController();
  final _proteinController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  UserNutrition? selectedUser;
  List<UserNutrition> usersList = [];
  @override
  void initState() {
    super.initState();
    _loadUsers();
  }

  Future<void> _loadUsers() async {
    var userBox = await Hive.openBox<UserNutrition>('userNutrition');
    setState(() {
      usersList = userBox.values.toList();
      selectedUser = widget.userNutrition;
    });
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.black87,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
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
                              style: const TextStyle(color: Colors.white),
                            ),
                          );
                        }).toList(),
                        decoration: InputDecoration(
                          labelText: 'Select User',
                          labelStyle: const TextStyle(color: Colors.white),
                          hintText: 'Choose the user',
                          hintStyle: const TextStyle(color: Colors.white60),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide:
                                const BorderSide(color: Colors.blueAccent),
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 12),
                        ),
                        style: const TextStyle(color: Colors.white),
                        iconEnabledColor: Colors.white,
                        dropdownColor: Colors.black,
                        validator: (value) {
                          if (value == null) {
                            return 'Please select a user';
                          }
                          return null;
                        },
                      )),
            Padding(
              padding: const EdgeInsets.only(bottom: 16.0),
              child: TextFormField(
                controller: _mealController,
                decoration: InputDecoration(
                  labelText: 'Meal Name',
                  labelStyle: const TextStyle(color: Colors.white),
                  hintText: 'Enter the name of the meal',
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
                    return 'Please enter a meal name';
                  }
                  return null;
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 16.0),
              child: TextFormField(
                controller: _kcalController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Calories',
                  labelStyle: const TextStyle(color: Colors.white),
                  hintText: 'Enter calories',
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
                    return 'Please enter calories';
                  }
                  if (int.tryParse(value) == null) {
                    return 'Please enter a valid number';
                  }
                  return null;
                },
              ),
            ),
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
                Navigator.of(context).pop();
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
                  final mealName = _mealController.text;
                  final kcal = int.parse(_kcalController.text);
                  final protein = double.parse(_proteinController.text);

                  final newMeal = AddMealBox(
                    mealname: mealName,
                    kcal: kcal,
                    protein: protein,
                    timestamp: DateTime.now(),
                  );

                  if (selectedUser != null) {
                    var userMealBox =
                        await Hive.openBox<AddMealBox>(selectedUser!.id);

                    await userMealBox.add(newMeal);

                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text(
                          'Meal added successfully!',
                          style: TextStyle(color: Colors.white),
                        ),
                        backgroundColor: Colors.green,
                        duration: Duration(seconds: 2),
                        behavior: SnackBarBehavior.fixed,
                        shape: RoundedRectangleBorder(),
                      ),
                    );

                    Navigator.of(context).pop();
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
              child: const Text(
                'Add',
                style: TextStyle(fontSize: 16, color: Colors.black),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
