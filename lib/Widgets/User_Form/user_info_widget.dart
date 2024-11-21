import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../Services/Calucations/calculation_helper.dart';
import '../../Utils/constants.dart';


class UserFormWidget extends StatefulWidget {
  const UserFormWidget({Key? key, required this.onFormSubmit}) : super(key: key);

  final void Function(Map<String, dynamic>, Map<String, List<int>>) onFormSubmit;

  @override
  _UserFormWidgetState createState() => _UserFormWidgetState();
}

class _UserFormWidgetState extends State<UserFormWidget> {
  // Controllers for form fields
  TextEditingController nameController = TextEditingController();
  TextEditingController heightController = TextEditingController();
  TextEditingController weightController = TextEditingController();
  TextEditingController ageController = TextEditingController();

  // Default values
  String selectedActivity = "Sedentary";
  String selectedGender = "Male";

  final _formKey = GlobalKey<FormState>(); // Global key for form validation

  // Form Validation
  bool _validateForm() {
    if (!_formKey.currentState!.validate()) {
      return false; // If validation fails, return false
    }
    return true; // If all fields are valid, return true
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          // Name input
          Padding(
            padding: const EdgeInsets.only(left: 15.0, right: 15.0, top: 10.0),
            child: TextFormField(
              controller: nameController,
              decoration:  InputDecoration(
                hintText: 'Name',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15)
                ),
              ),
              style: const TextStyle(fontSize: 12.0),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your name';
                }
                return null;
              },
            ),
          ),
          // Height input
          Padding(
            padding: const EdgeInsets.only(left: 15.0, right: 15.0, top: 10.0),
            child: TextFormField(
              controller: heightController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                hintText: 'Height (in cm)',
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15)
                ),
              ),
              style: const TextStyle(fontSize: 12.0),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your height';
                }
                if (int.tryParse(value) == null) {
                  return 'Please enter a valid number for height';
                }
                return null;
              },
            ),
          ),
          // Weight input
          Padding(
            padding: const EdgeInsets.only(left: 15.0, right: 15.0, top: 10.0),
            child: TextFormField(
              controller: weightController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                hintText: 'Weight (in kg)',
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15)
                ),
              ),
              style: const TextStyle(fontSize: 12.0),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your weight';
                }
                if (int.tryParse(value) == null) {
                  return 'Please enter a valid number for weight';
                }
                return null;
              },
            ),
          ),
          // Age input
          Padding(
            padding: const EdgeInsets.only(left: 15.0, right: 15.0, top: 10.0),
            child: TextFormField(
              controller: ageController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                hintText: 'Age',
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15)
                ),
              ),
              style: const TextStyle(fontSize: 12.0),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your age';
                }
                if (int.tryParse(value) == null) {
                  return 'Please enter a valid number for age';
                }
                return null;
              },
            ),
          ),
          // Gender selection
          Padding(
            padding: const EdgeInsets.only(left: 15.0, right: 15.0, top: 10.0),
            child: DropdownButtonFormField<String>(
              value: selectedGender,
              decoration:  InputDecoration(
                hintText: 'Gender',
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15)
                ),
              ),
              style: const TextStyle(fontSize: 12.0,color: Colors.black),
              onChanged: (String? newValue) {
                setState(() {
                  selectedGender = newValue!;
                });
              },
              items: ["Male", "Female"]
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
          ),
          // Activity level selection
          Padding(
            padding: const EdgeInsets.only(left: 15.0, right: 15.0, top: 10.0),
            child: DropdownButtonFormField<String>(
              value: selectedActivity,
              decoration:  InputDecoration(
                hintText: 'Activity Level',
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15)
                ),
              ),
              style: const TextStyle(fontSize: 12.0,color: Colors.black),
              onChanged: (String? newValue) {
                setState(() {
                  selectedActivity = newValue!;
                });
              },
              items: ["Sedentary", "LightlyActive", "ModeratelyActive", "VeryActive"]
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
          ),
          // Submit Button
          Padding(
            padding: const EdgeInsets.only(left: 15.0, right: 15.0, top: 10.0),
            child: ElevatedButton(
              style: ButtonStyle(
                backgroundColor: WidgetStateProperty.all<Color>(Colors.blue),
                minimumSize: WidgetStateProperty.all(const Size(50, 40)),
                maximumSize: WidgetStateProperty.all(const Size(150, 40))
              ),
              onPressed: () {
                if (_validateForm()) {
                  Map<String, dynamic> userData = getUserData();
                  Map<String, List<int>> results = calculateCaloriesAndProtein(
                    age: userData['age'],
                    activityLevel: ActivityLevel.values.firstWhere(
                          (e) => e.toString().split('.').last == userData['activityLevel'],
                    ),
                    gender: userData['gender'],
                    height: userData['height'],
                    weight: userData['weight'],
                  );
                  widget.onFormSubmit(userData, results); // Pass data to parent widget
                }
              },
              child: Center(
                child: Text('Check', style: appFont),
            ),
          ),
          ),
        ],
      ),
    );
  }

  Map<String, dynamic> getUserData() {
    final userData = {
      'name': nameController.text,
      'height': int.tryParse(heightController.text) ?? 0,
      'weight': int.tryParse(weightController.text) ?? 0,
      'age': int.tryParse(ageController.text) ?? 0,
      'activityLevel': selectedActivity,
      'gender': selectedGender,
    };

    print('User Data: $userData');  // Debugging line
    return userData;
  }

}
