import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../Widgets/User_Form/user_info_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.redAccent,
        title: Text(
          "NutriFit",
          style: GoogleFonts.inter(
              fontSize: 40,
              color: Colors.white,
              fontStyle: FontStyle.italic,
              fontWeight: FontWeight.bold),
        ),
      ),
      body: const Column(
        children: [
          UserFormWidget(),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Action for FAB
        },
        shape: const CircleBorder(),
        backgroundColor: Colors.blue,
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        color: Colors.redAccent,
        shape: const CircularNotchedRectangle(),
        notchMargin: 8.0,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            TweenAnimationBuilder(
              tween: Tween<double>(
                  begin: 1.0, end: _selectedIndex == 0 ? 1.2 : 1.0),
              duration: const Duration(milliseconds: 100),
              builder: (context, scale, child) {
                return IconButton(
                  icon: AnimatedContainer(
                    duration: const Duration(milliseconds: 100),
                    curve: Curves.easeOut,
                    transform: Matrix4.identity()..scale(scale),
                    child: const Icon(
                      Icons.home,
                      color: Colors.white,
                      size: 30,
                    ),
                  ),
                  onPressed: () {
                    _onItemTapped(0);
                  },
                );
              },
            ),

            const SizedBox(width: 48), // Space for the FAB

            // Account Icon with animation (Scale, Bounce, and Shadow)
            TweenAnimationBuilder(
              tween: Tween<double>(
                  begin: 1.0, end: _selectedIndex == 1 ? 1.2 : 1.0),
              duration: const Duration(milliseconds: 100),
              builder: (context, scale, child) {
                return IconButton(
                  icon: AnimatedContainer(
                    duration: const Duration(milliseconds: 100),
                    curve: Curves.easeOut,
                    transform: Matrix4.identity()..scale(scale),
                    child: Icon(
                      Icons.account_circle,
                      color: Colors.white,
                      size: 30,
                    ),
                  ),
                  onPressed: () {
                    _onItemTapped(1);
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
