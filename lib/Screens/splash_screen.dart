import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

 @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer( Duration(seconds: 3), () {
      context.go('/homescreen');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
          child: Text("NutriFit", style: GoogleFonts.inter(
            fontSize: 40,
            color: Colors.white,
            fontStyle: FontStyle.italic,
            fontWeight: FontWeight.bold
          ),),
        ),
    );
  }
}
