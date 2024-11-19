import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../Utils/constants.dart';

class UserFormWidget extends StatelessWidget {
  const UserFormWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Padding(
          padding: EdgeInsets.all(10.0),
          child: TextField(
            decoration:
                InputDecoration(hintText: 'Name', border: OutlineInputBorder()),
          ),
        ),
        const Padding(
          padding: EdgeInsets.all(10.0),
          child: TextField(
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
                hintText: 'Height (in cm)', border: OutlineInputBorder()),
          ),
        ),
        const Padding(
          padding: EdgeInsets.all(10.0),
          child: TextField(
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
                hintText: 'Weight', border: OutlineInputBorder()),
          ),
        ),
        const Padding(
          padding: EdgeInsets.all(10.0),
          child: TextField(
            keyboardType: TextInputType.number,
            decoration:
                InputDecoration(hintText: 'Age', border: OutlineInputBorder()),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: ElevatedButton(
            style: ButtonStyle(
              backgroundColor: WidgetStateProperty.all<Color>(
                  Colors.blue),
              maximumSize: WidgetStateProperty.all(Size(200, 50))
            ),
            onPressed: () {},
            child: Center(child: Text('Check', style: appFont)),
          ),
        ),
      ],
    );
  }
}
