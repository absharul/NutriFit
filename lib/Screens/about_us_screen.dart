import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class AboutUsScreen extends StatefulWidget {
  const AboutUsScreen({super.key});

  @override
  State<AboutUsScreen> createState() => _AboutUsScreenState();
}

class _AboutUsScreenState extends State<AboutUsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(
          "NutriFit",
          style: GoogleFonts.inter(
            fontSize: 40,
            color: Colors.white,
            fontStyle: FontStyle.italic,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            // Introduction Section
            Padding(
              padding: const EdgeInsets.only(bottom: 16.0),
              child: Text(
                "Welcome to NutriFit",
                style: GoogleFonts.roboto(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 16.0),
              child: Text(
                "NutriFit is your personal fitness companion that helps you manage your diet, fitness routines, and track your progress. Our goal is to empower you to lead a healthy lifestyle through personalized nutrition plans and exercise recommendations.",
                style: GoogleFonts.roboto(fontSize: 16, color: Colors.black54),
                textAlign: TextAlign.justify,
              ),
            ),

            // Terms & Conditions Section
            Padding(
              padding: const EdgeInsets.only(bottom: 16.0),
              child: Text(
                "Terms & Conditions",
                style: GoogleFonts.roboto(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 16.0),
              child: Text(
                "By using NutriFit, you agree to our Terms & Conditions. These terms govern your use of the app and its features. Please review the full Terms & Conditions document by clicking the link below.",
                style: GoogleFonts.roboto(fontSize: 16, color: Colors.black54),
                textAlign: TextAlign.justify,
              ),
            ),
            TextButton(
              onPressed: () {
                // Navigate to Terms & Conditions page or web link
                print("Redirecting to Terms & Conditions");
              },
              child: Text(
                "Read Full Terms & Conditions",
                style: GoogleFonts.roboto(fontSize: 16, color: Colors.blue),
              ),
            ),

            // Privacy Policy Section
            Padding(
              padding: const EdgeInsets.only(bottom: 16.0),
              child: Text(
                "Privacy Policy",
                style: GoogleFonts.roboto(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 16.0),
              child: Text(
                "Your privacy is important to us. We collect certain data to improve your experience. By using NutriFit, you consent to our Privacy Policy. Please review the full Privacy Policy document by clicking the link below.",
                style: GoogleFonts.roboto(fontSize: 16, color: Colors.black54),
                textAlign: TextAlign.justify,
              ),
            ),
            TextButton(
              onPressed: () {
                // Navigate to Privacy Policy page or web link
                print("Redirecting to Privacy Policy");
              },
              child: Text(
                "Read Full Privacy Policy",
                style: GoogleFonts.roboto(fontSize: 16, color: Colors.blue),
              ),
            ),

            // Contact Information Section
            Padding(
              padding: const EdgeInsets.only(bottom: 16.0),
              child: Text(
                "Contact Us",
                style: GoogleFonts.roboto(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 16.0),
              child: Text(
                "For any inquiries, feedback, or support, feel free to reach out to us.",
                style: GoogleFonts.roboto(fontSize: 16, color: Colors.black54),
                textAlign: TextAlign.justify,
              ),
            ),
            TextButton(
              onPressed: () {
                // Handle contact action (e.g., navigate to contact form or email)
                print("Redirecting to contact us page");
              },
              child: Text(
                "Contact Us",
                style: GoogleFonts.roboto(fontSize: 16, color: Colors.blue),
              ),
            ),

            // Footer Section with Social Media Links
            Padding(
              padding: const EdgeInsets.only(top: 16.0),
              child: Divider(
                color: Colors.black12,
                thickness: 1.0,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    icon: const Icon(Icons.facebook, color: Colors.blue,size: 30.0,),
                    onPressed: () {
                      // Handle Facebook link
                      print("Redirecting to Facebook");
                    },
                  ),
                  IconButton(
                    icon: PhosphorIcon(
                      PhosphorIcons.xLogo(),
                      color: Colors.black,
                      size: 30.0,
                    ),
                    onPressed: () {
                      // Handle Twitter link
                      print("Redirecting to Twitter");
                    },
                  ),
                  IconButton(
                    icon: PhosphorIcon(
                      PhosphorIcons.instagramLogo(),
                      color: Colors.pink,
                      size: 30.0,
                    ),
                    onPressed: () {
                      // Handle Instagram link
                      print("Redirecting to Instagram");
                    },
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Center(
                child: Text(
                  "© 2024 NutriFit. All rights reserved.",
                  style: GoogleFonts.roboto(fontSize: 14, color: Colors.black54),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
