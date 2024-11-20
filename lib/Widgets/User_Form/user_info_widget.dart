import 'package:flutter/material.dart';
import '../../Utils/constants.dart';

class UserFormWidget extends StatefulWidget {
  const UserFormWidget({Key? key}) : super(key: key);

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

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Name input
        Padding(
          padding: const EdgeInsets.only(left: 15.0, right: 15.0, top: 10.0),
          child: TextField(
            controller: nameController,
            decoration: const InputDecoration(
              hintText: 'Name',
              border: OutlineInputBorder(),
            ),
          ),
        ),
        // Height input
        Padding(
          padding: const EdgeInsets.only(left: 15.0, right: 15.0, top: 10.0),
          child: TextField(
            controller: heightController,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              hintText: 'Height (in cm)',
              border: OutlineInputBorder(),
            ),
          ),
        ),
        // Weight input
        Padding(
          padding: const EdgeInsets.only(left: 15.0, right: 15.0, top: 10.0),
          child: TextField(
            controller: weightController,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              hintText: 'Weight (in kg)',
              border: OutlineInputBorder(),
            ),
          ),
        ),
        // Age input
        Padding(
          padding: const EdgeInsets.only(left: 15.0, right: 15.0, top: 10.0),
          child: TextField(
            controller: ageController,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              hintText: 'Age',
              border: OutlineInputBorder(),
            ),
          ),
        ),
        // Gender selection
        Padding(
          padding: const EdgeInsets.only(left: 15.0, right: 15.0, top: 10.0),
          child: DropdownButtonFormField<String>(
            value: selectedGender,
            decoration: const InputDecoration(
              hintText: 'Gender',
              border: OutlineInputBorder(),
            ),
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
            decoration: const InputDecoration(
              hintText: 'Activity Level',
              border: OutlineInputBorder(),
            ),
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
      Padding(
          padding: const EdgeInsets.only(left: 15.0, right: 15.0, top: 10.0),
          child: ElevatedButton(
            style: ButtonStyle(
              backgroundColor: WidgetStateProperty.all<Color>(Colors.blue),
              minimumSize: WidgetStateProperty.all(const Size(200, 50)),
            ),
            onPressed: () {
              // Add functionality when the button is pressed
              print("Name: ${nameController.text}");
              print("Height: ${heightController.text}");
              print("Weight: ${weightController.text}");
              print("Age: ${ageController.text}");
              print("Activity: $selectedActivity");
            },
            child: Center(
              child: Text('Check', style: appFont),
            ),
          ),
        ),
      ],
    );
  }

  // Return values for calculation
  Map<String, dynamic> getUserData() {
    return {
      'name': nameController.text,
      'height': int.tryParse(heightController.text) ?? 0,
      'weight': int.tryParse(weightController.text) ?? 0,
      'age': int.tryParse(ageController.text) ?? 0,
      'activityLevel': selectedActivity,
      'gender': selectedGender,
    };
  }
}
